{...}: {
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

  boot.supportedFilesystems = ["nfs"];
  services.rpcbind.enable = true;

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

    "/home/gruzin/.local/share/Steam" = {
      device = "/mnt/data/steam";
      fsType = "none";
      options = ["bind"];
    };

    "/home/gruzin/VMs" = {
      device = "/mnt/data/vms";
      fsType = "none";
      options = ["bind"];
    };

    "/home/gruzin/Downloads" = {
      device = "/mnt/data/scratch/downloads";
      fsType = "none";
      options = ["bind"];
    };

    "/opt/steam-lib" = {
      device = "/dev/vg_evo/lv_games";
      fsType = "xfs";
      options = ["noatime"];
    };
  };

  swapDevices = [];
  zramSwap.enable = true;
}
