vim.api.nvim_create_autocmd("FileType", {
    callback = function(ev)
        if vim.treesitter.get_parser(ev.buf, nil, { error = false }) then
            vim.treesitter.start(ev.buf)
        end
    end,
})
