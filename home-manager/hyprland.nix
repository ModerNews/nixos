{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.generators) mkLuaInline;

  descPrimary = "AOC 27G2WG3- YJEP6HA000202";
  descPortrait = "Dell Inc. DELL U2722D 8335X83";
  descRight = "AOC 27V2G5 0x000001AD";

  monPrimary = "desc:${descPrimary}";
  monPortrait = "desc:${descPortrait}";
  monRight = "desc:${descRight}";

  scratchpads = [
    {
      key = "A";
      name = "audio";
      class = "org.pulseaudio.pavucontrol";
      cmd = "pavucontrol";
      w = 900;
      h = 600;
    }
    {
      key = "F";
      name = "files";
      class = "kitty-yazi";
      cmd = "kitty --class kitty-yazi --override confirm_os_window_close=0 -- yazi";
      w = 1200;
      h = 800;
    }
  ];

  fiioScript = "$HOME/.config/hypr/scripts/fiio-ha.sh";
  fiioBinds = [
    {
      code = 191;
      action = "btn1";
    }
    {
      code = 193;
      action = "btn2";
    }
    {
      code = 195;
      action = "btn3";
    }
    {
      code = 199;
      action = "led_toggle";
    }
    {
      code = 197;
      action = "led_dim 10";
      repeating = true;
    }
    {
      code = 198;
      action = "led_dim -10";
      repeating = true;
    }
    {
      code = 197;
      mod = "SHIFT";
      action = "led_color 10";
      repeating = true;
    }
    {
      code = 198;
      mod = "SHIFT";
      action = "led_color -10";
      repeating = true;
    }
  ];

  bind = key: dispatcher: {_args = [key (mkLuaInline dispatcher)];};
  bindOpts = key: dispatcher: opts: {_args = [key (mkLuaInline dispatcher) opts];};
  exec = cmd: "hl.dsp.exec_cmd(${builtins.toJSON cmd})";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    settings = {
      mainMod._var = "SUPER";
      terminal._var = "kitty";
      fileManager._var = "yazi";
      menu._var = "vicinae toggle";

      DESC_PRIMARY._var = descPrimary;
      DESC_PORTRAIT._var = descPortrait;
      DESC_RIGHT._var = descRight;
      MON_PRIMARY._var = monPrimary;
      MON_PORTRAIT._var = monPortrait;
      MON_RIGHT._var = monRight;

      env = [
        {_args = ["XDG_SESSION_TYPE" "wayland"];}
        {_args = ["MOZ_ENABLE_WAYLAND" "1"];}
        {_args = ["NVD_BACKEND" "direct"];}
        {_args = ["ELECTRON_OZONE_PLATFORM_HINT" "wayland"];}
        {_args = ["XCURSOR_SIZE" "24"];}
        {_args = ["QT_QPA_PLATFORMTHEME" "qt6ct"];}
        # Runtime lookup, so it stays a Lua expression rather than a literal.
        {
          _args = [
            "SSH_AUTH_SOCK"
            (mkLuaInline ''os.getenv("XDG_RUNTIME_DIR") .. "/gcr/ssh"'')
          ];
        }
      ];

      monitor = [
        {
          output = monPrimary;
          mode = "1920x1080@165";
          position = "1440x0";
          scale = 1;
        }
        {
          output = monPortrait;
          mode = "2560x1440@60";
          position = "0x0";
          scale = 1;
          transform = 3;
        }
        {
          output = monRight;
          mode = "1920x1080@75";
          position = "3360x0";
          scale = 1;
        }
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = "auto";
        }
      ];

      workspace_rule =
        # primary (centre): 1–5 · right: 6–10 · portrait: 11
        (lib.imap1 (i: _: {
            workspace = toString i;
            monitor = monPrimary;
            default = i == 1;
          })
          (lib.range 1 5))
        ++ (lib.imap1 (i: _: {
            workspace = toString (i + 5);
            monitor = monRight;
            default = i == 1;
          })
          (lib.range 1 5))
        ++ [
          {
            workspace = "11";
            monitor = monPortrait;
            default = true;
            persistent = true;
            layout = "scrolling";
          }
        ]
        ++ map (sp: {
          workspace = "special:${sp.name}";
          on_created_empty = sp.cmd;
        })
        scratchpads;

      config = {
        general = {
          gaps_in = 5;
          gaps_out = {
            top = 5;
            right = 15;
            bottom = 15;
            left = 15;
          };
          border_size = 2;
          col = {
            active_border = {
              colors = ["rgba(ad2a30ee)" "rgba(D65237ee)"];
              angle = 45;
            };
            inactive_border = "rgba(595959aa)";
          };
          layout = "dwindle";
          allow_tearing = false;
        };

        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 2;
            passes = 4;
            vibrancy = 0.97;
          };
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = mkLuaInline "0xee1a1a1a";
          };
        };

        animations.enabled = true;

        input = {
          kb_layout = "pl";
          kb_variant = "";
          kb_model = "pc104";
          kb_options = "";
          kb_rules = "";
          follow_mouse = 1;
          mouse_refocus = false;
          sensitivity = 0;
          touchpad.natural_scroll = false;
        };

        cursor = {
          no_hardware_cursors = true;
          use_cpu_buffer = true;
          enable_hyprcursor = true;
        };

        dwindle = {
          preserve_split = true;
          force_split = 2;
        };

        master.new_status = "master";

        scrolling = {
          direction = "down";
          column_width = 0.9;
          focus_fit_method = 1;
        };

        misc = {
          force_default_wallpaper = -1;
          mouse_move_enables_dpms = true;
        };

        binds.scroll_event_delay = 0;

        debug = {
          disable_logs = false;
          enable_stdout_logs = true;
        };
      };

      # `curve` is in importantPrefixes, so it is emitted before `animation`.
      curve = [
        {
          _args = [
            "myBezier"
            {
              type = "bezier";
              points = [[0.05 0.9] [0.1 1.05]];
            }
          ];
        }
      ];

      animation = [
        {
          leaf = "windows";
          enabled = true;
          speed = 7;
          bezier = "myBezier";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 7;
          bezier = "default";
          style = "popin 80%";
        }
        {
          leaf = "border";
          enabled = true;
          speed = 10;
          bezier = "default";
        }
        {
          leaf = "borderangle";
          enabled = true;
          speed = 8;
          bezier = "default";
        }
        {
          leaf = "fade";
          enabled = true;
          speed = 7;
          bezier = "default";
        }
        {
          leaf = "workspaces";
          enabled = true;
          speed = 6;
          bezier = "default";
        }
      ];

      layer_rule = [
        {
          name = "blur-swaync-notifications";
          match.namespace = "swaync-notification-window";
          blur = true;
        }
        {
          name = "blur-swaync-cc";
          match.namespace = "swaync-control-center";
          blur = true;
          ignore_alpha = 0.3;
        }
        {
          name = "blur-swaync-notif-alpha";
          match.namespace = "swaync-notification-window";
          ignore_alpha = 0.3;
        }
        {
          name = "blur-vicinae";
          match.namespace = "vicinae";
          blur = true;
        }
        {
          name = "no-anim-vicinae";
          match.namespace = "vicinae";
          no_anim = true;
        }
        {
          name = "blur-eww";
          match.namespace = "eww";
          blur = true;
        }
        {
          name = "blur-popups-eww";
          match.namespace = "eww";
          blur_popups = true;
        }
        {
          name = "ignore-alpha-eww";
          match.namespace = "eww";
          ignore_alpha = 0;
        }
      ];

      window_rule =
        [
          {
            name = "float_modals";
            match.title = "^(Preferences|Settings|Options|About|Help|Add-ons|Extensions|Add Extension|Extensions and Themes|Add-ons Manager|Certificate Manager|History|Clear Recent History|Page Info|Manage Bookmarks|Edit Bookmark|New Bookmark|Organize Bookmarks|Library|Save File|File Upload|Select a File|Select Files|Open File|Open Files|Open Location|Choose Files|Save As|Confirm to replace files|File Operation Progress)$";
            float = true;
          }
          # ETS2 under gamescope, spanning primary + right
          {
            name = "ets2";
            match = {
              class = "^(gamescope)$";
              initial_title = "^(Euro Truck Simulator 2)$";
            };
            monitor = monPrimary;
            size = "3840 1080";
            move = "0 0";
            border_size = 0;
            no_shadow = true;
            pin = true;
            float = true;
            no_vrr = true;
          }
          {
            name = "gamescope";
            match.class = "^(gamescope)$";
            fullscreen = true;
          }
        ]
        ++ map (sp: {
          name = "scratchpad-${sp.name}";
          match.class = sp.class;
          float = true;
          center = true;
          size = "${toString sp.w} ${toString sp.h}";
        })
        scratchpads;

      bind =
        [
          (bindOpts "XF86AudioRaiseVolume" (exec "pactl set-sink-volume @DEFAULT_SINK@ +5%") {
            locked = true;
            repeating = true;
          })
          (bindOpts "XF86AudioLowerVolume" (exec "pactl set-sink-volume @DEFAULT_SINK@ -5%") {
            locked = true;
            repeating = true;
          })
          (bindOpts "XF86AudioMicMute" (exec "pamixer --default-source -m") {locked = true;})
          (bindOpts "XF86AudioMute" (exec "pactl set-sink-mute @DEFAULT_SINK@ toggle") {locked = true;})
          (bindOpts "XF86AudioPlay" (exec "playerctl play-pause") {locked = true;})
          (bindOpts "XF86AudioPause" (exec "playerctl play-pause") {locked = true;})
          (bindOpts "XF86AudioNext" (exec "playerctl next") {locked = true;})
          (bindOpts "XF86AudioPrev" (exec "playerctl previous") {locked = true;})

          (bindOpts "XF86MonBrightnessUp" (exec "brightnessctl s +5%") {
            locked = true;
            repeating = true;
          })
          (bindOpts "XF86MonBrightnessDown" (exec "brightnessctl s 5%-") {
            locked = true;
            repeating = true;
          })

          # Applications
          (bind "SUPER + Return" "hl.dsp.exec_cmd(terminal)")
          (bind "SUPER + SHIFT + Q" "hl.dsp.window.close()")
          (bind "SUPER + SHIFT + E" (exec "$HOME/.config/eww/scripts/launcher toggle_menu powermenu"))
          (bind "SUPER + Space" ''hl.dsp.window.float({ action = "toggle" })'')
          (bind "SUPER + D" "hl.dsp.exec_cmd(menu)")
          (bind "SUPER + P" "hl.dsp.window.pseudo()")
          (bind "SUPER + J" ''hl.dsp.layout("togglesplit")'')
          (bind "SUPER + F" "hl.dsp.window.fullscreen()")
          (bind "SUPER + SHIFT + S" (exec "grimblast --notify --freeze copysave area"))
          (bind "SUPER + L" (exec "loginctl lock-session"))
          (bind "SUPER + V" (exec "vicinae vicinae://launch/clipboard/history"))

          # Focus
          (bind "SUPER + left" ''hl.dsp.focus({ direction = "left" })'')
          (bind "SUPER + right" ''hl.dsp.focus({ direction = "right" })'')
          (bind "SUPER + up" ''hl.dsp.focus({ direction = "up" })'')
          (bind "SUPER + down" ''hl.dsp.focus({ direction = "down" })'')

          # Move windows
          (bind "SUPER + SHIFT + left" ''hl.dsp.window.move({ direction = "left" })'')
          (bind "SUPER + SHIFT + right" ''hl.dsp.window.move({ direction = "right" })'')
          (bind "SUPER + SHIFT + up" ''hl.dsp.window.move({ direction = "up" })'')
          (bind "SUPER + SHIFT + down" ''hl.dsp.window.move({ direction = "down" })'')

          # Special workspace
          (bind "SUPER + I" ''hl.dsp.workspace.toggle_special("magic")'')
          (bind "SUPER + SHIFT + I" ''hl.dsp.window.move({ workspace = "special:magic" })'')

          # Workspace 11 — portrait, scrolling layout
          (bind "SUPER + grave" "hl.dsp.focus({ workspace = 11 })")
          (bind "SUPER + SHIFT + grave" "hl.dsp.window.move({ workspace = 11 })")

          # Resize submap entry
          (bind "SUPER + R" ''hl.dsp.submap("resize")'')

          # Mouse move/resize. The Lua API expresses these as a bind with
          # `mouse = true`, not as a separate bindm.
          (bindOpts "SUPER + mouse:272" "hl.dsp.window.drag()" {mouse = true;})
          (bindOpts "SUPER + mouse:273" "hl.dsp.window.resize()" {mouse = true;})
        ]
        ++ map (sp: bind "SUPER + SHIFT + ${sp.key}" ''hl.dsp.workspace.toggle_special("${sp.name}")'') scratchpads
        ++ map (
          b:
            bindOpts
            "${lib.optionalString (b ? mod) "${b.mod} + "}code:${toString b.code}"
            (exec "${fiioScript} ${b.action}")
            {repeating = b.repeating or false;}
        )
        fiioBinds;
    };

    submaps.resize.settings.bind = [
      (bindOpts "right" "hl.dsp.window.resize({ x = 10, y = 0, relative = true })" {repeating = true;})
      (bindOpts "left" "hl.dsp.window.resize({ x = -10, y = 0, relative = true })" {repeating = true;})
      (bindOpts "up" "hl.dsp.window.resize({ x = 0, y = 10, relative = true })" {repeating = true;})
      (bindOpts "down" "hl.dsp.window.resize({ x = 0, y = -10, relative = true })" {repeating = true;})
      (bind "escape" ''hl.dsp.submap("reset")'')
    ];

    extraConfig = builtins.readFile ./hypr/imperative.lua;
  };
}
