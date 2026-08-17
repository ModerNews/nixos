{pkgs, ...}: let
  red = "#d83e4a"; # Statement/Type/Directory
  redAccent = "#ad2a30"; # Visual/Search/CursorLine
  orange = "#f36630"; # Function
  green = "#86a87e"; # String
  yellow = "#ffcc33"; # ColorYellow
  cyan = "#a1e7eb"; # Constant
  purple = "#d89fff"; # ColorPurple
  navy = "#1a2a53"; # StatusLine/VertSplit
  gray = "#666666"; # LineNr
  comment = "#4c6a84"; # Comment/Special
  fg = "#fefefe"; # Normal
  error = "#ff0000"; # Error/DiagnosticError
in {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    theme = {
      mgr = {
        cwd = {
          fg = red;
          bold = true;
        };

        find_keyword = {
          fg = fg;
          bg = redAccent;
          bold = true;
        };
        find_position = {
          fg = orange;
          bold = true;
          italic = true;
        };

        marker_copied = {
          fg = green;
          bg = green;
        };
        marker_cut = {
          fg = red;
          bg = red;
        };
        marker_marked = {
          fg = cyan;
          bg = cyan;
        };
        marker_selected = {
          fg = redAccent;
          bg = redAccent;
        };

        count_copied = {
          fg = fg;
          bg = green;
        };
        count_cut = {
          fg = fg;
          bg = red;
        };
        count_selected = {
          fg = fg;
          bg = redAccent;
        };

        border_symbol = "│";
        border_style.fg = navy;
      };

      tabs = {
        active = {
          fg = fg;
          bg = redAccent;
          bold = true;
        };
        inactive = {
          fg = gray;
          bg = "#333333";
        };
      };

      mode = {
        normal_main = {
          fg = fg;
          bg = redAccent;
          bold = true;
        };
        normal_alt = {
          fg = redAccent;
          bg = navy;
        };

        select_main = {
          fg = fg;
          bg = green;
          bold = true;
        };
        select_alt = {
          fg = green;
          bg = navy;
        };

        unset_main = {
          fg = fg;
          bg = orange;
          bold = true;
        };
        unset_alt = {
          fg = orange;
          bg = navy;
        };
      };

      status = {
        perm_sep = {fg = gray;};
        perm_type = {fg = cyan;};
        perm_read = {fg = yellow;};
        perm_write = {fg = red;};
        perm_exec = {fg = green;};

        progress_label = {
          fg = fg;
          bold = true;
        };
        progress_normal = {
          fg = green;
          bg = "#333333";
        };
        progress_error = {
          fg = yellow;
          bg = red;
        };
      };

      pick = {
        border.fg = navy;
        active = {
          fg = orange;
          bold = true;
        };
        inactive = {};
      };

      input = {
        border.fg = navy;
        title = {};
        value = {};
        selected.reversed = true;
      };

      cmp.border.fg = navy;

      tasks = {
        border.fg = navy;
        title = {};
        hovered = {
          fg = orange;
          bold = true;
        };
      };

      which = {
        border.fg = navy;
        cand.fg = cyan;
        rest.fg = gray;
        desc.fg = orange;
        separator = "  ";
        separator_style.fg = comment;
      };

      help = {
        on.fg = cyan;
        run.fg = orange;
        hovered = {
          reversed = true;
          bold = true;
        };
        footer = {
          fg = navy;
          bg = fg;
        };
      };

      spot = {
        border.fg = navy;
        title.fg = navy;
        tbl_col.fg = cyan;
        tbl_cell = {
          fg = orange;
          bg = "#333333";
        };
      };

      notify = {
        title_info.fg = green;
        title_warn.fg = yellow;
        title_error.fg = error;
      };

      filetype.rules = [
        {
          mime = "**/image/*";
          fg = cyan;
        }
        {
          mime = "**/{audio,video}/*";
          fg = yellow;
        }
        {
          mime = "**/application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}";
          fg = purple;
        }
        {
          mime = "**/application/{pdf,doc,rtf}";
          fg = green;
        }
        {
          mime = "vfs/{absent,stale}";
          fg = gray;
        }
        {
          url = "*";
          fg = fg;
        }
        {
          url = "*/";
          fg = comment;
        }
      ];

      icon.conds = [
        {
          "if" = "orphan";
          text = "";
          fg = fg;
        }
        {
          "if" = "link";
          text = "";
          fg = navy;
        }
        {
          "if" = "block";
          text = "";
          fg = purple;
        }
        {
          "if" = "char";
          text = "";
          fg = purple;
        }
        {
          "if" = "fifo";
          text = "";
          fg = purple;
        }
        {
          "if" = "sock";
          text = "";
          fg = purple;
        }
        {
          "if" = "sticky";
          text = "";
          fg = purple;
        }
        {
          "if" = "dummy";
          text = "";
          fg = red;
        }
        {
          "if" = "dir & hovered";
          text = "";
          fg = comment;
        }
        {
          "if" = "dir";
          text = "";
          fg = comment;
        }
        {
          "if" = "exec";
          text = "";
          fg = green;
        }
        {
          "if" = "!dir";
          text = "";
          fg = fg;
        }
      ];
    };
  };

  # Moving files around, in and out of the machine.
  home.packages = with pkgs; [
    rsync
    sshfs
    qbittorrent
    filezilla
    ncdu
    qdirstat
  ];

  # xdg-open on a directory was landing in IntelliJ (whichever app last
  # registered inode/directory); route it through yazi in a kitty window,
  # reusing the same --class as the kitty-yazi scratchpad in hyprland.nix
  # so it picks up the same float/center window rule.
  xdg.desktopEntries.kitty-yazi = {
    name = "Yazi (kitty)";
    genericName = "File Manager";
    exec = "kitty --class kitty-yazi --override confirm_os_window_close=0 -- yazi %f";
    terminal = false;
    icon = "yazi";
    mimeType = ["inode/directory"];
    noDisplay = true;
  };

  xdg.mimeApps.defaultApplications."inode/directory" = ["kitty-yazi.desktop"];
}
