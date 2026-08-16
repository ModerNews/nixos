{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };

  home.packages = with pkgs; [
    # LSP servers, replacing mason-lspconfig's ensure_installed.
    lua-language-server
    pyright
    clang-tools # clangd
    vscode-langservers-extracted # html, cssls, jsonls, eslint
    marksman
    dockerfile-language-server # note: renamed from …-nodejs
    docker-compose-language-service
    helm-ls
    yaml-language-server
    bash-language-server
    vim-language-server
    awk-language-server
    rust-analyzer # rustaceanvim

    # Formatters and linters
    ruff
    prettier
    stylua

    gcc
    tree-sitter
    nodejs # several servers and parsers are Node scripts
  ];
}
