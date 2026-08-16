return {
    "elkowar/yuck.vim", -- LSP for yuck (eww)
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        lazy = false,   -- This plugin is already lazy
    },
    {
        "qvalentin/helm-ls.nvim", -- Filetype detection and helpers for Helm
        ft = "helm",
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "creativenull/efmls-configs-nvim",   -- Predefined configs for EFM language server
            "saghen/blink.cmp",                  -- Ensure blink is available for capabilities enhancement
        },
        config = function()
            local languages = require("efmls-configs.defaults").languages()
            languages = vim.tbl_extend("force", languages, {
                -- Custom languages, or override existing ones
                javascript = {} -- Add your custom JavaScript config here if needed
            })

            -- Enhanced capabilities with blink.cmp support
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local has_blink, blink = pcall(require, "blink.cmp")
            if has_blink then
                capabilities = blink.get_lsp_capabilities(capabilities)
            end

            -- Enable document color support
            -- vim.api.nvim_create_autocmd('LspAttach', {
            --     callback = function(args)
            --         local client = vim.lsp.get_client_by_id(args.data.client_id)
            --
            --         if client:supports_method('textDocument/documentColor') then
            --             vim.lsp.document_color.enable(true, args.buf)
            --         end
            --     end
            -- })

            -- Common on_attach function with keymaps and formatting
            local on_attach = function(client, bufnr)
                -- Common LSP keymaps
                local opts = { buffer = bufnr, silent = true }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            end

            -- Configure servers with custom settings using vim.lsp.config

            -- Lua Language Server with enhanced settings
            vim.lsp.config('lua_ls', {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            -- Clangd with enhanced settings
            vim.lsp.config('clangd', {
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },
            })

            -- ESLint with auto-fix on save
            vim.lsp.config('eslint', {
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            vim.cmd("EslintFixAll")
                        end,
                    })
                end,
            })

            -- Servers come from nixpkgs, not Mason: Mason downloads prebuilt
            -- binaries that hard-fail on NixOS for want of
            -- /lib64/ld-linux-x86-64.so.2. This list replaces ensure_installed
            -- + automatic_enable. rust_analyzer is absent deliberately --
            -- rustaceanvim owns it.
            local servers = {
                'lua_ls', 'pyright', 'clangd', 'html', 'cssls', 'eslint',
                'marksman', 'dockerls', 'docker_compose_language_service',
                'helm_ls', 'yamlls', 'jsonls', 'bashls',
            }

            for _, server in ipairs(servers) do
                vim.lsp.config(server, { capabilities = capabilities, on_attach = on_attach })
            end
            vim.lsp.enable(servers)

            -- Apply on_attach to every client, however it was configured
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client then
                        -- Apply our on_attach to all LSP clients
                        on_attach(client, args.buf)
                    end
                end,
            })

            -- EFM and the plain-config servers
            -- EFM Language Server
            vim.lsp.config('efm', {
                filetypes = vim.tbl_keys(languages),
                settings = {
                    rootMarkers = { ".git/" },
                    languages = languages,
                },
                init_options = {
                    documentFormatting = false,
                    documentRangeFormatting = false,
                },
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- Servers whose config is just capabilities + on_attach.
            local manual_servers = {
                'vimls',
                'awk_ls',
            }

            for _, server in ipairs(manual_servers) do
                vim.lsp.config(server, {
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end
            vim.lsp.enable(manual_servers)
        end
    }
}
