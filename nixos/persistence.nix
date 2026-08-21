{...}: {
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
    "d /home/gruzin/.kube 0700 gruzin users -"
    "d /home/gruzin/.ssh 0700 gruzin users -"

    "d /state/containers 0755 root root -"
    "d /state/containers/gruzin 0700 gruzin users -"

    "D! /state/ephemeral 0755 root root -"
  ];

  systemd.services.nix-daemon.environment.TMPDIR = "/state/ephemeral/nix-build";
}
