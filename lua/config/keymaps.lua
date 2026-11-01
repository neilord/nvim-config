-- Global keymaps. Plugin keymaps live in their plugin file; the full list is in KEYS.md (<leader>?).
-- Every mapping gets a desc, which which-key shows as its label.
vim.g.mapleader = " "

local map = vim.keymap.set

-- editing
map("n", "U", vim.cmd.redo, { desc = "Redo" })
map("n", "+", "<C-a>", { desc = "Increment Number" })
map("n", "-", "<C-x>", { desc = "Decrement Number" })
map("n", "J", "mzJ`z", { desc = "Join Lines (cursor stays)" })
map("n", "x", '"_x', { desc = "Delete Char (no yank)" })
map("x", "<", "<gv", { desc = "Indent Left (keep selection)" })
map("x", ">", ">gv", { desc = "Indent Right (keep selection)" })

-- scrolling and search keep the cursor centered
map("n", "n", "nzzzv", { desc = "Next Match" })
map("n", "N", "Nzzzv", { desc = "Previous Match" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half Page Down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half Page Up" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Search Highlight" })

map("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window Right" })

-- files
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>W", "<cmd>noa w<cr>", { desc = "Save Without Formatting" })
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Force Quit" })
map("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    vim.cmd.Undotree()
end, { desc = "Undo History" })

-- system clipboard; plain y/d/p keep using Neovim's registers
map({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to Clipboard" })
map("n", "<leader>Y", '"+y$', { desc = "Yank to Clipboard (to end of line)" })
map({ "n", "x" }, "<leader>d", '"+d', { desc = "Cut to Clipboard" })
map("n", "<leader>D", '"+D', { desc = "Cut to Clipboard (to end of line)" })
map("x", "<leader>p", '"_dP', { desc = "Paste Over (keep register)" })

-- <leader>r: replace
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace Word in File" })
map("x", "<leader>rw", [["zy:%s/\V<C-r>z/<C-r>z/gI<Left><Left><Left>]], { desc = "Replace Selection in File" })

-- <leader>l: code and LSP; the buffer-local ones are set on LspAttach in config/lsp.lua
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>lq", vim.diagnostic.setqflist, { desc = "Diagnostics to Quickfix" })
map("n", "<leader>li", "<cmd>checkhealth vim.lsp<cr>", { desc = "LSP Info" })

-- <leader>t: toggles
map("n", "<leader>th", "<cmd>set hlsearch!<cr>", { desc = "Search Highlight" })
map("n", "<leader>tw", "<cmd>set wrap!<cr>", { desc = "Line Wrap" })
map("n", "<leader>ts", "<cmd>setlocal spell!<cr>", { desc = "Spell Check" })
map(
    "n",
    "<leader>ti",
    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
    { desc = "Inlay Hints" }
)
map("n", "<leader>td", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { desc = "Diagnostics" })
map("n", "<leader>tt", function() require("config.theme").pick() end, { desc = "Theme" })

map(
    "n",
    "<leader>?",
    function()
        Snacks.win({
            file = vim.fn.stdpath("config") .. "/KEYS.md",
            width = 0.7,
            height = 0.85,
            border = "rounded",
            title = " Keys ",
            title_pos = "center",
            wo = { wrap = false, conceallevel = 2, spell = false },
            b = { snacks_indent = false },
        })
    end,
    { desc = "Key Cheat Sheet" }
)
