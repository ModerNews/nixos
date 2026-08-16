{
  config,
  inputs,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age = {
      sshKeyPaths = ["/persist/etc/ssh/ssh_host_ed25519_key"];
      generateKey = false;
    };

    secrets = {
      "passwords/gruzin".neededForUsers = true;
      "passwords/root".neededForUsers = true;

      "wireguard/wmswg" = {
        owner = "root";
        group = "systemd-network";
        mode = "0640";
        restartUnits = ["systemd-networkd.service"];
      };
    };
  };

  # ---------------------------------------------------------------------------
  # BOOTSTRAP — read before the first install
  # ---------------------------------------------------------------------------
  # Chicken-and-egg: sops decrypts using the SSH host key, but on a fresh
  # machine sshd has not generated one yet. So generate it BY HAND during the
  # install, before nixos-install, and encrypt against it:
  #
  #   # 1. after mounting, create the host key where the config expects it
  #   install -d -m 0755 /mnt/persist/etc/ssh
  #   ssh-keygen -t ed25519 -N "" -f /mnt/persist/etc/ssh/ssh_host_ed25519_key
  #
  #   # 2. derive its age public key and put it in .sops.yaml
  #   nix run nixpkgs#ssh-to-age -- \
  #     -i /mnt/persist/etc/ssh/ssh_host_ed25519_key.pub
  #
  #   # 3. create the secrets file (on a machine that has your age key too)
  #   sops secrets/secrets.yaml
  #
  # Shape expected by the secrets above:
  #
  #   passwords:
  #     gruzin: $y$j9T$...        # mkpasswd -m yescrypt
  #     root:   $y$j9T$...
  #   wireguard:
  #     wmswg: <base64 private key>
  #
  # Until secrets/secrets.yaml is real, activation fails loudly — which is the
  # correct failure. The alternative (falling back to plaintext paths) would
  # boot fine and silently have no secrets.
  #
  # Add your OWN age key as a second recipient in .sops.yaml, or only this one
  # machine can ever decrypt the file — and if its /persist is lost, so is the
  # ability to read your own secrets.
}
