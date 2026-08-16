{pkgs, ...}: {
  # ---------------------------------------------------------------------------
  # Locale, console, keyboard, time
  # ---------------------------------------------------------------------------
  time.timeZone = "Europe/Warsaw";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_TIME = "pl_PL.UTF-8";
      LC_MEASUREMENT = "pl_PL.UTF-8";
    };

    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "pl_PL.UTF-8/UTF-8"
    ];
  };

  console.keyMap = "pl2";

  services.xserver.xkb.layout = "pl";

  # ---------------------------------------------------------------------------
  # Kernel
  # ---------------------------------------------------------------------------
  # 26.05 defaults to 6.18.44; the old Arch system ran 7.1.6, and this is an
  # RX 9070 (RDNA4) where amdgpu fixes land continuously. Staying on the default
  # would be regressing the kernel by omission.
  #
  # Verified before switching: v4l2loopback 0.15.3 — the only out-of-tree module
  # here — builds against both, and 7.1.8 plus its v4l2loopback come from the
  # binary cache rather than building locally.
  #
  # The tradeoff: this is a MOVING target. On a major bump an out-of-tree module
  # can lag and the rebuild fails until it catches up — for this machine that
  # means OBS's virtual camera, not booting. Pin linuxPackages_6_18 (or an
  # explicit series) if that is ever unwelcome.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ---------------------------------------------------------------------------
  # Graphics — RX 9070, amdgpu + Mesa RADV
  # ---------------------------------------------------------------------------
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
}
