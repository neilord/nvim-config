local parsers = {
    "typescript",
    "tsx",
    "javascript",
    "json",
    "jsdoc",
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
    "luadoc",
    "toml",
    "dockerfile",
    "vim",
    "vimdoc",
    "query",
    "regex",
    "diff",
    "gitcommit",
    "git_rebase",
    "gitignore",
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
            desc = "Treesitter highlighting, indentation and folds",
            callback = function(ev)
                if pcall(vim.treesitter.start, ev.buf) then
                    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    vim.wo[0][0].foldmethod = "expr"
                    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                end
            end,
        })
    end,
}
