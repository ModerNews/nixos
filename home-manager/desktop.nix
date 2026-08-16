{
  config,
  lib,
  pkgs,
  ...
}: let
  wallpaper = "${./wallpapers/Wallpaper1080p.jpg}";
in {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms(\"on\")'";
        on_lock_cmd = "busctl call org.freedesktop.login1 /org/freedesktop/login1/session/auto org.freedesktop.login1.Session SetLockedHint b true";
        on_unlock_cmd = "busctl call org.freedesktop.login1 /org/freedesktop/login1/session/auto org.freedesktop.login1.Session SetLockedHint b false";
      };

      listener = [
        {
          timeout = 300; # 5min — lock
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330; # 5.5min — screen off
          on-timeout = "hyprctl dispatch 'hl.dsp.dpms(\"off\")'";
          on-resume = "hyprctl dispatch 'hl.dsp.dpms(\"on\")'";
        }
        {
          timeout = 1800; # 30min — suspend
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [wallpaper];
      wallpaper = [",${wallpaper}"];
    };
  };

  services.cliphist = {
    enable = true;
    allowImages = true;
  };

  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
  };

  programs.eww = {
    enable = true;
    systemd.enable = true;
  };

  xdg.configFile."eww" = {
    source = ./eww;
    recursive = true;
  };

  home.packages = with pkgs; [
    jq
    grimblast
    hyprpicker
    wl-clipboard # wl-copy
    libnotify # notify-send
    pulseaudio # pactl
  ];

  systemd.user.services.eww-bars = {
    Unit = {
      Description = "Open eww bars";
      PartOf = [config.wayland.systemd.target];
      After = ["eww.service" config.wayland.systemd.target];
      Requires = ["eww.service"];
    };
    Install.WantedBy = [config.wayland.systemd.target];
    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${lib.getExe pkgs.eww} open-many bar0 bar1 bar2";
      ExecStop = "${lib.getExe pkgs.eww} close-all";
    };
  };

  systemd.user.services.bitwarden = {
    Unit = {
      Description = "Bitwarden desktop";
      PartOf = [config.wayland.systemd.target];
      After = [config.wayland.systemd.target];
    };
    Install.WantedBy = [config.wayland.systemd.target];
    Service = {
      ExecStart = "${lib.getExe pkgs.bitwarden-desktop}";
      Restart = "on-failure";
    };
  };
}
