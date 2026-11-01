# Neovim config

Lean, hand-written config on Neovim nightly. Built-in defaults first; a plugin earns its place only
when Neovim can't do the job. Removed plugins and their verdicts live in [BACKLOG.md](BACKLOG.md).

## Requirements

- Neovim nightly, installed from the official build into `~/nvim-macos` (first in `PATH`):

  ```bash
  curl -fsSL https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz | tar xz -C /tmp && command rm -rf ~/nvim-macos && mv /tmp/nvim-macos-arm64 ~/nvim-macos
  ```

- `tree-sitter` CLI 0.26.1+ and a C compiler (nvim-treesitter builds parsers locally)
- `rg`, `fd`, `lazygit`, a Nerd Font
- Language servers and formatters install themselves through Mason on first start

## Layout

```
init.lua              entry point
lua/config/
  options.lua         editor options, ui2
  keymaps.lua         global keymaps
  autocmds.lua        global autocommands
  lazy.lua            plugin manager bootstrap
  lsp.lua             native LSP: enabled servers, diagnostics, LspAttach maps
  theme.lua           theme picker, follows ~/.config/theme; every custom color
lua/plugins/          one file per plugin, loaded by lazy.nvim
lsp/                  per-server overrides, when one is needed (lsp/<server>.lua)
KEYS.md               every keymap and the Vim essentials, opened with <leader>?
.emmyrc.json          Lua types for this config: Neovim runtime + installed plugins
```

Lua uses `emmylua_ls`, the type checker Neovim itself uses. `lua_ls` cuts off Neovim's long enum
types (it rejects `"VimEnter"` as an autocmd event), and `.emmyrc.json` replaces lazydev.nvim.

Add a plugin by adding a file to `lua/plugins/`; remove it by deleting the file.
All custom colors live in `lua/config/theme.lua`.

## Plugins

| Plugin | Why |
|---|---|
| lazy.nvim | Plugin manager: lockfile, lazy loading, UI |
| tokyonight.nvim, catppuccin | Colorschemes, transparent; see [Themes](#themes) |
| lualine.nvim | Statusline, styled like the tmux bar |
| snacks.nvim | Picker, dashboard, indent guides, LazyGit float, terminal, big-file guard, import updates on file rename (only these modules are on) |
| rainbow-delimiters.nvim | Bracket pair colors |
| todo-comments.nvim | Highlights TODO/FIX/NOTE comments |
| nvim-lspconfig | Server configs only; servers are enabled natively in `config/lsp.lua` |
| mason.nvim | Installs language servers, formatters and debug adapters |
| blink.cmp | Completion menu (LSP, snippets, paths, buffer words) |
| conform.nvim | Format on save with biome, prettier, ruff, stylua or shfmt, only in projects that have a formatter config |
| nvim-dap + nvim-dap-view | Debugger with a variables/watches/breakpoints/REPL panel and inline values; Node, TypeScript, Chrome, Vitest, Jest and Python |
| which-key.nvim | Shows what keys can follow a pending prefix |
| nvim-surround | `ys`/`cs`/`ds` to add, change, delete surrounding pairs |
| nvim-ts-autotag | Closes and renames paired HTML/JSX tags |
| nvim-treesitter | Installs parsers; highlighting and indent use Neovim's built-in treesitter |
| nvim-treesitter-textobjects | `af`/`if` function, `ac`/`ic` class |
| gitsigns.nvim | Hunk signs, staging, inline blame |
| vim-fugitive | `:Git` for everything else |
| harpoon | Pin up to 4 working files to keys |
| neo-tree.nvim | File tree |
| claudecode.nvim | Claude Code IDE integration: shares context, opens proposed edits as diffs |
| mini.move | Move lines and selections |
| targets.vim | More text objects: arguments, separators, quotes across lines |
| guess-indent.nvim | Detects each file's indentation |
| hardtime.nvim | Habit trainer against repeated `hjkl` |

## Keymaps

Leader is `Space`; pause after it and which-key shows what follows. Every key, plus the Vim motions
worth knowing, is in [KEYS.md](KEYS.md), which `<leader>?` opens inside Neovim.

## Themes

`<leader>tt` (or `:Theme`) switches the terminal, tmux, Neovim, the prompt, lazygit, delta, bat and eza
together: Tokyo Night, Tokyo Night Day, Catppuccin Latte, Macchiato and Mocha, or Auto, which follows
macOS light and dark mode. The switching and every theme's colors live in `~/.config/theme` (see its
README); here, `lua/config/theme.lua` follows the theme in use and holds Neovim's custom colors.

## Debugging

Keys are in [KEYS.md](KEYS.md#debugging): `<F5>` start/continue, `<F10>`–`<F12>` step,
`<leader>b` breakpoint, the rest under `<leader>x`.

`<F5>` lists the configurations for the current file type, plus any in the project's
`.vscode/launch.json` (`"type": "node"` and `"chrome"` work as in VS Code). Built in:

- Node: launch the current file (`.js` or `.ts`), attach to a `node --inspect` process
- Vitest or Jest: debug the current test file
- Chrome: launch a page and debug its scripts (default `http://localhost:3000`)
- Python: launch the current file, using `$VIRTUAL_ENV` or `./.venv` when present

The panel opens with the session and closes when it ends; switch its sections with the letters in its
title bar, `g?` for its keys.

## Claude Code

Run `claude` in a tmux pane next to Neovim and type `/ide` to connect, or open it inside Neovim with
`<leader>cc`. Claude sees the current file and selection; its edits open as diffs to accept or reject.
Files Claude changes on disk reload when you return to Neovim.

## Commits

Conventional Commits with a scope: `type(scope): outcome`, for example `feat(lsp): enable yamlls`.
Scopes: `plugins`, `lsp`, `ui`, `keymaps`, `options`, `docs`, `repo`. Work happens on a short-lived
`feat/…`, `fix/…`, `docs/…` or `chore/…` branch and is squash-merged into `main`.
