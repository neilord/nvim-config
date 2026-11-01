return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        {
            "s1n7ax/nvim-window-picker",
            version = "2.*",
            config = function()
                require("window-picker").setup({
                    filter_rules = {
                        include_current_win = false,
                        autoselect_one = true,
                        bo = {
                            filetype = { "neo-tree", "neo-tree-popup", "notify" },
                            buftype = { "terminal", "quickfix" },
                        },
                    },
                })
            end,
        },
    },

    opts = {
        -- moving or renaming a file asks the language server to update its imports
        event_handlers = {
            {
                event = "file_moved",
                handler = function(data) Snacks.rename.on_rename_file(data.source, data.destination) end,
            },
            {
                event = "file_renamed",
                handler = function(data) Snacks.rename.on_rename_file(data.source, data.destination) end,
            },
        },
        enable_modified_markers = false,
        popup_border_style = "rounded",
        sort_case_insensitive = true,
        default_component_configs = {
            icon = {
                folder_closed = "󰉋",
                folder_open = "󰝰",
                folder_empty = "󰉖",
                folder_empty_open = "󰷏",
            },
            diagnostics = {
                symbols = {
                    hint = "󰌵",
                    info = "󰋼",
                    warn = "",
                    error = "󰅙",
                },
            },
        },
        window = {
            width = 30,
        },
        sources = {
            "filesystem",
            "buffers",
            "git_status",
            "document_symbols",
        },
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
                never_show = {
                    ".DS_Store",
                    ".git",
                },
            },
            scan_mode = "deep",
            -- The tree shows git-ignored files, and neo-tree passes that on to its search as fd --no-ignore,
            -- which floods `/` and `#` with node_modules. Search still respects .gitignore.
            find_args = function(cmd, _, _, args)
                if cmd ~= "fd" and cmd ~= "fdfind" then
                    return args
                end
                args = vim.tbl_filter(function(arg) return arg ~= "--no-ignore" end, args)
                vim.list_extend(args, { "--exclude", ".git" })
                return args
            end,
        },
        document_symbols = {
            follow_cursor = true,
            renderers = {
                symbol = {
                    { "indent", with_expanders = true },
                    { "kind_icon", default = "?" },
                    {
                        "container",
                        content = {
                            { "name", zindex = 10 },
                        },
                    },
                },
            },
        },
    },

    keys = {
        { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" },
        { "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Reveal File in Explorer" },
    },
}
