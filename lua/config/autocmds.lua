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
