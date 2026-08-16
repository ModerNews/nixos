{pkgs, ...}: {
  home.packages = with pkgs; [
    # ---- shell & system -----------------------------------------------------
    p7zip
    age
    # Needed to rotate passwords AFTER install: with mutableUsers = false,
    # `passwd` does not work — you regenerate the hash and edit sops.
    mkpasswd
    bottom
    htop
    ncdu
    qdirstat
    tree
    tldr
    hexyl
    fd
    yq-go
    tmux
    lazygit
    gh
    gitleaks
    git-lfs
    pandoc
    pass
    rsync
    sshfs
    socat
    nethogs
    nvtopPackages.amd
    smartmontools
    strace
    lsof
    parallel
    asciinema
    silicon
    veracrypt
    yt-dlp
    imagemagick
    ffmpeg

    # Toolchains live in ./dev.nix — the short global set plus direnv, with
    # everything version-sensitive moved to per-project flakes (T4).

    # ---- infra / k8s --------------------------------------------------------
    kubectl
    kubie
    kubernetes-helm
    minikube
    kompose
    argocd
    cilium-cli
    terraform
    ansible
    vault
    ngrok
    dyff
    gomplate

    # ---- desktop apps -------------------------------------------------------
    chromium # debugging counterpart to LibreWolf
    element-desktop
    thunderbird
    spotify
    vlc
    mpv
    obs-studio
    gpu-screen-recorder
    audacity
    kdePackages.kdenlive
    gimp3
    krita
    pinta
    anki
    qbittorrent
    filezilla
    ranger
    feh

    # IDEs and Signal come from Flatpak — see nixos/flatpak.nix.

    # ---- gaming -------------------------------------------------------------
    lutris
    wineWow64Packages.stable
    winetricks
    gamescope
    mangohud
    protonup-qt
    legendary-gl

    # ---- theming ------------------------------------------------------------
    matugen
    adw-gtk3
    qt6Packages.qt6ct

    # ---- yubikey ------------------------------------------------------------
    yubikey-manager
    yubioath-flutter
  ];
}
