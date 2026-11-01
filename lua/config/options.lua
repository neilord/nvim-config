-- no plugin here uses netrw or the remote-plugin providers; skipping them speeds startup.
-- Opening a directory goes to the file picker instead, see config/autocmds.lua.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true -- only the line number is highlighted, see config/theme.lua
vim.opt.signcolumn = "yes"
vim.opt.fillchars = { eob = " " }
vim.opt.showmode = false -- lualine shows the mode
vim.opt.winborder = "rounded"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split" -- live preview of :s results

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.breakindent = true -- wrapped lines keep their indent
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.virtualedit = "block" -- visual block can cover empty space
vim.opt.confirm = true -- ask to save instead of failing on :q with changes

-- treesitter folds (set per buffer in treesitter.lua), all open by default
vim.opt.foldlevel = 99
vim.opt.foldtext = ""

-- fallback when guess-indent can't detect the file's indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.timeoutlen = 500 -- which-key pops up when a mapping is pending

-- experimental message and cmdline UI: no "Press ENTER" prompts, highlighted cmdline
require("vim._core.ui2").enable({})
