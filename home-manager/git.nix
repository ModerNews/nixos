{pkgs, ...}: {
  # Carried from the live config on the thinkpad, not invented.
  #
  # NOTE: userName / userEmail / extraConfig are DEPRECATED in Home Manager
  # 26.05 — they warn and redirect to programs.git.settings.*, mirroring the
  # same move programs.ssh made from matchBlocks to settings. Keys under
  # `settings` are literal git-config paths.
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Grzegorz Jagielski";
        email = "grzegorz.jagielski@gruzin.eu";
      };

      # Signing is on, and the key is YubiKey-only — which is exactly why
      # `git commit` cannot run unattended without the key plugged in.
      user.signingkey = "3DDDE2A9D8966841";
      commit.gpgsign = true;

      merge.tool = "nvim";
      mergetool.nvim.cmd = "nvim -d $LOCAL $BASE $REMOTE $MERGED -c '4wincmd w' -c 'wincmd J' -c 'wincmd ='";

      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };

    # Repo-agnostic noise that should never be committed anywhere.
    ignores = [
      ".direnv/"
      "result"
      "result-*"
      ".DS_Store"
    ];
  };

  programs.lazygit.enable = true;

  programs.gh = {
    enable = true;

    settings = {
      git_protocol = "ssh";
      editor = "nvim";
      prompt = "enabled";
    };

    gitCredentialHelper = {
      enable = true;
      hosts = ["https://github.com" "https://gist.github.com"];
    };
  };

  home.packages = with pkgs; [
    git-lfs
    gitleaks
  ];
}
