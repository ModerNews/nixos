local M = {}

local function hex(n)
    return n and string.format("#%06x", n)
end

local function attr(names, key)
    for _, name in ipairs(names) do
        local h = vim.api.nvim_get_hl(0, { name = name, link = false })
        if h and h[key] then
            return hex(h[key])
        end
    end
end

function M.palette()
    return {
        fg      = attr({ "Normal" }, "fg"),
        bg      = attr({ "Normal" }, "bg"),
        muted   = attr({ "Comment", "NonText" }, "fg"),
        dim     = attr({ "Conceal", "SpecialKey", "Comment", "NonText" }, "fg"),
        accent  = attr({ "DiagnosticError", "ErrorMsg", "Error" }, "fg"),
        error   = attr({ "DiagnosticError", "ErrorMsg" }, "fg"),
        warn    = attr({ "DiagnosticWarn", "WarningMsg" }, "fg"),
        info    = attr({ "DiagnosticInfo" }, "fg"),
        hint    = attr({ "DiagnosticHint" }, "fg"),
        sel_bg  = attr({ "Visual" }, "bg"),
        sel_fg  = attr({ "Visual", "Normal" }, "fg"),
        stl_fg  = attr({ "StatusLine", "Normal" }, "fg"),
        stl_bg  = attr({ "StatusLine", "Normal" }, "bg"),
    }
end

function M.on_colorscheme(name, fn)
    vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("ui_theme_" .. name, { clear = true }),
        callback = function()
            local ok, err = pcall(fn)
            if not ok then
                vim.notify("ui_theme[" .. name .. "]: " .. tostring(err), vim.log.levels.ERROR)
            end
        end,
    })
    fn()
end

return M
