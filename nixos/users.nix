{
  config,
  pkgs,
  ...
}: {
  programs.zsh.enable = true;

  users.users.gruzin = {
    isNormalUser = true;
    description = "Grzegorz Jagielski";
    shell = pkgs.zsh;
    extraGroups = ["wheel" "wireshark"];
    openssh.authorizedKeys.keys = []; # TODO
  };

  users.mutableUsers = false;
  users.users.gruzin.hashedPasswordFile = config.sops.secrets."passwords/gruzin".path;
  users.users.root.hashedPasswordFile = config.sops.secrets."passwords/root".path;

  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    openFirewall = false;
    hostKeys = [
      {
        path = "/persist/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "/persist/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
        bits = 4096;
      }
    ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function (action, subject) {
        if (
          subject.isInGroup("users") &&
          [
            "org.freedesktop.login1.reboot",
            "org.freedesktop.login1.reboot-multiple-sessions",
            "org.freedesktop.login1.power-off",
            "org.freedesktop.login1.power-off-multiple-sessions",
          ].indexOf(action.id) !== -1
        ) {
          return polkit.Result.YES;
        }
      });
    '';
  };

  security.sudo = {
    enable = true;
    execWheelOnly = true;
    # Otherwise the lectured-state sudo keys off doesn't survive each new
    # generation, so the "usual lecture" spiel reappears on first sudo use.
    extraConfig = ''
      Defaults lecture = "never"
    '';
  };

  services.udev.packages = [pkgs.yubikey-personalization];
  services.pcscd.enable = true;
  hardware.gpgSmartcards.enable = true;
}
