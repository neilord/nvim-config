return {
    "RRethy/vim-illuminate",
enabled = false,

    event = "BufReadPre",

    config = function()
        require("illuminate").configure({
            delay = 300,
            filetypes_denylist = {
                "dirbuf",
                "dirvish",
                "fugitive",
                "neo-tree",
                "undotree",
            },
        })
    end,
}
