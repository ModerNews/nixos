local schema = require("pipeline_schema")

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("pipeline-schema", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end
        if client.name ~= "jsonls" and client.name ~= "yamlls" then return end

        local url = schema.uri_for(args.buf)
        if not url then return end
        local path = vim.api.nvim_buf_get_name(args.buf)

        if client.name == "jsonls" then
            local schemas = vim.tbl_get(client.settings, "json", "schemas") or {}
            table.insert(schemas, { fileMatch = { path }, url = url })
            client.settings = vim.tbl_deep_extend("force", client.settings,
                { json = { schemas = schemas } })
        else
            local schemas = vim.tbl_get(client.settings, "yaml", "schemas") or {}
            schemas[url] = { path }
            client.settings = vim.tbl_deep_extend("force", client.settings,
                { yaml = { schemas = schemas } })
        end

        client:notify("workspace/didChangeConfiguration", { settings = client.settings })
    end,
})
