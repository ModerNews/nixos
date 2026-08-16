{inputs, ...}: {
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];
  services.flatpak = {
    enable = true;

    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    packages = [
      "com.discordapp.Discord"
      "org.onlyoffice.desktopeditors"
      "org.signal.Signal"
      "com.github.tchx84.Flatseal" # per-app permission editor
      "com.jetbrains.IntelliJ-IDEA-Ultimate"
      "com.jetbrains.PyCharm-Professional"
    ];

    overrides.global = {
      Context.filesystems = ["~/.themes:ro"];
      Environment = {
        GTK_THEME = "";
        ICON_THEME = "";
      };
    };
  };
}
