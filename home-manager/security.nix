{pkgs, ...}: {
  programs.password-store.enable = true;

  home.packages = with pkgs; [
    age
    mkpasswd
    veracrypt

    # services.pcscd and hardware.gpgSmartcards are enabled system-side.
    yubikey-manager
    yubioath-flutter
  ];
}
