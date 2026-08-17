{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi # hardware encode on amdgpu
      obs-vkcapture # Vulkan/OpenGL game capture, pairs with gamescope
      wlrobs # wlroots screen capture fallback
    ];
  };

  home.packages = with pkgs; [
    vlc
    mpv
    spotify
    audacity
    kdePackages.kdenlive
    gpu-screen-recorder

    # raster / vector
    gimp3
    krita
    feh
  ];
}
