# Plugin backlog

Plugins I installed at some point and removed during the v2 cleanup.
Every config is recoverable: `git show pre-cleanup:lua/plugins/<file>.lua`.

Verdict key: **built-in** — Neovim does it now · **superseded** — a better option exists ·
**maybe** — worth reviewing later · **drop** — not coming back.

## Replaced during the v2 rebuild

These were active until v2 and now have a successor in the config.

| Plugin | What it did | Replaced by |
|---|---|---|
| nvim-telescope/telescope.nvim + telescope-fzf-native | Fuzzy finder | snacks.picker |
| goolord/alpha-nvim | Start screen | snacks.dashboard |
| lukas-reineke/indent-blankline.nvim | Indent guides | snacks.indent |
| echasnovski/mini.indentscope | Current-scope guide | snacks.indent scope |
| kdheepak/lazygit.nvim | LazyGit in a float | snacks.lazygit |
| f-person/git-blame.nvim | Inline blame | gitsigns line blame |
| akinsho/git-conflict.nvim | `co`/`ct` conflict resolution maps | maybe — fugitive `:Gvdiffsplit!` covers it for now |
| mbbill/undotree | Undo history tree | built-in `:Undotree` (0.12) |
| Exafunction/codeium.vim | Inline AI suggestions | none yet — native 0.12 inline completion if wanted |
| mason-org/mason-lspconfig.nvim | Auto-enable Mason servers | explicit `vim.lsp.enable()` list |
| folke/lazydev.nvim | Neovim and plugin types for lua_ls | `.emmyrc.json` with emmylua_ls |
| 3rd/image.nvim, echasnovski/mini.icons | Neo-tree image preview, second icon set | dropped; nvim-web-devicons is the one icon set |

## Editing

| Plugin | What it does | Verdict |
|---|---|---|
| windwp/nvim-autopairs | Auto-close brackets and quotes | maybe (or mini.pairs) |
| kylechui/nvim-surround | `ys`/`cs`/`ds` to add/change/delete surrounding pairs | maybe |
| windwp/nvim-ts-autotag | Auto-close and rename HTML/JSX tags | maybe — useful for TSX |
| monaqa/dial.nvim | Smarter `<C-a>`/`<C-x>`: booleans, semver, `&&`/`\|\|` | maybe |
| Wansmer/treesj | Split/join arguments, objects, arrays | maybe (or mini.splitjoin) |
| nvim-treesitter/nvim-treesitter-textobjects | `af`/`if` function, `ac` conditional, etc. | maybe — Primeagen uses it |
| RRethy/nvim-treesitter-textsubjects | Smart grow-selection by syntax node | built-in (`an`/`in`, 0.12) |
| tpope/vim-sleuth | Detect indentation | superseded by guess-indent |
| spywhere/detect-language.nvim | Guess filetype of extensionless buffers | drop |

## Motion and navigation

| Plugin | What it does | Verdict |
|---|---|---|
| folke/flash.nvim | Jump anywhere with labels; treesitter selection | maybe — the current meta for jumping |
| phaazon/hop.nvim | Label jumping | drop — unmaintained, flash replaces it |
| chrisgrieser/nvim-spider | `w`/`e`/`b` that respect camelCase and snake_case | maybe |
| andymass/vim-matchup | Better `%` across if/else/end, tags | maybe |
| chentoast/marks.nvim | Show marks in the sign column | maybe |
| nacro90/numb.nvim | Peek a line while typing `:123` | maybe |
| karb94/neoscroll.nvim | Smooth scrolling | maybe (or snacks.scroll) |
| coffebar/neovim-project | Project list and auto sessions | drop |

## LSP and diagnostics

| Plugin | What it does | Verdict |
|---|---|---|
| hrsh7th/nvim-cmp + LuaSnip + cmp-* | Completion engine and sources | superseded by blink.cmp |
| nvimtools/none-ls.nvim | Run formatters/linters as a fake LSP | superseded by conform.nvim (+ nvim-lint) |
| pmizio/typescript-tools.nvim | Faster TypeScript server | superseded by vtsls |
| mrcjkb/rustaceanvim | Rust LSP + DAP integration | drop unless I write Rust again |
| smjonas/inc-rename.nvim | Live preview while renaming | built-in-ish (0.12 rename highlights target) |
| aznhe21/actions-preview.nvim | Preview code-action diffs before applying | maybe |
| antosha417/nvim-lsp-file-operations | Update imports when renaming files in the tree | maybe |
| lewis6991/hover.nvim | Multi-source hover (LSP, GitHub, man, …) | built-in `K` is enough |
| rmagatti/goto-preview | Peek definition in a float | maybe |
| RRethy/vim-illuminate | Highlight other uses of the word under cursor | maybe (or snacks.words) |
| j-hui/fidget.nvim | LSP progress spinner | built-in (0.12 statusline shows progress) |
| folke/trouble.nvim | Pretty diagnostics/references list | maybe — quickfix covers most of it |
| kevinhwang91/nvim-bqf | Better quickfix window with preview | maybe |

## UI

| Plugin | What it does | Verdict |
|---|---|---|
| folke/noice.nvim + rcarriga/nvim-notify | Replace cmdline, messages, notifications | superseded by ui2 (0.12) |
| gelguy/wilder.nvim | Fancy cmdline completion | superseded by ui2 / blink cmdline |
| stevearc/dressing.nvim | Prettier `vim.ui.select`/`input` | superseded (archived) |
| akinsho/bufferline.nvim | Buffer tabs at the top | drop — harpoon/picker workflow instead |
| utilyre/barbecue.nvim | Breadcrumbs winbar | drop — archived |
| nvim-treesitter/nvim-treesitter-context | Sticky function header at the top | maybe |
| brenoprata10/nvim-highlight-colors | Color swatches for hex/Tailwind | built-in-ish (0.12 LSP document colors) |
| folke/which-key.nvim | Popup of pending keymaps | maybe — handy while learning new maps |
| folke/zen-mode.nvim + twilight.nvim | Distraction-free centered writing | maybe — Primeagen uses it |
| eandrju/cellular-automaton.nvim | Make-it-rain animations | maybe — for fun |
| cameron-wags/rainbow_csv.nvim | Color CSV columns | superseded by csvview |
| hat0uma/csvview.nvim | Align CSV into a table view | maybe |

## Tools

| Plugin | What it does | Verdict |
|---|---|---|
| sindrets/diffview.nvim | Tabbed git diff/history viewer | maybe — good for reviewing agent changes |
| akinsho/toggleterm.nvim | Toggleable terminals | maybe (or built-in `:terminal`) |
| mfussenegger/nvim-dap + rcarriga/nvim-dap-ui | Debugger | rewriting from scratch in phase 3 |

## AI

| Plugin | What it does | Verdict |
|---|---|---|
| zbirenbaum/copilot.lua | Copilot inline suggestions | superseded by native 0.12 inline completion |
| CopilotC-Nvim/CopilotChat.nvim | Copilot chat window | superseded by Claude Code |
| supermaven-inc/supermaven-nvim | Fast inline suggestions | drop — Supermaven was folded into Cursor |
