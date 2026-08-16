require("lazy").setup({
    "folke/which-key.nvim",      -- keymap
    {
        "utilyre/barbecue.nvim", -- context map (on top)
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
    },
    "ziontee113/color-picker.nvim", -- color picker (who would have guessed)
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                on_attach = function()
                    local gs = require("gitsigns")
                    vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame)
                end,
            })
        end,
    },
    "xiyaowong/link-visitor.nvim", -- Url opener (cmd)
    "jghauser/mkdir.nvim",         -- create missing directories on write
    "NvChad/nvim-colorizer.lua",   -- highlight color definitions with their color
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim",
            {
                "s1n7ax/nvim-window-picker",
                config = function()
                    require("window-picker").setup({
                        hint = 'statusline-winbar',
                        picker_config = {
                            statusline_winbar_picker = {
                                -- You can change the display string in status bar.
                                -- It supports '%' printf style. Such as `return char .. ': %f'` to display
                                -- buffer file path. See :h 'stl' for details.
                                selection_display = function(char, windowid)
                                    return '%=' .. char .. '%='
                                end,

                                -- whether you want to use winbar instead of the statusline
                                -- "always" means to always use winbar,
                                -- "never" means to never use winbar
                                -- "smart" means to use winbar if cmdheight=0 and statusline if cmdheight > 0
                                use_winbar = 'never', -- "always" | "never" | "smart"
                            },
                        },
                        selection_chars = 'HJKLFDSA;CMRUEIWOQP',
                        filter_rules = {
                            -- when there is only one window available to pick from, use that window
                            -- without prompting the user to select
                            autoselect_one = true,

                            -- whether you want to include the window you are currently on to window
                            -- selection or not
                            include_current_win = true,

                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { 'NvimTree', 'neo-tree', 'notify', 'noice' },

                                -- if the file type is one of following, the window will be ignored
                                buftype = { 'terminal' },
                            },

                            -- filter using window options
                            wo = {},

                            -- if the file path contains one of following names, the window
                            -- will be ignored
                            file_path_contains = {},

                            -- if the file name contains one of following names, the window will be
                            -- ignored
                            file_name_contains = {},
                        },
                    })
                end,
            },
        },
        config = function()
            require("neotree")
        end,
    },
    "adelarsq/image_preview.nvim", -- preview images in terminal
    {
        "NumToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "github/copilot.vim",
        config = function()
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        dependencies = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
        main = "ibl",
        opts = {},
    },
    --{
    --	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    --	config = function()
    --	require("lsp_lines").setup()
    --	end,
    --},
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
        },
        opts = {
            keywords = {
                FIX = { icon = " ", color = "default", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
                TODO = { icon = " ", color = "hint" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "info", alt = { "INFO" } },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
            colors = {
                error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" }, -- HACK: WarningMsg
                info = { "DiagnosticInfo", "#2563EB" },                  -- TODO: DiagnosticInfo
                hint = { "DiagnosticHint", "#10B981" },                  -- NOTE: DiagnosticHint
                default = { "Identifier", "#7C3AED" },                   -- PERF:
                test = { "Identifier", "#FF00FF" },                      -- FIX:
            },
        },
        config = function()
            require("todo-comments").setup({
                on_attach = {
                    function() end,
                },
            })
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
    {
        "mfussenegger/nvim-dap"
    },
    {
        "jbyuki/one-small-step-for-vimkind",
        dependencies = {
            "mfussenegger/nvim-dap"
        }
    },
    {
        "folke/snacks.nvim",
        lazy = false, -- mention all enabled plugins in config file
        opts = {
            bigfile = { enabled = true },
            dim = { enalbed = true },
            scroll = { enabled = true },
            -- TODO: terminal = { enabled = true },
            words = { enabled = true },
            zen = { enabled = true },
        },
        keys = {
            { "<leader>z",  function() Snacks.zen() end,                     desc = "Toggle Zen Mode" },
            { "<leader>Z",  function() Snacks.zen.zoom() end,                desc = "Toggle Zoom" },
            { "<leader>rr", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
            { "<leader>d",  function() Snacks.dim() end,                     desc = "Toggle Dimming" },
            { "<C-.>",      function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",     mode = { "n", "v" } },
            { "<C-,>",      function() Snacks.words.jump(-vim.v.count1) end, desc = "Previous Reference", mode = { "n", "v" } },
        }
    },
})

vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })


local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require("ibl.hooks")
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

local rainbow_delimiters = require("rainbow-delimiters")
vim.g.rainbow_delimiters = {
    strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        vim = rainbow_delimiters.strategy["local"],
    },
    query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
    },
    priority = {
        [""] = 110,
        lua = 210,
    },
    highlight = highlight,
}

require("ibl").setup({
    indent = {
        highlight = { "Comment" },
        -- level = 1,
    },
    scope = { highlight = { "Identifier" } },
})
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", {})
vim.keymap.set("n", "<C-k>", builtin.buffers, {})

require("lspconfigure") -- load LSP configuration from external lua file
require("image_preview").setup()



opt.completeopt = "menu,menuone,noselect"

local function border(hl_name)
    return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
    }
end

vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "css",
        "csv",
        "dockerfile",
        "dot",
        "git_config",
        "javascript",
        "json",
        "html",
        "regex",
        "python",
    },
    ignore_install = { "haskell" },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true },
    autotag = { enable = true },
})

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require("ibl.hooks")
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

local rainbow_delimiters = require("rainbow-delimiters")
vim.g.rainbow_delimiters = {
    strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        vim = rainbow_delimiters.strategy["local"],
    },
    query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
    },
    priority = {
        [""] = 110,
        lua = 210,
    },
    highlight = highlight,
}

require("ibl").setup({
    indent = {
        highlight = { "Comment" },
        -- level = 1,
    },
    scope = { highlight = { "Identifier" } },
})
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", {})
vim.keymap.set("n", "<C-k>", builtin.buffers, {})

require("image_preview").setup()

require("colorizer").setup()

require("barbecue").setup()
require("barbecue.ui").toggle(true)
require("cheatsheet").setup()

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

require("link-visitor").setup()

require("dap-setup")
