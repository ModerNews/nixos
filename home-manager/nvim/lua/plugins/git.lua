return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local gs = require("gitsigns")
                    local function map(mode, l, r, desc)
                        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
                    end
                    map("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle Git Blame")
                    map("n", "]h", gs.next_hunk, "Next Hunk")
                    map("n", "[h", gs.prev_hunk, "Prev Hunk")
                    map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
                    map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
                    map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
                    map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
                    map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
                    map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
                end,
            })
        end,
    },
}
