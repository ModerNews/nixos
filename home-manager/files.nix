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
}
