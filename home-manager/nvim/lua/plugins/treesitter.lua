return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "css",
                    "html",
                    "javascript",
                    "json",
                    "latex",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "rust",
                    "typescript",
                    "yaml",
                },
            })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
}
