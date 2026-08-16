local virtual_text_cfg = {
    virtual_lines = false,
    virtual_text = {
        enabled = true,
        source = "if_many",
        prefix = "●",
        format = function(diagnostic)
            return string.format('%s %s', diagnostic.message, diagnostic.source and '(' .. diagnostic.source .. ')' or '')
        end,
    },
}

vim.diagnostic.config(virtual_text_cfg)

vim.keymap.set('n', '<leader><Down>', function()
    vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })

    vim.api.nvim_create_autocmd('CursorMoved', {
        group = vim.api.nvim_create_augroup('line-diagnostics', { clear = true }),
        callback = function()
            vim.diagnostic.config(virtual_text_cfg)
            return true
        end,
    })
end)

-- vim.api.nvim_create_autocmd("CursorHold", {
--     callback = function()
--         vim.diagnostic.open_float(nil, { focus = false })
--     end
-- })
