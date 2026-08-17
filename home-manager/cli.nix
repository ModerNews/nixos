{pkgs, ...}: {
  programs.htop.enable = true;
  programs.fastfetch.enable = true;
  programs.jq.enable = true;
  programs.ripgrep.enable = true;
  programs.fd.enable = true;
  programs.yt-dlp.enable = true;
  programs.asciinema.enable = true;

  programs.eza = {
    enable = true;
    enableZshIntegration = false;
  };

  home.packages = with pkgs; [
    bottom
    tree
    tldr
    hexyl
    yq-go
    pandoc
    socat
    parallel
    silicon
    imagemagick
    ffmpeg

    # diagnostics
    nethogs
    nvtopPackages.amd
    smartmontools
    strace
    lsof
  ];
}
