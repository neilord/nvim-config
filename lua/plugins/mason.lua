-- Mason package names, which differ from the server names in config/lsp.lua
local tools = {
    -- language servers
    "vtsls",
    "biome",
    "eslint-lsp",
    "tailwindcss-language-server",
    "html-lsp",
    "css-lsp",
    "json-lsp",
    "emmylua_ls",
    "bash-language-server",
    "yaml-language-server",
    "pyright",
    "ruff",
    "phpactor",
    -- formatters
    "stylua",
    "shfmt",
    "prettier",
    -- debug adapters, see plugins/dap.lua
    "js-debug-adapter",
    "debugpy",
}

return {
    "mason-org/mason.nvim",
    lazy = false, -- puts installed binaries on PATH before any server starts

    opts = {
        ui = {
            width = 0.58, -- matches the Lazy window
            height = 0.6,
        },
    },

    config = function(_, opts)
        require("mason").setup(opts)

        local registry = require("mason-registry")
        registry.refresh(function()
            for _, name in ipairs(tools) do
                local pkg = registry.get_package(name)
                if not pkg:is_installed() then
                    pkg:install()
                end
            end
        end)
    end,

    keys = {
        { "<leader>st", "<cmd>Mason<cr>", desc = "External Tools" },
    },
}
