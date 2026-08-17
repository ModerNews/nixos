{...}: {
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      foreground = "#fefefe";
      background = "#1a0808";
      background_opacity = "0.65";
      background_blur = 1;

      color0 = "#000000";
      color8 = "#1b1722";
      color1 = "#d83e4a";
      color9 = "#ad2a30";
      color2 = "#86a87e";
      color10 = "#14423f";
      color3 = "#ec8509";
      color11 = "#f36630";
      color4 = "#4c6a84";
      color12 = "#1a2a53";
      color5 = "#ffc0ff";
      color13 = "#f189c8";
      color6 = "#a1e7eb";
      color14 = "#4fc7cd";
      color7 = "#dddddd";
      color15 = "#ffffff";

      mark1_foreground = "black";
      mark1_background = "#98d3cb";
      mark2_foreground = "black";
      mark2_background = "#f2dcd3";
      mark3_foreground = "black";
      mark3_background = "#f274bc";

      remember_window_size = "no";
      initial_window_width = 950;
      initial_window_height = 500;
      cursor_blink_interval = "0.5";
      cursor_stop_blinking_after = 1;
      scrollback_lines = 2000;
      wheel_scroll_min_lines = 1;
      enable_audio_bell = "no";
      window_padding_width = 10;
      hide_window_decorations = "yes";
      dynamic_background_opacity = "yes";
      confirm_os_window_close = 0;
      selection_foreground = "none";
      selection_background = "none";
    };
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    terminal = "tmux-256color";
    historyLimit = 10000;
    escapeTime = 10;
    keyMode = "vi";
    extraConfig = ''
      set -g set-clipboard on
    '';
  };
}
