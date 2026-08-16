vim.api.nvim_create_user_command("ToggleTokenBg", function()
    vim.g.custom_token_bg = vim.g.custom_token_bg == 0 and 1 or 0
    vim.cmd.colorscheme(vim.g.colors_name or "custom")
    vim.notify("token backgrounds " .. (vim.g.custom_token_bg == 1 and "on" or "off"))
end, { desc = "Toggle String/Comment background fills" })
