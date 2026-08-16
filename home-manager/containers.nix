{...}: {
  home.sessionVariables.DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";

  # Container storage off /home
  xdg.configFile."containers/storage.conf".text = ''
    [storage]
    driver    = "overlay"
    graphroot = "/state/containers/gruzin"
  '';
}
