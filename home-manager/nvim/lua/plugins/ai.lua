return {
    {
        "github/copilot.vim",
        event = "InsertEnter",
        config = function()
            -- Free up Tab for blink.cmp; accept inline suggestion with <M-Right>
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_filetypes = { ["TelescopePrompt"] = false }
            vim.api.nvim_create_autocmd("CmdlineEnter", {
                callback = function() vim.b.copilot_enabled = false end,
            })
            vim.api.nvim_create_autocmd("CmdlineLeave", {
                callback = function() vim.b.copilot_enabled = true end,
            })
            vim.keymap.set("i", "<M-Right>", 'copilot#Accept("\\<CR>")', {
                expr = true,
                replace_keycodes = false,
            })
        end,
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            adapters = {
                acp = {
                    claude_code = function()
                        return require("codecompanion.adapters").extend("claude_code", {
                            handlers = {
                                auth = function() return true end,
                            },
                        })
                    end,
                },
            },
            strategies = {
                chat   = { adapter = "claude_code" },
                inline = { adapter = "claude_code" },
            },
            display = {
                chat = {
                    window = {
                        layout = "vertical",
                        width = 0.35,
                    },
                },
            },
        },
        keys = {
            { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion Chat",    mode = { "n" } },
            { "<leader>aa", "<cmd>CodeCompanionActions<cr>",     desc = "CodeCompanion Actions", mode = { "n", "v" } },
            { "<leader>ai", "<cmd>CodeCompanion<cr>",            desc = "CodeCompanion Inline",  mode = { "n", "v" } },
        },
    },
}
