#!/bin/bash
# Need a UTF-8 locale so bash's `.` in [[ =~ ]] matches characters, not bytes
# (the 🤖 / ○ / ✓ glyphs are multi-byte). Hooks may run with LC_ALL unset.
export LC_ALL=en_US.UTF-8

# Rename current tmux window to "🤖 <glyph> <label>".
# If the window already matches "🤖 <glyph> <rest>", swap the glyph and keep
# <rest> — so the user can manually rename the label and still get glyph
# updates from Notification/Stop hooks. If the user strips the 🤖 prefix
# entirely, leave the name alone (escape hatch). On SessionStart (force),
# build the name from $CLAUDE_PROJECT_DIR basename.

GLYPH="$1"
FORCE="$2" # pass "force" to override any current name (used by SessionStart)
[ -z "$TMUX_PANE" ] && exit 0
[ -z "$GLYPH" ] && exit 0

PROJECT=$(basename "${CLAUDE_PROJECT_DIR:-$PWD}")
CUR=$(tmux display-message -p -t "$TMUX_PANE" '#W' 2>/dev/null)

if [[ "$CUR" =~ ^🤖\ .\ (.+)$ ]]; then
	NEW="🤖 $GLYPH ${BASH_REMATCH[1]}"
elif [ "$FORCE" = "force" ] || [ -z "$CUR" ]; then
	NEW="🤖 $GLYPH $PROJECT"
else
	exit 0
fi

tmux rename-window -t "$TMUX_PANE" "$NEW" 2>/dev/null
exit 0
