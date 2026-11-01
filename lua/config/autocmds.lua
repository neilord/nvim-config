local group = vim.api.nvim_create_augroup("General", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    desc = "Open the file picker when started on a directory",
    callback = function(data)
        if vim.fn.isdirectory(data.file) == 1 then
            vim.cmd.cd(data.file)
            Snacks.picker.files()
        end
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    desc = "Go to the last cursor position",
    callback = function()
        local line = vim.fn.line("'\"")
        if line > 1 and line <= vim.fn.line("$") then
            vim.cmd('normal! g`"')
        end
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    desc = "Briefly highlight yanked text",
    callback = function() vim.hl.hl_op() end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermClose", "TermLeave" }, {
    group = group,
    desc = "Reload files changed outside Neovim, e.g. by Claude Code",
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd.checktime()
        end
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    desc = "Create missing parent directories on save",
    callback = function(ev)
        if ev.match:match("^%w%w+:[\\/][\\/]") then
            return -- a URL like oil:// or fugitive://
        end
        vim.fn.mkdir(vim.fn.fnamemodify(vim.uv.fs_realpath(ev.match) or ev.match, ":p:h"), "p")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    desc = "Close helper windows with q",
    pattern = { "help", "qf", "checkhealth", "man", "lspinfo", "dap-float", "git", "fugitive" },
    callback = function(ev)
        vim.bo[ev.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true, desc = "Close" })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    desc = "Wrap and spell check prose",
    pattern = { "markdown", "gitcommit", "text" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

vim.api.nvim_create_autocmd("VimResized", {
    group = group,
    desc = "Keep splits equal when the terminal resizes",
    command = "tabdo wincmd =",
})
