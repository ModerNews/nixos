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
