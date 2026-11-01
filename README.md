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
| snacks.nvim | Picker, dashboard, indent guides, LazyGit float (only these modules are on) |
| rainbow-delimiters.nvim | Bracket pair colors |
| todo-comments.nvim | Highlights TODO/FIX/NOTE comments |
| nvim-lspconfig | Server configs only; servers are enabled natively in `config/lsp.lua` |
| mason.nvim | Installs language servers, formatters (and later debug adapters) |
| blink.cmp | Completion menu (LSP, snippets, paths, buffer words) |
| conform.nvim | Format on save, only in projects that have a formatter config |
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
| `<leader>e` / `<leader>E` | Toggle file tree / reveal current file |
| `<leader>a`, `<C-e>`, `<leader>1`–`4` | Harpoon: add file, menu, jump to file 1–4 |
| `<leader>u` | Undo history (built-in `:Undotree`) |
| `<leader>g` | LazyGit |
| `]c` / `[c` | Next / previous git hunk |
| `<leader>hs` `hr` `hp` `hb` | Stage, reset, preview, blame hunk (`hS`/`hR` whole buffer) |
| `<leader>tb` | Toggle inline blame |
| `gd` | Go to definition |
| `K` · `grn` · `gra` · `grr` · `gri` · `grt` · `gO` | Hover, rename, code action, references, implementation, type definition, symbols (built-in) |
| `[d` / `]d` · `<C-w>d` | Previous / next diagnostic, diagnostic float (built-in) |
| `<leader>rl` | Restart LSP |
| `gq{motion}` | Format with conform |
| `<leader>cc` / `<leader>cf` | Toggle / focus Claude Code |
| `<leader>cb` · `<leader>cs` (visual) | Add buffer / send selection to Claude |
| `<leader>ca` / `<leader>cd` | Accept / reject Claude's proposed diff |
| `<leader>y` `Y` `d` `D` | Yank / delete to the system clipboard |
| `<leader>p` (visual) | Paste over selection without losing the register |
| `<leader>w` / `<leader>W` | Save / save without formatting |
| `<leader>q` / `<leader>Q` | Quit all / force quit |
| `<leader>h` · `<leader>lw` | Toggle search highlight · line wrap |
| `<leader>sp` `st` `sc` `sh` `sk` | Plugins, Mason, config files, highlights, keymaps |
| `U` · `+` / `-` | Redo · increment / decrement |

## Claude Code

Run `claude` in a tmux pane next to Neovim and type `/ide` to connect, or open it inside Neovim with
`<leader>cc`. Claude sees the current file and selection; its edits open as diffs to accept or reject.

## Commits

Conventional Commits with a scope: `type(scope): outcome`, for example `feat(lsp): enable yamlls`.
Scopes: `plugins`, `lsp`, `ui`, `keymaps`, `options`, `docs`, `repo`. Work happens on a short-lived
`feat/…`, `fix/…`, `docs/…` or `chore/…` branch and is squash-merged into `main`.
