{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    silent = true;
  };

  home.packages = with pkgs; [
    claude-code
    codex

    pre-commit
    yamllint
    gnumake
  ];

  # Global Claude Code instructions to avoid agent modifying state instead of declarations
  home.file.".claude/CLAUDE.md".text = ''
    # Global instructions

    ## This machine is managed by NixOS + Home Manager

    `~/.nixos` is the declarative source of truth for this machine (system
    config, packages, services, dotfiles, desktop environment) — see
    `~/.nixos/AGENTS.md` and `~/.nixos/README.md`.

    Whenever a task involves changing a system component — installing or
    removing a package, enabling/configuring a service or systemd unit, editing
    a dotfile or app config, changing desktop/shell/hyprland behavior, touching
    anything under `/etc`, or anything that on a normal distro you'd reach for
    `apt`/`pacman`/manual file edits for — **read `~/.nixos/AGENTS.md` first**
    before doing anything else. Make the change there, in Nix, rather than
    imperatively on the live system. Imperative changes (`nix-env -i`,
    hand-editing `/etc`, manually dropping dotfiles) won't survive a rebuild and
    won't show up in git history, so they're wrong by default on this machine.

    This applies regardless of which directory the session started in — check
    whether the task is "system component" work first, and go read that repo's
    AGENTS.md before proposing an approach.
  '';
}
