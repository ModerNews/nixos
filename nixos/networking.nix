{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.wireguard-tools];

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
    networks."10-lan" = {
      matchConfig.Name = "eno1";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
        DNSDefaultRoute = true;
      };
      dhcpV4Config.UseDNS = true;
      linkConfig.RequiredForOnline = "routable";
    };
    wait-online.enable = false;
  };

  # Manually activated (systemctl start wmswg)
  networking.wireguardNetdevs.wmswg = {
    privateKeyFile = config.sops.secrets."wireguard/wmswg".path;
    address = ["10.10.0.4/32"];
    dns = ["10.10.0.1"];
    domains = ["~wmsdev.pl" "~wmsdev.local"];
    routes = [
      {Destination = "192.168.88.0/24";}
      {Destination = "10.0.0.0/8";}
    ];
    peers = [
      {
        publicKey = "XzeoUsUBjuVDiKWoRO1mA8pUVMZfeHocU68RHjT7vEo=";
        endpoint = "156.17.229.201:51820";
        allowedIPs = ["192.168.88.0/24" "10.0.0.0/8"];
        persistentKeepalive = 25;
      }
    ];
  };
}
