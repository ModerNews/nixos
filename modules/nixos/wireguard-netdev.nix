# A systemd-networkd WireGuard link that defaults to manual activation
# (`networkctl up <name>` via a oneshot service) rather than coming up at
# boot, plus the polkit rule that lets wheel start/stop/restart it without
# a password prompt.
{
  config,
  lib,
  ...
}: let
  cfg = config.networking.wireguardNetdevs;

  peerSubmodule = lib.types.submodule {
    options = {
      publicKey = lib.mkOption {
        type = lib.types.str;
        description = "Peer's WireGuard public key.";
      };
      endpoint = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Peer endpoint, e.g. \"host:51820\".";
      };
      allowedIPs = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      persistentKeepalive = lib.mkOption {
        type = lib.types.nullOr lib.types.ints.positive;
        default = null;
      };
    };
  };

  linkSubmodule = lib.types.submodule {
    options = {
      privateKeyFile = lib.mkOption {
        type = lib.types.path;
        description = "Path to the WireGuard private key (e.g. a sops secret path).";
      };
      address = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      dns = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      domains = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      routes = lib.mkOption {
        type = lib.types.listOf lib.types.attrs;
        default = [];
        description = "Extra systemd-networkd [Route] sections, e.g. [{Destination = \"10.0.0.0/8\";}].";
      };
      dnsDefaultRoute = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      autoStart = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Bring the interface up at boot instead of leaving it manual.";
      };
      allowWheelControl = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Let wheel start/stop/restart the interface's unit via polkit, no password.";
      };
      peers = lib.mkOption {
        type = lib.types.listOf peerSubmodule;
        default = [];
      };
    };
  };
in {
  options.networking.wireguardNetdevs = lib.mkOption {
    type = lib.types.attrsOf linkSubmodule;
    default = {};
    description = "Manually-activated systemd-networkd WireGuard interfaces.";
  };

  config = lib.mkIf (cfg != {}) {
    systemd.network.netdevs = lib.mapAttrs' (name: link:
      lib.nameValuePair "50-${name}" {
        netdevConfig = {
          Kind = "wireguard";
          Name = name;
        };
        wireguardConfig.PrivateKeyFile = link.privateKeyFile;
        wireguardPeers = map (peer:
          lib.filterAttrs (_: v: v != null) {
            PublicKey = peer.publicKey;
            Endpoint = peer.endpoint;
            AllowedIPs = peer.allowedIPs;
            PersistentKeepalive = peer.persistentKeepalive;
          })
        link.peers;
      })
    cfg;

    systemd.network.networks = lib.mapAttrs' (name: link:
      lib.nameValuePair "50-${name}" {
        matchConfig.Name = name;
        address = link.address;
        dns = link.dns;
        domains = link.domains;
        routes = link.routes;
        networkConfig.DNSDefaultRoute = link.dnsDefaultRoute;
        linkConfig.ActivationPolicy =
          if link.autoStart
          then "up"
          else "manual";
      })
    cfg;

    systemd.services = lib.mapAttrs' (name: link:
      lib.nameValuePair name {
        enable = true;
        after = ["systemd-networkd.service"];
        wantedBy = lib.optional link.autoStart "multi-user.target";
        description = "${name} WireGuard interface";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${config.systemd.package}/bin/networkctl up ${name}";
          ExecStop = "${config.systemd.package}/bin/networkctl down ${name}";
          RemainAfterExit = true;
        };
      })
    cfg;

    security.polkit.extraConfig = lib.concatStringsSep "\n" (
      lib.mapAttrsToList (name: _: ''
        polkit.addRule(function(action, subject) {
          if (action.id == "org.freedesktop.systemd1.manage-units" &&
              action.lookup("unit") == "${name}.service" &&
              subject.isInGroup("wheel") &&
              subject.active) {
            var verb = action.lookup("verb");
            if (verb == "start" || verb == "stop" || verb == "restart") {
              return polkit.Result.YES;
            }
          }
        });
      '')
      (lib.filterAttrs (_: link: link.allowWheelControl) cfg)
    );
  };
}
