#!/bin/bash
# Rename current tmux window to "🤖 <glyph> <project>" — but only if the user
# hasn't manually renamed it. Tracks our last-set name in pane-local option
# @claude-name; if current name differs, the user took over and we leave it alone.

GLYPH="$1"
FORCE="$2"  # pass "force" to override manual renames (used by SessionStart)
[ -z "$TMUX_PANE" ] && exit 0
[ -z "$GLYPH" ] && exit 0

PROJECT=$(basename "${CLAUDE_PROJECT_DIR:-$PWD}")
NEW="🤖 $GLYPH $PROJECT"

LAST=$(tmux show-option -pqv -t "$TMUX_PANE" @claude-name 2>/dev/null)
CUR=$(tmux display-message -p -t "$TMUX_PANE" '#W' 2>/dev/null)

if [ "$FORCE" = "force" ] || [ -z "$LAST" ] || [ "$CUR" = "$LAST" ]; then
    tmux rename-window -t "$TMUX_PANE" "$NEW" 2>/dev/null
    tmux set-option -p -t "$TMUX_PANE" @claude-name "$NEW" 2>/dev/null
fi

exit 0
