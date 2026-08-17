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
      general = {
        hide_cursor = false;
        ignore_empty_input = true;
      };

      animations = {
        enabled = true;
        fade_in = {
          duration = 300;
          bezier = "easeOutQuint";
        };
        fade_out = {
          duration = 300;
          bezier = "easeOutQuint";
        };
      };

      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 4;
          blur_size = 2;
          vibrancy = 0.97;
          brightness = 0.65;
          contrast = 0.9;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "280, 60";
          position = "0, -160";
          halign = "center";
          valign = "center";
          rounding = 10;
          outline_thickness = 2;
          outer_color = "rgba(ad2a30ee)";
          inner_color = "rgba(181818cc)";
          font_color = "rgba(eeeeeeff)";
          font_family = "JetBrainsMono Nerd Font";
          fail_color = "rgba(f66151ee)";
          check_color = "rgba(57e389ee)";
          placeholder_text = ''<span foreground="##eeeeee88">Input password...</span>'';
          fade_on_empty = false;
          dots_center = true;
          shadow_passes = 2;
          shadow_color = "rgba(1a1a1aee)";
        }
      ];

      label = [
        {
          monitor = "";
          text = ''<span font_weight="ultrabold">$TIME</span>'';
          font_family = "JetBrainsMono Nerd Font";
          font_size = 100;
          color = "rgba(eeeeeeff)";
          halign = "center";
          valign = "center";
          position = "0, 300";
          shadow_passes = 2;
          shadow_color = "rgba(000000aa)";
        }
        {
          monitor = "";
          text = ''cmd[update:60000] date +"%A, %-d %B"'';
          font_family = "JetBrainsMono Nerd Font";
          font_size = 22;
          color = "rgba(eeeeeeaa)";
          halign = "center";
          valign = "center";
          position = "0, 200";
        }
        {
          monitor = "";
          text = ''<span font_weight="bold">  $USER</span>'';
          font_family = "JetBrainsMono Nerd Font";
          font_size = 18;
          color = "rgba(eeeeeeff)";
          halign = "center";
          valign = "center";
          position = "0, -80";
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
