return {
    {
        'tpope/vim-sleuth'
    },
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        cmd = { "ConformInfo" },
        keys = {
            { "<leader>cf", function() require("conform").format({ async = true }) end, desc = "Format buffer" },
        },
        opts = {
            formatters_by_ft = {
                python = { "ruff_format" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                lua = { "stylua" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        },
    }
}
