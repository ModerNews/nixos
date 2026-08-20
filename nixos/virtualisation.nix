{pkgs, ...}: {
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
}
