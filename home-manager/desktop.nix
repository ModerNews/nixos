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
        after_sleep_cmd = "sleep 2 && hyprctl reload";
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

  programs.hyprlock = {
    enable = true;

    settings = {
      background = [
        {
          monitor = "";
          path = wallpaper;
          blur_size = 3;
          blur_passes = 1;
          vibrancy = 0.1696;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "250, 25";
          outline_thickness = 3;
          dots_size = 0.2;
          dots_spacing = 0.64;
          dots_center = true;
          outer_color = "rgb(ad2a30)";
          inner_color = "rgb(1b1924)";
          font_color = "rgb(fefefe)";
          fade_on_empty = true;
          placeholder_text = "<i>Password...</i>";
          hide_input = false;
          position = "0, 75";
          halign = "center";
          valign = "bottom";
        }
      ];

      label = [
        # Current time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<b><big> $(date +"%H:%M:%S") </big></b>"'';
          color = "rgb(fefefe)";
          font_size = 64;
          font_family = "JetBrains Mono Nerd Font 10";
          position = "0, 16";
          halign = "center";
          valign = "center";
        }
        # User label
        {
          monitor = "";
          text = ''cmd[] echo "$(hyprctl splash)"'';
          color = "rgb(fefefe)";
          font_size = 20;
          font_family = "JetBrains Mono Nerd Font 10";
          position = "0, -50";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "Type to unlock!";
          color = "rgb(b0b0b0)";
          font_size = 16;
          font_family = "JetBrains Mono Nerd Font 10";
          position = "0, 30";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = wallpaper;
        }
      ];
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

    themes.gruzin-dark = {
      meta = {
        version = 1;
        name = "Gruzin Dark";
        description = "Matches the rest of the desktop theme";
        variant = "dark";
        inherits = "vicinae-dark";
      };

      colors = {
        core = {
          background = "#1a0808";
          foreground = "#fefefe";
          secondary_background = "#241212";
          border = "#ad2a30";
          accent = "#ad2a30";
        };

        accents = {
          red = "#d83e4a";
          orange = "#f36630";
          yellow = "#ffcc33";
          green = "#86a87e";
          cyan = "#a1e7eb";
          blue = "#4c6a84";
          purple = "#d89fff";
          magenta = "#e165a7";
        };

        list.item.selection = {
          background = "#2a1418";
          secondary_background = "colors.core.accent";
        };

        grid.item.background = "#241212";
      };
    };

    settings = {
      theme.dark.name = "gruzin-dark";

      launcher_window = {
        opacity = 0.65;
        material = "blur";
        rounding = 10;
        client_side_decorations.border_width = 2;
      };
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

    playerctl # XF86AudioPlay/Next/Prev
    pamixer # XF86AudioMicMute
    brightnessctl # XF86MonBrightness* — see note below
    pavucontrol # scratchpad: audio
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
}
