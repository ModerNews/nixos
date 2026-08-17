{pkgs, ...}: {
  # There is no programs.kubectl, reasonably — kubectl has no user config worth
  # generating, and ~/.kube/config is credentials rather than configuration.
  #
  # kubecolor is here because it wires something a package cannot: the alias
  # that shadows `kubectl`. NOT k9s or kubeswitch — a module existing is not a
  # reason to install a tool, and kubie already covers context switching.
  programs.kubecolor = {
    enable = true;
    enableAlias = true; # `kubectl` -> kubecolor
  };

  home.packages = with pkgs; [
    kubectl
    kubie
    kubernetes-helm
    minikube
    kompose
    argocd
    cilium-cli
    terraform
    ansible
    vault
    ngrok
    dyff
    gomplate
  ];
}
