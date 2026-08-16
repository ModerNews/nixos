local M

local colors = {
	text = "#1f1b2d",
	inactive_bg = "#a162a1",
	active_bg1 = "#e165a7",
	active_bg2 = "#2ca0cb",
}

M.custom_auto_lualine = require("lualine.themes.auto")
-- Overrides
M.custom_auto_lualine.normal.c.fg = colors.text
M.custom_auto_lualine.insert.c.fg = colors.text
M.custom_auto_lualine.replace.c.fg = colors.text
M.custom_auto_lualine.visual.c.fg = colors.text
M.custom_auto_lualine.command.c.fg = colors.text
M.custom_auto_lualine.inactive = {
	a = { fg = colors.text, bg = colors.inactive_bg, gui = "bold" },
	b = { fg = colors.inactive_bg, bg = colors.text },
	c = { fg = colors.text, bg = colors.inactive_bg },
}

return M
