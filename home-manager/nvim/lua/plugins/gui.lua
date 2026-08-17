return {
    {
        "ziontee113/color-picker.nvim",
        config = function()
            vim.keymap.set("n", "<leader>cc", "<cmd>PickColor<cr>", opts)
            vim.keymap.set("i", "<leader>ci", "<cmd>PickColorInsert<cr>", opts)

            require("color-picker").setup({
                ["icons"] = { "ﱢ", "" },
                ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
                ["keymap"] = {          -- mapping example:
                    ["U"] = "<Plug>ColorPickerSlider5Decrease",
                    ["O"] = "<Plug>ColorPickerSlider5Increase",
                },
                ["background_highlight_group"] = "CmpMenu",
                ["border_highlight_group"] = "CmpMenu",
                ["text_highlight_group"] = "CmpMenu",
            })
        end
    },                             -- color picker (who would have guessed)
    "xiyaowong/link-visitor.nvim", -- Url opener (cmd)
    {
        "NvChad/nvim-colorizer.lua", -- highlight color definitions with their color
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        'mcauley-penney/visual-whitespace.nvim',
        event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
        opts = {
            -- your opts here ...
        }
    }
}
