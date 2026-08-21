{...}: {
  # Private key halves are sops secrets (nixos/secrets.nix), decrypted
  # straight to the paths referenced below as IdentityFile. Public halves
  # aren't secret, so they're plain home.file entries here.
  #
  # NOTE: the audit specified `programs.ssh.matchBlocks`, which is DEPRECATED
  # in Home Manager 26.05 — it warns and tells you to use
  # `programs.ssh.settings`. The new form is a DAG keyed by the literal Host
  # (or Match) block name, with plain ssh_config directive names (CamelCase)
  # rather than the old lowercase Home Manager option names.
  programs.ssh = {
    enable = true;

    # The old implicit defaults are being removed upstream. Pinning them here
    # explicitly keeps behaviour identical instead of inheriting whatever the
    # default becomes later.
    enableDefaultConfig = false;

    settings = {
      "*" = {
        ForwardAgent = false;
        AddKeysToAgent = "no";
        Compression = false;
        ServerAliveInterval = 0;
        ServerAliveCountMax = 3;
        HashKnownHosts = false;
        UserKnownHostsFile = "~/.ssh/known_hosts";
        ControlMaster = "no";
        ControlPath = "~/.ssh/master-%r@%n:%p";
        ControlPersist = "no";
        # id_rsa is legacy, kept only as a fallback behind the real identity.
        IdentityFile = ["~/.ssh/id_ed25519" "~/.ssh/id_rsa"];
      };

      "github.com" = {
        User = "git";
        IdentityFile = "~/.ssh/id_github";
        IdentitiesOnly = true;
      };

      # The bastion itself: reachable by alias or by its raw address, direct
      # (no ProxyJump — jumping through itself would loop).
      "bastion 10.1.0.20" = {
        HostName = "10.1.0.20";
        User = "wms";
        IdentityFile = "~/.ssh/id_bastion";
        IdentitiesOnly = true;
      };

      # Everything else on the internal 10.0.0.0/8 net, reached via the
      # bastion above. 10.0.0.0/24 is the local LAN (direct, no jump needed)
      # and 10.1.0.20 is the bastion itself (handled above) — both excluded.
      "Match address 10.0.0.0/8,!10.0.0.0/24,!10.1.0.20" = {
        User = "wms";
        IdentityFile = "~/.ssh/id_bastion";
        IdentitiesOnly = true;
        ProxyJump = "bastion";
      };

      # cloud-init VMs rotate their host key on every re-provision, so their
      # entries live in a known_hosts file under /tmp (tmpfs, cleared every
      # boot) instead of the persistent one — otherwise a rotation trips
      # "REMOTE HOST IDENTIFICATION HAS CHANGED" against a stale entry.
      "*.vms.internal.wmsdev.pl" = {
        UserKnownHostsFile = "/tmp/known_hosts-vms-internal";
        StrictHostKeyChecking = "accept-new";
      };
    };
  };

  home.file.".ssh/id_ed25519.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILDJOJrTfgMTNooVM+xBQx73QA2ZnYgGr5er5DZRTwgm grzegorz.jagielski@wmsdev.pl\n";
  home.file.".ssh/id_github.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAdkkNT3BqBNpw+3IP4eJFVyZX4zIXLkK0vHvqs6pCxn gruzin@gruzin-desktop\n";
  home.file.".ssh/id_rsa.pub".text = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5a1khrjyaBCfJcis4vstp4wblZ/b9/u54RqXZO+pdFrew5K4+OhFbtNs8gRpzDEyzIR7hGQl1Lgb3cstpZFGn7xOvlTZFARxWQ3qon65Cgok0gsdlavUzxcg38to1AdDeeuz3RonCGd5ircn6uYCT2mfE/HUBSLziKORex/Zle1G5DK5s8Eg4YLUZmRyIIlzkfcFECTr6/+DRQmwVO8qqV6ajIrBgGtjPyaqdbZcJ/XDKYtn7UNsMVLBww/VtYDcOU4SMT9d1TBvGaYtqICQFWVoAl+ms9wHzYK8T70M5/6HqKe4St+QqYHVFiMb+UEIqNzvXLw7NSgaGM6XbWAVe8kdV62mkUZ01uJ9XhR23bfVNox4AvSlgiasQq6BB+hDQkLYO4ZAkOXx3t+THy9Enk4Vb2lyk6vj5F5D5esCs16SE28esj/yMhMx1g2NyQg6eomDPIJ+UqIZFxEbBTEtKNSQilAidSxd8Y8NttPhxSaAlyYEjsyOy+TpqNTjsCHv8iggYe4eAdhOTJ+Fj2EhVIq9xI02NZxcl77Tlt7tjszyi5meC247whk/qtjrayJKbnFmrMfW1h45h3UZT6Uc/sU+fH5fOxSeoB5gbugvLoteVgvBRARWsZd3otAWivsUNERC6imAnm+On6jk1JXoi3yZCepYld/QL8MWE7nfldQ== grzegorz.jagielski@wmsdev.pl\n";
}
