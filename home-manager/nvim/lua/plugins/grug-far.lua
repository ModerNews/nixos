return {
    {
        "MagicDuck/grug-far.nvim",
        cmd = { "GrugFar", "GrugFarWithin" },
        opts = {
            headerMaxWidth = 80,
        },
        keys = {
            {
                "<leader>sr",
                function() require("grug-far").open() end,
                desc = "Search and replace (project)",
            },
            {
                "<leader>sw",
                function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end,
                desc = "Search and replace word under cursor",
            },
            {
                "<leader>sf",
                function() require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } }) end,
                desc = "Search and replace (current file)",
            },
            {
                "<leader>sr",
                function()
                    require("grug-far").with_visual_selection()
                end,
                mode = "v",
                desc = "Search and replace selection",
            },
        },
    },
}
