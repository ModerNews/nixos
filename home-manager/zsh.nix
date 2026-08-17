{
  lib,
  pkgs,
  ...
}: let
  flakeDir = "$HOME/.nixos";
in {
  home.sessionVariables.EDITOR = "nvim";
  home.sessionPath = ["$HOME/.local/bin"];

  programs.zsh = {
    enable = true;

    history = {
      path = "$HOME/.zsh_history";
      size = 10000;
      save = 10000;
      append = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "sudo" "web-search" "copyfile" "copybuffer" "dirhistory"];
      theme = ""; # starship owns the prompt
    };

    autosuggestion.enable = true;

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting";
      }
      {
        name = "forgit";
        src = "${pkgs.zsh-forgit}/share/zsh/zsh-forgit";
      }
    ];

    shellAliases = {
      c = "clear";
      v = "$EDITOR";
      vim = "$EDITOR";
      # wifi = "nmtui";
      shutdown = "systemctl poweroff";
      lock = "loginctl lock-session";

      zshconfig = "$EDITOR ${flakeDir}";

      ls = "eza -a --icons=always";
      ll = "eza -al --icons=always";
      lt = "eza -a --tree --level=1 --icons=always";
      grep = "rg";
      clock = "tty-clock";
      nyaafetch = ''fastfetch | sed -e "s/r/w/g; s/l/w/g; s/L/W/g; s/R/W/g;"'';

      k = "kubectl";
      kc = "kubie ctx";
      kn = "kubie ns";

      rou = "sudo nixos-rebuild switch --flake ${flakeDir}";
      ros = "nixos-rebuild list-generations";
    };

    initContent = lib.mkMerge [
      (lib.mkOrder 1500 (builtins.readFile ./zsh/highlight.zsh))

      (lib.mkOrder 1500 ''
        [[ $TERM == xterm-kitty ]] && alias ssh='kitten ssh'

        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        bindkey "^[[H"    beginning-of-line
        bindkey "^[[F"    end-of-line
        bindkey "^[[3~"   delete-char
        bindkey "^[[A"    up-line-or-search
        bindkey "^[[B"    down-line-or-search

        export FORGIT_FZF_DEFAULT_OPTS="
        --height 80%
        --margin 5%
        --border
        --reverse
        "
      '')
    ];
  };

  programs.starship.enable = true;
  xdg.configFile."starship.toml".source = ./zsh/starship.toml;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = [pkgs.tty-clock];
}
