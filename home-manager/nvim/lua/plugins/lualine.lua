return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local ui = require("ui_theme")

            local function build_theme()
                local p = ui.palette()
                local base = { fg = p.stl_fg or p.fg, bg = p.stl_bg }
                local alt = { fg = p.sel_fg or p.fg, bg = p.sel_bg }

                local theme = {
                    normal = { a = base, b = alt, c = base },
                    inactive = { a = base, b = alt, c = base },
                }

                for _, mode in ipairs({ "normal", "inactive" }) do
                    theme[mode].x = theme[mode].c
                    theme[mode].y = theme[mode].b
                    theme[mode].z = theme[mode].a
                end

                return theme
            end

            local CAP_LEFT = vim.fn.nr2char(0xe0b6)
            local CAP_RIGHT = vim.fn.nr2char(0xe0b4)

            local function divider(cap, fg_section, bg_section, theme)
                return {
                    function() return cap end,
                    color = { fg = theme.normal[fg_section].bg, bg = theme.normal[bg_section].bg },
                    padding = { left = 0, right = 0 },
                }
            end

            ui.on_colorscheme("lualine", function()
                local theme = build_theme()

                require("lualine").setup({
                    options = {
                        component_separators = { left = "|", right = "|" },
                        section_separators = { left = "", right = "" },
                        theme = theme,
                    },
                    sections = {
                        lualine_a = { "mode" },
                        lualine_b = {
                            divider(CAP_LEFT, "b", "a", theme),
                            "filesize",
                            "filename",
                            divider(CAP_RIGHT, "b", "c", theme),
                        },
                        lualine_c = { "location", "progress" },
                        lualine_x = {
                            "diff",
                        },
                        lualine_y = {
                            divider(CAP_LEFT, "y", "x", theme),
                            "encoding",
                            "fileformat",
                        },
                        lualine_z = {
                            divider(CAP_RIGHT, "y", "z", theme),
                        },
                    },
                    inactive_sections = {
                        lualine_a = {},
                        lualine_b = {},
                        lualine_c = {},
                        lualine_x = {},
                        lualine_y = {},
                        lualine_z = {},
                    },
                })
            end)
        end
    },
}
