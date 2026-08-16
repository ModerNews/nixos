local M = {}

M.root = vim.fn.expand("~/.local/share/japco-ci/schema")

M.filenames = {
    ["pipeline.json"] = true,
    ["pipeline.yaml"] = true,
    ["pipeline.yml"] = true,
}

function M.is_pipeline(path)
    return M.filenames[vim.fs.basename(path or "")] == true
end

function M.version(bufnr)
    local head = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, 40, false), "\n")
    return head:match('["\']?pipeline%-schema["\']?%s*:%s*["\']?([%w%.%-]+)')
end

function M.schema_for(bufnr)
    bufnr = bufnr or 0
    local path = vim.api.nvim_buf_get_name(bufnr)
    if not M.is_pipeline(path) then return end

    local version = M.version(bufnr)
    if not version then return end

    local major = version:match("^(%d+)")
    if not major then return end

    local dir = M.root .. "/v" .. major
    for _, candidate in ipairs({
        dir .. "/" .. version .. "/schema.json",
        dir .. "/" .. version,
        dir .. "/" .. version .. ".json",
    }) do
        local stat = vim.uv.fs_stat(candidate)
        if stat and stat.type == "file" then
            return candidate, version
        end
    end

    return nil, version
end

function M.uri_for(bufnr)
    local path, version = M.schema_for(bufnr)
    if path then return vim.uri_from_fname(path) end
    if version then
        vim.notify("pipeline-schema " .. version .. ": no schema under " .. M.root,
            vim.log.levels.WARN)
    end
end

return M
