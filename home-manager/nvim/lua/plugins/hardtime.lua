return {
    {
        "m4xshen/hardtime.nvim",
        lazy = false,
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            disable_mouse = false,
            restriction_mode = "hint",
            max_count = 6,
            disabled_keys = {
                ["<Up>"] = {},
                ["<Down>"] = {},
                ["<Left>"] = {},
                ["<Right>"] = {},
            },
            disabled_filetypes = {
                "neo-tree",
                "lazy",
                "mason",
                "help",
                "noice",
                "trouble",
                "grug-far",
                "qf",
            },
        },
        keys = {
            { "<leader>ph", "<cmd>Hardtime toggle<cr>", desc = "Toggle hardtime" },
        },
    },
    {
        "tris203/precognition.nvim",
        event = "VeryLazy",
        opts = {
            startVisible = false,
            showBlankVirtLine = false,
        },
        keys = {
            { "<leader>pp", function() require("precognition").toggle() end, desc = "Toggle precognition" },
        },
    },
}
