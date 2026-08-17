{pkgs, ...}: {
  programs.kubecolor = {
    enable = true;
    enableAlias = true; # `kubectl` -> kubecolor
  };

  home.packages = with pkgs; [
    kubectl
    kubie
    kubernetes-helm
    k0sctl

    kubelogin-oidc

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
