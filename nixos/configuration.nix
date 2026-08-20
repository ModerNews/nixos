{inputs, ...}: {
  imports = [
    # Regenerate with: nixos-generate-config --root /mnt --no-filesystems
    ./hardware-configuration.nix

    inputs.impermanence.nixosModules.impermanence
    ./secrets.nix
    ./desktop-hardware.nix
    ./programs.nix
    ./fonts.nix
    ./flatpak.nix

    ../modules/nixos/wireguard-netdev.nix
    ./boot.nix
    ./persistence.nix
    ./networking.nix
    ./users.nix
    ./virtualisation.nix
    ./display.nix
  ];

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
    };
    channel.enable = false;
  };

  system.stateVersion = "26.05";
}
