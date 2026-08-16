return {
    "folke/which-key.nvim", -- keymap
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
    {
        "folke/snacks.nvim",
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            dim = { enabled = true },
            gh = { enabled = true },
            picker = { enabled = true }, -- required for gh
            image = { enabled = true },
            indent = {
                enabled = true,
                char = "│",
                hl = "IblIndent",       -- gray for inactive
                scope = { hl = "Identifier" }, -- colored for active scope
            },
            input = { enabled = true },
            lazygit = {
                enabled = true,
                configure = true, -- auto-configure lazygit theme based on colorscheme
            },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            terminal = {
                enabled = true,
                win = { position = "bottom", height = 15 },
            },
            toggle = { enabled = true },
            words = { enabled = true },
            zen = { enabled = true },
        },
        keys = {
            -- Toggles (prefix: <leader>u)
            { "<leader>ud", function() Snacks.toggle.diagnostics() end,      desc = "Toggle Diagnostics" },
            { "<leader>ul", function() Snacks.toggle.option("relativenumber") end, desc = "Toggle Relative Numbers" },
            { "<leader>uL", function() Snacks.toggle.line_number() end,      desc = "Toggle Line Numbers" },
            { "<leader>uw", function() Snacks.toggle.option("wrap") end,     desc = "Toggle Word Wrap" },
            { "<leader>us", function() Snacks.toggle.option("spell") end,    desc = "Toggle Spelling" },
            { "<leader>uh", function() Snacks.toggle.inlay_hints() end,      desc = "Toggle Inlay Hints" },
            { "<leader>ut", function() Snacks.toggle.treesitter() end,       desc = "Toggle Treesitter" },
            { "<leader>ub", function() Snacks.toggle.option("background", { off = "light", on = "dark" }) end, desc = "Toggle Background" },
            -- Zen/Focus
            { "<leader>z",  function() Snacks.zen() end,                     desc = "Toggle Zen Mode" },
            { "<leader>Z",  function() Snacks.zen.zoom() end,                desc = "Toggle Zoom" },
            { "<leader>rr", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
            { "<leader>d",  function() Snacks.dim() end,                     desc = "Toggle Dimming" },
            { "<C-.>",      function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",     mode = { "n", "v" } },
            { "<C-,>",      function() Snacks.words.jump(-vim.v.count1) end, desc = "Previous Reference", mode = { "n", "v" } },
            { "<leader>gg", function() Snacks.lazygit() end,                 desc = "LazyGit" },
            { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "LazyGit file history" },
            { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "LazyGit log" },
            { "<leader>gi", function() Snacks.gh.issue() end,                desc = "GitHub Issues" },
            { "<leader>gP", function() Snacks.gh.pr() end,                   desc = "GitHub PRs" },
            { "<c-\\>",     function() Snacks.terminal() end,                desc = "Toggle Terminal",    mode = { "n", "t" } },
            { "<leader><CR>", function() Snacks.terminal() end,              desc = "Toggle Terminal" },
            { "<esc>",      [[<C-\><C-n>]],                                  desc = "Exit Terminal Mode", mode = "t" },
        }
    },
}
