{pkgs, ...}: {
  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };

    font = {
      name = "Noto Sans";
      size = 11;
    };

    colorScheme = "dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style.name = "adwaita-dark";
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

  home.packages = with pkgs; [
    matugen
    adw-gtk3
    qt6Packages.qt6ct
  ];
}
