{
  config,
  pkgs,
  ...
}: {
  # ---------------------------------------------------------------------------
  # Desktop session
  # ---------------------------------------------------------------------------
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;

  # ---------------------------------------------------------------------------
  # Gaming
  # ---------------------------------------------------------------------------
  programs.steam = {
    enable = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
  };

  # Handles its own limits and polkit rules.
  programs.gamemode.enable = true;

  # System-level rather than a user package: capSysNice grants gamescope the
  # real-time scheduling priority it wants, which a package in home.packages
  # cannot obtain.
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  # ---------------------------------------------------------------------------
  # Capture
  # ---------------------------------------------------------------------------
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark; # GUI; the default is the CLI build
  };

  # OBS virtual camera.
  boot.extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
  boot.kernelModules = ["v4l2loopback"];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Virtual Camera" exclusive_caps=1
  '';

  # ---------------------------------------------------------------------------
  # Misc
  # ---------------------------------------------------------------------------
  programs.nix-ld.enable = true;

  environment.systemPackages = [pkgs.kitty.terminfo];

  # ---------------------------------------------------------------------------
  # FiiO KB1 (T10)
  # ---------------------------------------------------------------------------
  services.kmonad = {
    enable = true;
    keyboards.fiio = {
      name = "fiio";
      device = "/dev/input/by-id/usb-SayoDevice_FiiO_KB1_037338376408BEF5400000000000-if01-event-kbd";
      defcfg = {
        enable = true;
        fallthrough = true; # re-emit keys the config does not handle
        allowCommands = true; # the original set allow-cmd true
      };
      config = builtins.readFile ./kmonad/fiio.kbd;
    };
  };
}
