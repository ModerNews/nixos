{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Regenerate with: nixos-generate-config --root /mnt --no-filesystems
    ./hardware-configuration.nix

    inputs.impermanence.nixosModules.impermanence
    ./secrets.nix
    ./desktop-hardware.nix
    ./programs.nix
    ./fonts.nix
    ./flatpak.nix
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

  networking = {
    hostName = "gruzin-desktop";
    useNetworkd = true;
    useDHCP = false;
    firewall = {
      enable = true;
      interfaces = {
        "tailscale0" = {
          allowedTCPPorts = [22];
        };
      };
      trustedInterfaces = ["eno1" "lo"];
    };
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  boot.initrd = {
    systemd = {
      network.wait-online.enable = false;
    };
  };

  boot.tmp = {
    useTmpfs = true;
    cleanOnBoot = true;
  };

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = ["defaults" "size=25%" "mode=755"];
    };

    # "/" = {
    #   device = "/dev/vg_evo/lv_root";
    #   fsType = "xfs";
    # };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = ["umask=0077"];
    };

    "/nix" = {
      device = "/dev/vg_evo/lv_nix";
      fsType = "xfs";
      options = ["noatime"];
      neededForBoot = true;
    };

    "/state" = {
      device = "/dev/vg_evo/lv_state";
      fsType = "xfs";
      neededForBoot = true;
    };

    "/persist" = {
      device = "/dev/vg_evo/lv_home";
      fsType = "btrfs";
      options = ["subvol=@persist" "compress=zstd"];
      neededForBoot = true;
    };

    "/home" = {
      device = "/dev/vg_evo/lv_home";
      fsType = "btrfs";
      options = ["subvol=@home" "compress=zstd"];
    };

    "/home/gruzin/.cache" = {
      device = "/dev/vg_evo/lv_home";
      fsType = "btrfs";
      options = ["subvol=@cache" "compress=zstd"];
    };

    "/mnt/data" = {
      device = "/dev/disk/by-label/DATA";
      fsType = "xfs";
    };
  };

  swapDevices = [];
  zramSwap.enable = true;

  # Replicated to the homelab with @home.
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/lib/tailscale"
      "/var/lib/nixos"
      "/var/lib/AccountsService"
      "/var/lib/wireguard"
    ];
    files = [
      "/etc/machine-id"
      "/etc/adjtime"
    ];
  };

  # Persistent but reproducible — never replicated.
  environment.persistence."/state" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/flatpak"
      "/var/lib/systemd"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /home/gruzin 0700 gruzin users -"
    "d /home/gruzin/.cache 0755 gruzin users -"

    "d /state/containers 0755 root root -"
    "d /state/containers/gruzin 0700 gruzin users -"

    # D empties the directory, ! restricts that to boot so a mid-session
    # tmpfiles run cannot delete under an active build.
    "D! /state/ephemeral 0755 root root -"
  ];

  # Off the tmpfs /tmp: with no swap, a large source build there OOMs.
  systemd.services.nix-daemon.environment.TMPDIR = "/state/ephemeral/nix-build";

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

  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = "false";
      FallbackDNS = [];
      MulticastDNS = false;
    };
  };

  systemd.network = {
    enable = true;
    networks = {
      "10-lan" = {
        matchConfig.Name = "eno1";
        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = true;
          DNSDefaultRoute = true;
        };
        dhcpV4Config.UseDNS = true;
        linkConfig.RequiredForOnline = "routable";
      };
      "50-wmswg" = {
        matchConfig.Name = "wmswg";
        address = ["10.0.0.4/32"];
        dns = ["10.10.0.1"];
        domains = ["~wmsdev.pl" "~wmsdev.local"];
        networkConfig.DNSDefaultRoute = false;
        routes = [
          {Destination = "192.168.88.0/24";}
          {Destination = "10.0.0.0/8";}
        ];
        linkConfig.ActivationPolicy = "manual";
      };
    };
    netdevs = {
      "50-wmswg" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wmswg";
        };
        wireguardConfig.PrivateKeyFile = config.sops.secrets."wireguard/wmswg".path;
        wireguardPeers = [
          {
            PublicKey = "XzeoUsUBjuVDiKWoRO1mA8pUVMZfeHocU68RHjT7vEo=";
            AllowedIPs = ["192.168.88.0/24" "10.0.0.0/8"];
            Endpoint = "156.17.229.201:51820";
            PersistentKeepalive = 25;
          }
        ];
      };
    };
    wait-online.enable = false;
  };

  systemd.services.wmswg = {
    enable = true;
    after = ["systemd-networkd.service"];
    wantedBy = [];
    description = "WMS Wireguard Interface";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${config.systemd.package}/bin/networkctl up wmswg";
      ExecStop = "${config.systemd.package}/bin/networkctl down wmswg";
      RemainAfterExit = true;
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
      polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.systemd1.manage-units" &&
            action.lookup("unit") == "wmswg.service" &&
            subject.isInGroup("wheel") &&
            subject.active) {
          var verb = action.lookup("verb");
          if (verb == "start" || verb == "stop" || verb == "restart") {
            return polkit.Result.YES;
          }
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

  programs.nix-ld.enable = true;

  virtualisation = {
    containers = {
      enable = true;
      registries.insecure = ["gruzin.host" "gruzin.host:80" "gruzin.host:5000"];
    };
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  environment.systemPackages = [pkgs.docker-compose];

  services.displayManager.gdm.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm-password.enableGnomeKeyring = true;

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config = {
      common.default = ["gtk"];
      hyprland = {
        default = ["hyprland" "gtk"];
        "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
        "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
      };
    };
  };

  system.stateVersion = "26.05";
}
