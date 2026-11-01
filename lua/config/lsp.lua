-- Server configs come from nvim-lspconfig's lsp/ folder; overrides go in ~/.config/nvim/lsp/<name>.lua.
-- Binaries are installed by Mason, see plugins/mason.lua.
vim.lsp.enable({
    "vtsls", -- TypeScript, JavaScript
    "biome", -- lint diagnostics; only attaches in projects with a biome.json
    "eslint", -- only attaches in projects with an eslint config
    "tailwindcss", -- only attaches in projects with a tailwind config or dependency
    "html",
    "cssls",
    "jsonls",
    "emmylua_ls", -- the type checker Neovim itself uses; lua_ls truncates its long enum aliases
    "bashls",
    "yamlls",
    "pyright",
    "ruff", -- Python lint and import sorting; pyright keeps types and hover
    "phpactor",
})

vim.diagnostic.config({
    severity_sort = true,
    virtual_text = { prefix = "●" },
    float = { source = true },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅙",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "󰋼",
            [vim.diagnostic.severity.HINT] = "󰌵",
        },
    },
})

-- Everything else uses the built-in defaults: K, grn, gra, grr, gri, grt, gO, [d, ]d, <C-w>d, <C-s>
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLsp", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false -- pyright's hover is the useful one
        end

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to Definition" })
        vim.keymap.set("n", "<leader>rl", "<cmd>lsp restart<cr>", { buffer = ev.buf, desc = "Restart LSP" })
    end,
})
