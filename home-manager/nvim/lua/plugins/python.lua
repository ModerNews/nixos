return {
    {
      "joshzcold/python.nvim",
      ft = "python",
      dependencies = {
        { "mfussenegger/nvim-dap" },
        { "mfussenegger/nvim-dap-python" },
        { "neovim/nvim-lspconfig" },
        { "L3MON4D3/LuaSnip" },
        { "nvim-neotest/neotest" },
        { "nvim-neotest/neotest-python" },
      },
      ---@type python.Config
      opts = {
        python_lua_snippets = true,
        post_set_venv = function()
              vim.cmd("LspRestart pyright")
        end,
        -- uv creates .venv in project root by default
        auto_create_venv_path = function(parent_dir)
          return vim.fs.joinpath(parent_dir, ".venv")
        end,
        enabled_text_actions = {
          "f-strings",
        },
        test = {
          test_runner = "pytest",
        },
      },
    },
  }
