return {
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufWritePost" },
        config = function()
            local lint = require("lint")
            local schema = require("pipeline_schema")

            local function locate(bufnr, err)
                local needle = err.message:match("'([^']+)'")
                if not needle then
                    needle = err.path:match("([%w_%-]+)%[?%d*%]?$")
                end
                if not needle then return 0 end

                local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
                for i, line in ipairs(lines) do
                    if line:find('"' .. needle .. '"', 1, true)
                        or line:find(needle .. ":", 1, true) then
                        return i - 1
                    end
                end
                return 0
            end

            local function parse(output, bufnr)
                if output == nil or output == "" then return {} end
                local ok, decoded = pcall(vim.json.decode, output)
                if not ok or type(decoded) ~= "table" then return {} end

                local diagnostics = {}
                for _, group in ipairs({ decoded.errors or {}, decoded.parse_errors or {} }) do
                    for _, err in ipairs(group) do
                        table.insert(diagnostics, {
                            lnum = locate(bufnr, err),
                            col = 0,
                            severity = vim.diagnostic.severity.ERROR,
                            source = "check-jsonschema",
                            message = (err.path or "$") .. ": " .. (err.message or "invalid"),
                        })
                    end
                end
                return diagnostics
            end

            local function runner()
                if vim.fn.executable("check-jsonschema") == 1 then
                    return "check-jsonschema", {}
                elseif vim.fn.executable("uvx") == 1 then
                    return "uvx", { "check-jsonschema" }
                end
            end

            local cmd, prefix = runner()
            if not cmd then return end

            lint.linters.check_jsonschema = {
                cmd = cmd,
                stdin = false,
                ignore_exitcode = true,
                append_fname = true,
                args = vim.list_extend(vim.deepcopy(prefix), {
                    "--output-format", "json",
                    "--schemafile",
                    function() return schema.schema_for(0) or "" end,
                }),
                parser = parse,
            }

            vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
                group = vim.api.nvim_create_augroup("pipeline-lint", { clear = true }),
                callback = function(args)
                    if schema.schema_for(args.buf) then
                        lint.try_lint("check_jsonschema")
                    end
                end,
            })

            vim.keymap.set("n", "<leader>ll", function()
                lint.try_lint()
            end, { desc = "Lint current buffer" })
        end,
    },
}
