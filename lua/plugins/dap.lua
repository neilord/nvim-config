-- Debugger. Adapters come from Mason (js-debug-adapter, debugpy, see plugins/mason.lua).
-- A project's .vscode/launch.json is picked up automatically next to the configs below.
-- Stepping uses the VS Code F-keys; everything else lives under <leader>x.

local js_filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }

local function js_configurations()
    return {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch current file (Node)",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach to process (node --inspect)",
            processId = function() return require("dap.utils").pick_process({ filter = "node" }) end,
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "launch",
            name = "Debug Vitest (current file)",
            runtimeExecutable = "npx",
            runtimeArgs = { "vitest", "run", "--no-file-parallelism", "${file}" },
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
        },
        {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest (current file)",
            runtimeExecutable = "npx",
            runtimeArgs = { "jest", "--runInBand", "${file}" },
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
        },
        {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome (localhost)",
            url = function()
                local url = vim.fn.input("URL: ", "http://localhost:3000")
                return url ~= "" and url or require("dap").ABORT
            end,
            webRoot = "${workspaceFolder}",
        },
    }
end

local function setup_adapters(dap)
    local mason = vim.fn.stdpath("data") .. "/mason"

    -- js-debug serves pwa-node and pwa-chrome from one server
    for _, type in ipairs({ "pwa-node", "pwa-chrome", "node", "chrome" }) do
        dap.adapters[type] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                args = { mason .. "/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
            },
            -- launch.json files written for VS Code use "node"/"chrome"; js-debug only knows the pwa- names
            enrich_config = function(config, on_config)
                if not config.type:find("^pwa%-") then
                    config = vim.deepcopy(config)
                    config.type = "pwa-" .. config.type
                end
                on_config(config)
            end,
        }
    end

    for _, ft in ipairs(js_filetypes) do
        dap.configurations[ft] = js_configurations()
    end

    dap.adapters.debugpy = {
        type = "executable",
        command = mason .. "/packages/debugpy/venv/bin/python",
        args = { "-m", "debugpy.adapter" },
    }
    dap.adapters.python = dap.adapters.debugpy
    dap.configurations.python = {
        {
            type = "debugpy",
            request = "launch",
            name = "Launch current file (Python)",
            program = "${file}",
            console = "integratedTerminal",
            -- the project's virtualenv when there is one, so its packages resolve
            pythonPath = function()
                local venv = os.getenv("VIRTUAL_ENV") or (vim.uv.fs_stat(".venv") and vim.fn.getcwd() .. "/.venv")
                return venv and venv .. "/bin/python" or "python3"
            end,
        },
    }
end

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        {
            "igorlfs/nvim-dap-view",
            version = "1.*",
            opts = {
                auto_toggle = true, -- opens with a session, closes when it ends
                virtual_text = { enabled = true, position = "eol" }, -- variable values next to the code
            },
        },
    },

    config = function()
        local dap = require("dap")
        setup_adapters(dap)

        local signs = {
            DapBreakpoint = { "●", "DiagnosticError" },
            DapBreakpointCondition = { "◆", "DiagnosticWarn" },
            DapLogPoint = { "◉", "DiagnosticInfo" },
            DapBreakpointRejected = { "○", "DiagnosticHint" },
            DapStopped = { "󰁕", "DiagnosticOk", "Visual" },
        }
        for name, sign in pairs(signs) do
            vim.fn.sign_define(name, { text = sign[1], texthl = sign[2], linehl = sign[3], numhl = sign[3] })
        end
    end,

    keys = {
        { "<F5>", function() require("dap").continue() end, desc = "Debug: Start / Continue" },
        { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
        { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
        { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
        { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        {
            "<leader>B",
            function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end,
            desc = "Conditional Breakpoint",
        },
        { "<leader>xc", function() require("dap").continue() end, desc = "Start / Continue" },
        { "<leader>xo", function() require("dap").step_over() end, desc = "Step Over" },
        { "<leader>xi", function() require("dap").step_into() end, desc = "Step Into" },
        { "<leader>xu", function() require("dap").step_out() end, desc = "Step Out" },
        { "<leader>xC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<leader>xl", function() require("dap").run_last() end, desc = "Run Last" },
        { "<leader>xq", function() require("dap").terminate() end, desc = "Terminate" },
        {
            "<leader>xp",
            function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log message: ")) end,
            desc = "Log Point",
        },
        { "<leader>xx", function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" },
        { "<leader>xv", "<cmd>DapViewToggle<cr>", desc = "Toggle Debug View" },
        { "<leader>xw", "<cmd>DapViewWatch<cr>", mode = { "n", "x" }, desc = "Watch Expression" },
        { "<leader>xe", function() require("dap.ui.widgets").hover() end, mode = { "n", "x" }, desc = "Evaluate" },
    },
}
