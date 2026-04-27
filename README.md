# dotfiles

My main working machine setup. Here be cyber dragons, and optional bugs. 🐉🐛

## Specs & Configuration

The links below lead to my configuration files in this repo.

I run macOS. 🍎 Packages are managed with [Homebrew][brew] — see [Brewfile](Brewfile)
for the explicit install list (`brew bundle --file=~/Brewfile` to restore on a
fresh machine). [Ghostty][ghostty] is my terminal with [tmux][tmux] on top for
window management, and [Starship][starship] as the prompt. I code in
[Neovim][nvim] with [AstroNvim][astro] as the distro.

## 🐚 Shell ([.zshrc](.zshrc), [.zprofile](.zprofile))

Zsh with [zinit][zinit] as the plugin manager. Zinit solves two problems that
matter when your `.zshrc` does a lot:

- **Async loading** (`wait`, `lucid` ice modifiers) — heavy plugins load *after*
  the prompt renders, so shell startup stays snappy. Autosuggestions, history
  search, syntax highlighting, gcloud completions, scm_breeze — all deferred.
- **Lazy install + git-based plugins** — first-time clone is automatic, and
  binary plugins (e.g. the k9s theme bundle) install from GitHub releases
  via `from"gh-r"`.

A few notable hacks in there:

- **Prezto without SVN** — GitHub killed SVN in 2024, so `zinit ice svn` no
  longer works for cherry-picking single Prezto modules. Workaround: clone the
  full Prezto repo once and `source` individual module init scripts manually.
- **Claude Code fast path** — when `$CLAUDECODE` is set, the shell short-circuits
  after loading just zinit, PATH, fnm, and direnv. No prezto, themes,
  completions, or keybindings — Claude doesn't need them and they cost startup
  time on every Bash tool call.
- **compinit guard** — zinit wraps autoload during plugin loads, which breaks
  `_tags` (stack-depth-sensitive). A small loop strips the wrapper before
  `compinit` runs.

`.zprofile` keeps a few login-shell-only bits: `brew shellenv` (the official
Apple Silicon path setup), an `fnm` default-node entry on `$PATH` so GUI apps
and IDEs find Node without an interactive shell, and `GPG_TTY` for commit
signing.

## 🤖 Claude Code ([.claude/](.claude))

My global Claude Code configuration — applies to every project that doesn't
override it.

- **[CLAUDE.md](.claude/CLAUDE.md)** — global rules: tool preferences, when to
  reach for which MCP, git/PR conventions, objectivity & disagreement protocol.
- **[mcp.json](.claude/mcp.json)** — global MCP servers (Sequential Thinking,
  Git, Context7, Tavily, Exa) loaded via a `~/.claude/mcp.json` flag in the
  `claude` alias, so the dotfiles-tracked file is the source of truth and
  `~/.claude.json`'s `mcpServers` stays empty/committable.
- **[mcp-library.json](.claude/mcp-library.json)** — catalog of MCPs that are
  opt-in per repo (not loaded globally).
- **[settings.json](.claude/settings.json)** — hooks, model choice, status line.
- **[scripts/tmux-rename.sh](.claude/scripts/tmux-rename.sh)** — rename the
  current tmux window when Claude Code starts in it.

[brew]: https://brew.sh
[ghostty]: .config/ghostty/config
[tmux]: .tmux.conf
[starship]: .config/starship.toml
[nvim]: .config/nvim/lua/lazy_setup.lua
[astro]: https://astronvim.com
[zinit]: https://github.com/zdharma-continuum/zinit
