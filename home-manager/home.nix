{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./desktop.nix
    ./swaync.nix
    ./zsh.nix
    ./terminal.nix
    ./nvim.nix
    ./containers.nix
    ./packages.nix
    ./dev.nix
    ./theming.nix
    ./browser.nix
    ./ssh.nix
  ];

  # nixpkgs.overlays lives in nixos/configuration.nix — useGlobalPkgs = true
  # means Home Manager shares that instance rather than building its own.

  home = {
    username = "gruzin";
    homeDirectory = "/home/gruzin";
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Polkit authentication agent. GTK4, to match gnome-secrets / GDM /
  # gnome-keyring; no HM module exists for it, hence the unit by hand.
  #
  # wayland.systemd.target defaults to graphical-session.target and follows
  # hyprland-session.target automatically once the Hyprland module is enabled.
  systemd.user.services.soteria = {
    Unit = {
      Description = "Polkit authentication agent";
      PartOf = [config.wayland.systemd.target];
      After = [config.wayland.systemd.target];
    };
    Install.WantedBy = [config.wayland.systemd.target];
    Service = {
      ExecStart = "${pkgs.soteria}/bin/soteria";
      Restart = "on-failure";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.05";
}
