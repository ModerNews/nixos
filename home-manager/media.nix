{
  pkgs,
  lib,
  ...
}: {
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

  # Without this, video/audio/image MIME defaults are whatever last claimed
  # them (e.g. audio/mpeg and audio/flac were defaulting to Audacity, and
  # images were opening in chromium instead of feh).
  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      mpvTypes = [
        "video/mp4"
        "video/x-matroska"
        "video/webm"
        "video/quicktime"
        "video/x-msvideo"
        "video/mpeg"
        "video/x-flv"
        "video/3gpp"
        "video/ogg"
        "audio/mpeg"
        "audio/mp4"
        "audio/flac"
        "audio/ogg"
        "audio/x-wav"
        "audio/wav"
        "audio/aac"
        "audio/x-aiff"
        "audio/x-ms-wma"
        "application/ogg"
      ];
      fehTypes = [
        "image/png"
        "image/jpeg"
        "image/gif"
        "image/webp"
        "image/bmp"
        "image/tiff"
      ];
    in
      lib.genAttrs mpvTypes (_: ["mpv.desktop"])
      // lib.genAttrs fehTypes (_: ["feh.desktop"]);
  };
}
