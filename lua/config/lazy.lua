local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    install = { colorscheme = { "tokyonight" } },
    change_detection = { notify = false },
    rocks = { enabled = false }, -- no plugin here needs luarocks
    ui = {
        size = { width = 0.59, height = 0.6 },
        border = "rounded",
    },
})

vim.keymap.set("n", "<leader>sp", "<cmd>Lazy<cr>", { desc = "Plugins" })
