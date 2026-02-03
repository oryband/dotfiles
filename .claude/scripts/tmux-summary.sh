#!/bin/bash
# Generate terminal title using Haiku - summarizes session on first prompt

# Recursion guard: exit if this is a nested claude call
[[ -n "$CLAUDE_SUMMARY_NESTED" ]] && exit 0

# Parse input
INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // empty')
PROMPT=$(echo "$INPUT" | jq -r '.prompt // empty')

# Cache setup
CACHE_DIR="/tmp/claude-tmux-summaries"
mkdir -p "$CACHE_DIR"
CACHE_FILE="$CACHE_DIR/$SESSION_ID"

# Helper: update tmux/terminal title
set_title() {
    local title="$1" pane="$2"
    # Try pane first, then detect tmux, then fall back to terminal escape
    if [[ -n "$pane" ]]; then
        idx=$(tmux display-message -p -t "$pane" '#I' 2>/dev/null)
        [[ -n "$idx" ]] && tmux rename-window -t "$idx" "🤖 ✳ $title" 2>/dev/null
    elif [[ -n "$TMUX" ]]; then
        tmux rename-window "🤖 ✳ $title" 2>/dev/null
    else
        printf '\033]0;🤖 ✳ %s\007' "$title"
    fi
}

# Helper: extract user messages from session file
get_session_context() {
    local session_file=$(find ~/.claude/projects -name "${SESSION_ID}.jsonl" 2>/dev/null | head -1)
    if [[ -f "$session_file" ]]; then
        jq -r 'select(.type == "user") | .message.content[]? | select(.type == "text") | .text' "$session_file" 2>/dev/null | head -c 2000
    fi
}

# Helper: validate summary (reject questions, meta-responses, too long)
is_valid() {
    local s="$1"
    [[ -n "$s" ]] && [[ ${#s} -le 45 ]] && \
    [[ "$s" != *"?"* ]] && [[ "$s" != *"context"* ]] && \
    [[ ! "$s" =~ ^I\ (need|don\'t|cannot|can\'t) ]]
}

# Check cache
CACHED=$(cat "$CACHE_FILE" 2>/dev/null)
if [[ -f "$CACHE_FILE" ]] && [[ "$CACHED" != "RETRY" ]]; then
    set_title "$CACHED" "$TMUX_PANE"
    exit 0
fi

# Fallback title (truncated prompt)
FALLBACK=$(echo "$PROMPT" | tr '\n' ' ' | cut -c1-40)

# Set immediate title, then generate summary in background
set_title "$FALLBACK" "$TMUX_PANE"

# Save pane for background process
SAVED_PANE="$TMUX_PANE"
SAVED_TMUX="$TMUX"

(
    # Unset TMUX vars so background claude doesn't interfere with parent session
    unset TMUX TMUX_PANE

    # Get context from session history or use prompt
    CONTEXT=$(get_session_context)
    [[ -z "$CONTEXT" ]] && CONTEXT="$PROMPT"

    # Generate summary with Haiku (no session persistence to avoid polluting session list)
    PROMPT="You are a title generator. Given a coding session transcript, output ONLY a short 3-5 word title describing the main topic. Rules: no punctuation, no quotes, no questions, no explanations - just the title words. Transcript: $CONTEXT"
    RAW=$(CLAUDE_SUMMARY_NESTED=1 claude -p "$PROMPT" --model haiku --no-session-persistence 2>/dev/null \
        | tr -d '\n' | sed 's/^\*\+//;s/\*\+$//' | cut -c1-50)

    if is_valid "$RAW"; then
        echo "$RAW" > "$CACHE_FILE"
        TITLE="$RAW"
    else
        TITLE="$FALLBACK"
    fi

    # Update title (use saved pane, restore TMUX for tmux commands)
    export TMUX="$SAVED_TMUX"
    set_title "$TITLE" "$SAVED_PANE"
) &

exit 0
