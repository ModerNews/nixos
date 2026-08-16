local opt = vim.opt
opt.showmode = false
opt.laststatus = 3

opt.clipboard = "unnamedplus"
opt.cursorline = false

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.softtabstop = 4

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

require("config.lazy")

local scripts_dir = vim.fn.stdpath("config") .. "/lua/scripts"
local script_names = {}
for name, type in vim.fs.dir(scripts_dir) do
    if type == "file" and name:match("%.lua$") and not name:match("^_") then
        table.insert(script_names, name:sub(1, -5))
    end
end
table.sort(script_names)
for _, name in ipairs(script_names) do
    require("scripts." .. name)
end
