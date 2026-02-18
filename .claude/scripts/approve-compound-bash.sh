#!/usr/bin/env bash
# PreToolUse hook: auto-approve compound/piped Bash commands.
#
# Claude Code's prefix matching evaluates the full command string as one unit,
# so "cd /path && git show ..." doesn't match "Bash(git *)".
# This hook parses compound commands using shfmt, checks each segment
# individually against your Bash permissions (both allow and deny lists),
# and auto-approves if ALL segments match the allowlist and NONE match
# the denylist. Deny takes precedence over allow.
#
# Based on AbdelrahmanHafez/claude-code-plus (MIT), with improvements:
#   - Supports both Bash(cmd *) and legacy Bash(cmd:*) permission formats
#   - Reads from all 3 settings layers (global, project shared, project local)
#   - Handles env var prefixes (VAR=val cmd), cd-prefixed commands, subshells
#   - Falls through (exit 0) on unknown commands — never denies, only approves
#
# Dependencies: bash 4+, shfmt, jq
#
# Install: Add to ~/.claude/settings.json under hooks.PreToolUse:
#   "PreToolUse": [{"matcher": "Bash", "hooks": [{"type": "command",
#     "command": "~/.claude/scripts/approve-compound-bash.sh"}]}]

set -euo pipefail

# Re-exec with modern bash if running old bash (mapfile requires 4+)
if [[ "${BASH_VERSINFO[0]}" -lt 4 ]]; then
  for try_bash in /opt/homebrew/bin/bash /usr/local/bin/bash /home/linuxbrew/.linuxbrew/bin/bash; do
    if [[ -x "$try_bash" ]]; then
      exec "$try_bash" "$0" "$@"
    fi
  done
  exit 0
fi

DEBUG=false

debug() {
  $DEBUG && echo "[approve-compound] $*" >&2
  return 0
}

# ---------------------------------------------------------------------------
# Permission extraction
# ---------------------------------------------------------------------------

# Extract command prefixes from a settings JSON file.
# Handles both formats:
#   Bash(git *)   -> "git"
#   Bash(git:*)   -> "git"        (legacy)
#   Bash(git log *) -> "git log"
# Usage: extract_prefixes_from_file <file> <allow|deny>
extract_prefixes_from_file() {
  local file="$1"
  local list="${2:-allow}"
  [[ -f "$file" ]] || return 0
  debug "Reading $list prefixes from: $file"
  jq -r ".permissions.${list}[]? // empty" "$file" 2>/dev/null \
    | grep -E '^Bash\(' \
    | sed -E 's/^Bash\(//; s/( \*|\*|:\*)\)$//'
}

# Find git root (handles worktrees)
find_git_root() {
  local toplevel git_dir git_common_dir
  toplevel=$(git rev-parse --show-toplevel 2>/dev/null) || return
  git_dir=$(git rev-parse --git-dir 2>/dev/null)
  git_common_dir=$(git rev-parse --git-common-dir 2>/dev/null)
  if [[ "$git_dir" != "$git_common_dir" ]]; then
    dirname "$git_common_dir"
  else
    echo "$toplevel"
  fi
}

# Collect unique prefixes from all settings layers
# Usage: get_prefixes <allow|deny>
get_prefixes() {
  local list="${1:-allow}"
  local git_root
  git_root=$(find_git_root 2>/dev/null || true)

  {
    # User global + local
    extract_prefixes_from_file "$HOME/.claude/settings.json" "$list"
    extract_prefixes_from_file "$HOME/.claude/settings.local.json" "$list"
    # Project shared + local (from git root or cwd)
    if [[ -n "$git_root" ]]; then
      extract_prefixes_from_file "$git_root/.claude/settings.json" "$list"
      extract_prefixes_from_file "$git_root/.claude/settings.local.json" "$list"
    else
      extract_prefixes_from_file ".claude/settings.json" "$list"
      extract_prefixes_from_file ".claude/settings.local.json" "$list"
    fi
  } | sort -u
}

# ---------------------------------------------------------------------------
# Command parsing (shfmt AST -> individual commands via jq)
# ---------------------------------------------------------------------------

read -r -d '' JQ_FILTER << 'JQEOF' || true
def get_part_value:
  if (type == "object" | not) then ""
  elif .Type == "Lit" then .Value // ""
  elif .Type == "DblQuoted" then
    "\"" + ([.Parts[]? | get_part_value] | join("")) + "\""
  elif .Type == "SglQuoted" then
    "'" + (.Value // "") + "'"
  elif .Type == "ParamExp" then
    "$" + (.Param.Value // "")
  elif .Type == "CmdSubst" then "$(..)"
  else ""
  end;

def find_cmd_substs:
  if type == "object" then
    if .Type == "CmdSubst" or .Type == "ProcSubst" then .
    elif .Type == "DblQuoted" then .Parts[]? | find_cmd_substs
    elif .Type == "ParamExp" then
      (.Exp?.Word | find_cmd_substs),
      (.Repl?.Orig | find_cmd_substs),
      (.Repl?.With | find_cmd_substs)
    elif .Parts then .Parts[]? | find_cmd_substs
    else empty
    end
  elif type == "array" then .[] | find_cmd_substs
  else empty
  end;

def get_arg_value:
  [.Parts[]? | get_part_value] | join("");

def get_command_string:
  if .Type == "CallExpr" and .Args then
    [.Args[] | get_arg_value] | map(select(length > 0)) | join(" ")
  else empty
  end;

def extract_commands:
  if type == "object" then
    if .Type == "CallExpr" then
      get_command_string,
      (.Args[]? | find_cmd_substs | .Stmts[]? | extract_commands),
      (.Assigns[]?.Value | find_cmd_substs | .Stmts[]? | extract_commands),
      (.Assigns[]?.Array?.Elems[]?.Value | find_cmd_substs | .Stmts[]? | extract_commands),
      (.Redirs[]?.Word | find_cmd_substs | .Stmts[]? | extract_commands)
    elif .Type == "BinaryCmd" then
      (.X | extract_commands), (.Y | extract_commands)
    elif .Type == "Subshell" or .Type == "Block" then
      (.Stmts[]? | extract_commands)
    elif .Type == "CmdSubst" then
      (.Stmts[]? | extract_commands)
    elif .Type == "IfClause" then
      (.Cond[]? | extract_commands),
      (.Then[]? | extract_commands),
      (.Else | extract_commands)
    elif .Type == "WhileClause" or .Type == "UntilClause" then
      (.Cond[]? | extract_commands), (.Do[]? | extract_commands)
    elif .Type == "ForClause" then
      (.Loop.Items[]? | find_cmd_substs | .Stmts[]? | extract_commands),
      (.Do[]? | extract_commands)
    elif .Type == "CaseClause" then
      (.Items[]?.Stmts[]? | extract_commands)
    elif .Cmd then
      (.Cmd | extract_commands),
      (.Redirs[]?.Word | find_cmd_substs | .Stmts[]? | extract_commands)
    elif .Stmts then
      (.Stmts[] | extract_commands)
    else
      (.[] | extract_commands)
    end
  elif type == "array" then
    (.[] | extract_commands)
  else empty
  end;

extract_commands | select(length > 0)
JQEOF

# Normalize patterns shfmt can't parse
normalize_for_shfmt() {
  echo "$1" | perl -pe 's/\[\[\s*\\?!\s+(.+?)\s+=~\s*/! [[ $1 =~ /g' 2>/dev/null || echo "$1"
}

# Parse command string into individual commands (NUL-delimited)
extract_commands_from_string() {
  local cmd="$1"
  cmd=$(normalize_for_shfmt "$cmd")

  local ast
  if ! ast=$(echo "$cmd" | shfmt -ln bash -tojson 2>/dev/null); then
    debug "shfmt parse failed"
    return 1
  fi

  local raw_commands
  raw_commands=$(echo "$ast" | jq -r "$JQ_FILTER" 2>/dev/null) || return 1

  while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    # Recursively expand bash -c / sh -c
    local inner=""
    if [[ "$line" =~ ^(env[[:space:]]+)?(/[^[:space:]]*/)?((ba)?sh)[[:space:]]+-c[[:space:]]*[\'\"](.*)[\'\"]$ ]]; then
      inner="${BASH_REMATCH[5]}"
    fi
    if [[ -n "$inner" ]]; then
      debug "Recursing into shell -c: $inner"
      extract_commands_from_string "$inner"
    else
      printf '%s\0' "$line"
    fi
  done <<< "$raw_commands"
}

# ---------------------------------------------------------------------------
# Permission matching (allowlist + denylist)
# ---------------------------------------------------------------------------

# Strip leading env var assignments and return candidates for matching
get_command_candidates() {
  local full_command="$1"
  local stripped="$full_command"
  while [[ "$stripped" =~ ^[A-Za-z_][A-Za-z0-9_]*=[^[:space:]]*[[:space:]]+(.*) ]]; do
    stripped="${BASH_REMATCH[1]}"
  done
  echo "$full_command"
  [[ "$stripped" != "$full_command" ]] && echo "$stripped"
}

is_command_denied() {
  local full_command="$1"
  local -n deny_ref=$2

  [[ ${#deny_ref[@]} -eq 0 ]] && return 1

  local candidates
  mapfile -t candidates < <(get_command_candidates "$full_command")

  for cmd in "${candidates[@]}"; do
    for denied in "${deny_ref[@]}"; do
      if [[ "$cmd" == "$denied" ]] || [[ "$cmd" == "$denied "* ]] || [[ "$cmd" == "$denied/"* ]]; then
        debug "DENIED: '$cmd' -> '$denied'"
        return 0
      fi
    done
  done

  return 1
}

is_command_allowed() {
  local full_command="$1"
  local -n prefixes_ref=$2

  local candidates
  mapfile -t candidates < <(get_command_candidates "$full_command")

  for cmd in "${candidates[@]}"; do
    for allowed in "${prefixes_ref[@]}"; do
      if [[ "$cmd" == "$allowed" ]] || [[ "$cmd" == "$allowed "* ]] || [[ "$cmd" == "$allowed/"* ]]; then
        debug "MATCH: '$cmd' -> '$allowed'"
        return 0
      fi
    done
  done

  debug "NO MATCH: '$full_command'"
  return 1
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

main() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --debug) DEBUG=true; shift ;;
      *) shift ;;
    esac
  done

  # Dependency check
  for dep in jq shfmt; do
    if ! command -v "$dep" &>/dev/null; then
      debug "Missing $dep, falling through"
      exit 0
    fi
  done

  # Read hook input
  local input command
  input=$(cat)
  command=$(echo "$input" | jq -r '.tool_input.command // empty')

  if [[ -z "$command" ]]; then
    debug "No command, exiting"
    exit 0
  fi

  debug "Command: $command"

  # Simple command (no compound operators) — let Claude Code handle it natively
  if ! echo "$command" | grep -qE '[|&;]'; then
    debug "Simple command, letting native permissions handle it"
    exit 0
  fi

  # Load allowed and denied prefixes
  mapfile -t allowed_prefixes < <(get_prefixes allow)
  mapfile -t denied_prefixes < <(get_prefixes deny)
  debug "Loaded ${#allowed_prefixes[@]} allow, ${#denied_prefixes[@]} deny prefixes"

  if [[ ${#allowed_prefixes[@]} -eq 0 ]]; then
    debug "No Bash permissions found"
    exit 0
  fi

  # Parse compound command into individual commands
  mapfile -d '' extracted_commands < <(extract_commands_from_string "$command") || {
    debug "Parse failed, falling through"
    exit 0
  }

  debug "Extracted ${#extracted_commands[@]} commands"

  # Empty parse result (comments only, etc.)
  if [[ ${#extracted_commands[@]} -eq 0 ]] || [[ -z "${extracted_commands[0]}" ]]; then
    debug "No commands extracted, allowing"
    echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"allow"}}'
    exit 0
  fi

  # Check every extracted command against deny then allow lists
  # Deny takes precedence: if ANY segment is denied, fall through to prompt
  local all_allowed=true
  for cmd in "${extracted_commands[@]}"; do
    [[ -z "$cmd" ]] && continue
    if is_command_denied "$cmd" denied_prefixes; then
      debug "Command denied, falling through to prompt"
      exit 0
    fi
    if ! is_command_allowed "$cmd" allowed_prefixes; then
      all_allowed=false
      break
    fi
  done

  if $all_allowed; then
    debug "ALL APPROVED"
    echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"allow"}}'
  else
    debug "Some commands not in allowlist, falling through to prompt"
  fi

  exit 0
}

main "$@"
