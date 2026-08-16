vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", {})

vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

return {
    {
        "NumToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
        },
        opts = {
            keywords = {
                FIX = { icon = " ", color = "fix", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
                TODO = { icon = " ", color = "todo" },
                HACK = { icon = " ", color = "hack" },
                WARN = { icon = " ", color = "warn", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", color = "perf", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "note", alt = { "INFO" } },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
            highlight = {
                before = "bg",
                keyword = "wide",
                after = "fg",
                comments_only = true,
            },
            -- Colors reference TodoFg*/TodoBg*/TodoSign* groups defined in custom.vim
            colors = {
                fix = { "TodoFgFIX", "#d83e4a" },
                hack = { "TodoFgHACK", "#ffcc33" },
                warn = { "TodoFgWARN", "#f36630" },
                todo = { "TodoFgTODO", "#86a87e" },
                note = { "TodoFgNOTE", "#a1e7eb" },
                perf = { "TodoFgPERF", "#d89fff" },
                test = { "TodoFgTEST", "#b0b0b0" },
            },
        }
    },
}
