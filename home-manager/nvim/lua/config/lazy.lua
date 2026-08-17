-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },

    -- Disabled: nothing installed needs luarocks. rest.nvim is not in the
    -- plugin set, yet `hererocks` sits in lazy-lock.json because this was on —
    -- and bootstrapping it COMPILES Lua at runtime, which is the class of thing
    -- that fails on NixOS. Turn back on only if a plugin actually requires it.
    rocks = { enabled = false },

    -- ~/.config/nvim is a read-only symlink into the Nix store, so lazy cannot
    -- write its default lockfile at stdpath("config")/lazy-lock.json.
    --
    -- Point it at the copy inside the flake repo instead: that is a real file
    -- under git, so `:Lazy sync` updates the VERSION-CONTROLLED lockfile
    -- directly and you just commit the result. Falls back to the data dir if
    -- the repo is not checked out where expected.
    lockfile = (function()
        local repo = vim.fn.expand("~/.nixos/home-manager/nvim/lazy-lock.json")
        if (vim.uv or vim.loop).fs_stat(repo) then
            return repo
        end
        return vim.fn.stdpath("data") .. "/lazy-lock.json"
    end)(),
})
