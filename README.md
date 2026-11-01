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
lua/plugins/          one file per plugin, loaded by lazy.nvim
lsp/                  per-server overrides, when one is needed (lsp/<server>.lua)
.emmyrc.json          Lua types for this config: Neovim runtime + installed plugins
```

Lua uses `emmylua_ls`, the type checker Neovim itself uses. `lua_ls` cuts off Neovim's long enum
types (it rejects `"VimEnter"` as an autocmd event), and `.emmyrc.json` replaces lazydev.nvim.

Add a plugin by adding a file to `lua/plugins/`; remove it by deleting the file.
All custom colors live in `lua/plugins/tokyonight.lua`.

## Plugins

| Plugin | Why |
|---|---|
| lazy.nvim | Plugin manager: lockfile, lazy loading, UI |
| tokyonight.nvim | Colorscheme, night style, transparent |
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

Leader is `Space`. Built-in Neovim defaults are not repeated here except the LSP ones, since those
replaced custom maps.

| Keys | Action |
|---|---|
| `<leader>f` / `<leader>F` | Find files / find text |
| `<leader>,` | Buffers |
| `<leader>sr` `sw` `so` | Resume last search, grep word or selection, recent files |
| `<leader>sd` `ss` `sS` | Diagnostics, document symbols, workspace symbols |
| `<leader>sg` `sq` `sH` | Git changes, quickfix list, help pages |
| `<leader>e` / `<leader>E` | Toggle file tree / reveal current file |
| `<leader>a`, `<C-e>`, `<leader>1`–`4` | Harpoon: add file, menu, jump to file 1–4 |
| `<leader>u` | Undo history (built-in `:Undotree`) |
| `<leader>g` · `<C-/>` | LazyGit · floating terminal |
| `]c` / `[c` | Next / previous git hunk |
| `<leader>hs` `hr` `hp` `hb` | Stage, reset, preview, blame hunk (`hS`/`hR` whole buffer) |
| `<leader>tb` | Toggle inline blame |
| `gd` | Go to definition |
| `K` · `grn` · `gra` · `grr` · `gri` · `grt` · `gO` | Hover, rename, code action, references, implementation, type definition, symbols (built-in) |
| `[d` / `]d` · `<C-w>d` | Previous / next diagnostic, diagnostic float (built-in) |
| `<leader>rl` · `<leader>rw` | Restart LSP · replace the word under the cursor in the file |
| `<leader>ti` · `<leader>ts` | Toggle inlay hints · spell check |
| `gq{motion}` | Format with conform |
| `<leader>cc` / `<leader>cf` | Toggle / focus Claude Code |
| `<leader>cb` · `<leader>cs` (visual) | Add buffer / send selection to Claude |
| `<leader>ca` / `<leader>cd` | Accept / reject Claude's proposed diff |
| `<leader>y` `Y` `d` `D` | Yank / delete to the system clipboard |
| `<leader>p` (visual) | Paste over selection without losing the register |
| `<leader>w` / `<leader>W` | Save / save without formatting |
| `<leader>q` / `<leader>Q` | Quit all / force quit |
| `<Esc>` · `<leader>h` · `<leader>lw` | Clear search highlight · toggle it · toggle line wrap |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Move between windows |
| `za` `zc` `zo` `zR` `zM` | Folds, from treesitter, all open on start (built-in) |
| `<leader>sp` `st` `sc` `sh` `sk` | Plugins, Mason, config files, highlights, keymaps |
| `U` · `+` / `-` | Redo · increment / decrement |

## Debugging

| Keys | Action |
|---|---|
| `<F5>` · `<F10>` · `<F11>` · `<F12>` | Start/continue · step over · step into · step out |
| `<leader>b` · `<leader>B` · `<leader>xp` | Toggle breakpoint · conditional breakpoint · log point |
| `<leader>xc` `xo` `xi` `xu` | Same as the F-keys, for keyboards where macOS takes them |
| `<leader>xC` · `<leader>xl` · `<leader>xq` | Run to cursor · rerun last · terminate |
| `<leader>xe` · `<leader>xw` | Evaluate expression under cursor/selection · add it to watches |
| `<leader>xv` · `<leader>xx` | Toggle the debug panel · clear all breakpoints |

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
