-- biome or prettier, whichever the project is configured for (require_cwd skips the other)
local web = { "biome", "prettier", stop_after_first = true }

return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",

    init = function()
        -- gq formats with conform too
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,

    opts = {
        formatters_by_ft = {
            javascript = web,
            javascriptreact = web,
            typescript = web,
            typescriptreact = web,
            json = web,
            jsonc = web,
            css = web,
            html = { "prettier" },
            markdown = { "prettier" },
            yaml = { "prettier" },
            python = { "ruff_organize_imports", "ruff_format" },
            lua = { "stylua" },
            sh = { "shfmt" },
        },
        formatters = {
            -- only format when the project has its own config, so foreign repos stay untouched
            biome = { require_cwd = true },
            prettier = { require_cwd = true },
            ruff_format = { require_cwd = true },
            ruff_organize_imports = { require_cwd = true },
        },
        format_on_save = { timeout_ms = 1000 },
    },
}
