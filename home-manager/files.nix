{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
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
