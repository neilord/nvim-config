vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true -- only the line number is highlighted, see tokyonight.lua
vim.opt.signcolumn = "yes"
vim.opt.fillchars = { eob = " " }
vim.opt.showmode = false -- lualine shows the mode
vim.opt.winborder = "rounded"

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- fallback when guess-indent can't detect the file's indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.scrolloff = 8
vim.opt.updatetime = 50

-- experimental message and cmdline UI: no "Press ENTER" prompts, highlighted cmdline
require("vim._core.ui2").enable({})
