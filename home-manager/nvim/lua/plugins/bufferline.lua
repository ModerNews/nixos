return {
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            local ui = require("ui_theme")

            local function highlights()
                local p = ui.palette()
                local canvas = p.bg or "NONE"
                local plain = { fg = p.muted, bg = canvas }
                local sel = { fg = p.fg, bg = canvas, bold = true, underline = true, sp = p.accent }
                local bright = { fg = p.fg, bg = canvas }

                return {
                    fill = { bg = canvas },
                    background = plain,
                    buffer_visible = plain,
                    buffer_selected = sel,
                    tab = plain,
                    tab_selected = sel,
                    tab_close = plain,
                    close_button = plain,
                    close_button_visible = plain,
                    close_button_selected = bright,
                    separator = bright,
                    separator_visible = bright,
                    separator_selected = bright,
                    indicator_selected = { fg = p.accent, bg = canvas, bold = true, underline = true, sp = p.accent },
                    modified = plain,
                    modified_visible = plain,
                    modified_selected = bright,
                    duplicate = { fg = p.dim, bg = canvas, italic = true },
                    duplicate_visible = { fg = p.dim, bg = canvas, italic = true },
                    duplicate_selected = { fg = p.fg, bg = canvas, bold = true, italic = true, underline = true, sp = p.accent },
                    numbers = plain,
                    numbers_visible = plain,
                    numbers_selected = bright,
                    pick = { fg = p.accent, bg = canvas, bold = true },
                    pick_visible = { fg = p.accent, bg = canvas, bold = true },
                    pick_selected = { fg = p.accent, bg = canvas, bold = true },
                    diagnostic = plain,
                    diagnostic_visible = plain,
                    diagnostic_selected = plain,
                    hint = plain,
                    hint_visible = plain,
                    hint_selected = sel,
                    hint_diagnostic = { fg = p.hint, bg = canvas },
                    hint_diagnostic_visible = { fg = p.hint, bg = canvas },
                    hint_diagnostic_selected = { fg = p.hint, bg = canvas },
                    info = plain,
                    info_visible = plain,
                    info_selected = sel,
                    info_diagnostic = { fg = p.info, bg = canvas },
                    info_diagnostic_visible = { fg = p.info, bg = canvas },
                    info_diagnostic_selected = { fg = p.info, bg = canvas },
                    warning = plain,
                    warning_visible = plain,
                    warning_selected = sel,
                    warning_diagnostic = { fg = p.warn, bg = canvas },
                    warning_diagnostic_visible = { fg = p.warn, bg = canvas },
                    warning_diagnostic_selected = { fg = p.warn, bg = canvas },
                    error = plain,
                    error_visible = plain,
                    error_selected = sel,
                    error_diagnostic = { fg = p.error, bg = canvas },
                    error_diagnostic_visible = { fg = p.error, bg = canvas },
                    error_diagnostic_selected = { fg = p.error, bg = canvas },
                    offset_separator = { bg = canvas },
                    trunc_marker = plain,
                    group_label = bright,
                    group_separator = { bg = canvas },
                }
            end

            ui.on_colorscheme("bufferline", function()
                require("bufferline").setup({
                    options = {
                        mode = "buffers",
                        separator_style = "thin",
                        show_buffer_close_icons = true,
                        show_close_icon = false,
                        diagnostics = "nvim_lsp",
                        indicator = { style = "underline" },
                        offsets = {
                            {
                                filetype = "neo-tree",
                                text = " Files",
                                highlight = "Directory",
                                separator = true,
                            },
                        },
                        themable = true,
                    },
                    highlights = highlights(),
                })
            end)

            -- Buffer navigation
            vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { silent = true, desc = "Next Buffer" })
            vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { silent = true, desc = "Prev Buffer" })
            vim.keymap.set('n', '<leader>bp', ':BufferLinePick<CR>', { silent = true, desc = "Pick Buffer" })
            vim.keymap.set('n', '<leader>bc', ':BufferLinePickClose<CR>', { silent = true, desc = "Pick Close Buffer" })
            vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { silent = true, desc = "Close Buffer" })

            -- Tab management
            vim.keymap.set('n', '<leader>Tn', ':tabnew<CR>', { silent = true, desc = "New tab" })
            vim.keymap.set('n', '<leader>Tc', ':tabclose<CR>', { silent = true, desc = "Close tab" })
            vim.keymap.set('n', '<leader>]', ':tabnext<CR>', { silent = true, desc = "Next tab" })
            vim.keymap.set('n', '<leader>[', ':tabprev<CR>', { silent = true, desc = "Prev tab" })

            -- Buffer groups
            vim.keymap.set('n', '<leader>bgt', ':BufferLineGroupToggle ', { desc = "Toggle group" })
            vim.keymap.set('n', '<leader>bgc', ':BufferLineGroupClose ', { desc = "Close group" })
            vim.keymap.set('n', '<leader>bn', ':BufferLineMoveNext<CR>', { silent = true, desc = "Move buffer right" })
            vim.keymap.set('n', '<leader>bN', ':BufferLineMovePrev<CR>', { silent = true, desc = "Move buffer left" })
            vim.keymap.set('n', '<leader>bs', ':BufferLineSortByDirectory<CR>', { silent = true, desc = "Sort by directory" })
            vim.keymap.set('n', '<leader>bS', ':BufferLineSortByExtension<CR>', { silent = true, desc = "Sort by extension" })
        end
    }
}
