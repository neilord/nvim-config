local parsers = {
    "typescript",
    "tsx",
    "javascript",
    "json",
    "html",
    "css",
    "markdown",
    "markdown_inline",
    "sql",
    "php",
    "yaml",
    "bash",
    "python",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "regex",
    "diff",
    "gitcommit",
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- does not support lazy loading
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter").install(parsers)

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("Treesitter", { clear = true }),
            desc = "Treesitter highlighting and indentation",
            callback = function(ev)
                if pcall(vim.treesitter.start, ev.buf) then
                    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end,
}
