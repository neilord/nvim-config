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
            javascript = { "biome" },
            javascriptreact = { "biome" },
            typescript = { "biome" },
            typescriptreact = { "biome" },
            json = { "biome" },
            jsonc = { "biome" },
            css = { "biome" },
            html = { "prettier" },
            markdown = { "prettier" },
            yaml = { "prettier" },
            lua = { "stylua" },
            sh = { "shfmt" },
        },
        formatters = {
            -- only format when the project has its own config, so foreign repos stay untouched
            biome = { require_cwd = true },
            prettier = { require_cwd = true },
        },
        format_on_save = { timeout_ms = 1000 },
    },
}
