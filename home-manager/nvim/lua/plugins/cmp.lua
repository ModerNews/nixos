return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip").config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
            })
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            fast_wrap = {},
            disable_filetype = { "TelescopePrompt", "vim" },
        },
    },
    {
        "saghen/blink.cmp",
        version = "*",
        dependencies = { "L3MON4D3/LuaSnip" },
        opts = {
            snippets = { preset = "luasnip" },
            keymap = {
                preset = "super-tab",
                ["<C-b>"]     = { "scroll_documentation_up",   "fallback" },
                ["<C-f>"]     = { "scroll_documentation_down", "fallback" },
                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"]     = { "hide", "fallback" },
                ["<CR>"]      = { "accept", "fallback" },
            },
            completion = {
                list = {
                    selection = { preselect = false },
                },
                accept = {
                    auto_brackets = { enabled = true },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                menu = {
                    border = "rounded",
                    winhighlight = "Normal:CmpMenu,FloatBorder:CmpMenu,NormalThumb:CmpMenuThumb,PmenuSbar:CmpMenuSbar",
                    draw = {
                        columns = {
                            { "kind_icon" },
                            { "label", "label_description", gap = 1 },
                            { "kind" },
                        },
                    },
                },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                per_filetype = {
                    lua = { inherit_defaults = true, "lazydev" },
                },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
            signature = { enabled = true },
        },
    },
}
