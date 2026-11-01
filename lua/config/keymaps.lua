vim.g.mapleader = " "

vim.keymap.set("n", "U", vim.cmd.redo)

vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>W", "<cmd>noa w<cr>", { desc = "Save Without Formatting" })
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Force Quit" })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "x", '"_x')
vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+y$')
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d')
vim.keymap.set({ "n", "v" }, "<leader>D", '"+D')

vim.keymap.set("n", "<leader>h", "<cmd>set hlsearch!<cr>", { desc = "Toggle Highlight" })
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<cr>", { desc = "Toggle Line Wrap" })

vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    vim.cmd.Undotree()
end, { desc = "Undo History" })
