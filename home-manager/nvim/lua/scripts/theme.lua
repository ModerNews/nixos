local by_host = {
    ["thinkpad.gruzin"] = "custom",
    ["gruzin-desktop"] = "custom-navy",
    ["l-pf2lr112"] = "gruvbox",
}

local FALLBACK = "custom"

local function host_keys()
    local host = vim.uv.os_gethostname() or ""
    local lower = host:lower()
    return { lower, (lower:gsub("%..*$", "")) }
end

local function resolve()
    if vim.env.NVIM_COLORSCHEME then
        return vim.env.NVIM_COLORSCHEME
    end
    for _, key in ipairs(host_keys()) do
        if by_host[key] then
            return by_host[key]
        end
    end
    return FALLBACK
end

local scheme = resolve()
if not pcall(vim.cmd.colorscheme, scheme) then
    vim.notify("colorscheme '" .. scheme .. "' failed, using " .. FALLBACK, vim.log.levels.WARN)
    pcall(vim.cmd.colorscheme, FALLBACK)
end
