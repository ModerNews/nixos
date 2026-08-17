{...}: {
  # Cluster/context definitions and OIDC `exec` users — no embedded credentials,
  # so this is plain, declarative, git-tracked. The `kubectl oidc-login` plugin
  # (kubelogin-oidc, see infra.nix) fetches a token per-invocation; nothing here
  # rotates or needs protecting.
  #
  # The break-glass mTLS admin users for tools/homelab/proxy are NOT here — those
  # are real long-lived secrets, sops-managed (see nixos/secrets.nix), decrypted
  # to ~/.kube/admin-*.yaml and merged in at runtime via KUBECONFIG below.
  home.file.".kube/config".text = ''
    apiVersion: v1
    kind: Config
    current-context: prod.k8s.internal.wmsdev.pl

    clusters:
      - name: prod.k8s.internal.wmsdev.pl
        cluster:
          server: https://10.1.1.10:6443
          certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJlakNDQVIrZ0F3SUJBZ0lCQURBS0JnZ3Foa2pPUFFRREFqQWtNU0l3SUFZRFZRUUREQmx5YTJVeUxYTmwKY25abGNpMWpZVUF4TnpnMU1qTTRPRFV4TUI0WERUSTJNRGN5T0RFd05EQTFNVm9YRFRNMk1EY3lOVEV3TkRBMQpNVm93SkRFaU1DQUdBMVVFQXd3WmNtdGxNaTF6WlhKMlpYSXRZMkZBTVRjNE5USXpPRGcxTVRCWk1CTUdCeXFHClNNNDlBZ0VHQ0NxR1NNNDlBd0VIQTBJQUJGYzZuOUNXZUpKdFJ3VGJVdG10K3piNElvVExaVVlDKyt5WEtiM2kKYnY3eWllbEthc0krbFNRbmFLMlA3SHJCQVZEWGwvV1pZRERIWFJ6aDJLNHFKQzZqUWpCQU1BNEdBMVVkRHdFQgovd1FFQXdJQ3BEQVBCZ05WSFJNQkFmOEVCVEFEQVFIL01CMEdBMVVkRGdRV0JCUlRFQmladUJIejBlVUluTkN0CkhDSHBNOWpnS2pBS0JnZ3Foa2pPUFFRREFnTkpBREJHQWlFQTVtb2N4eVVQYy9ISW4zVlh0S1k4RkNZQWxjU1gKTzcvUkJTcmF1a0N4M1Z3Q0lRRFBGOHV3emUxQUJwYWdnRThYaW4rWmVmdTI4TEhPR3pRNFlLeU1CMi9oa1E9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
      - name: proxy.k8s.internal.wmsdev.pl
        cluster:
          server: https://10.0.0.253:6443
          certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURBRENDQWVpZ0F3SUJBZ0lVS0xMc3R1QjE4L1BCTHJNa1lETitsVks0ZFBNd0RRWUpLb1pJaHZjTkFRRUwKQlFBd0dERVdNQlFHQTFVRUF4TU5hM1ZpWlhKdVpYUmxjeTFqWVRBZUZ3MHlOakEzTWpJeE9ERTVNREJhRncwegpOakEzTVRreE9ERTVNREJhTUJneEZqQVVCZ05WQkFNVERXdDFZbVZ5Ym1WMFpYTXRZMkV3Z2dFaU1BMEdDU3FHClNJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUUMxK2RyZVo2SEpkRkVzK1hITzJQN1VrK01ZTWtOc2xWdjcKdXliejdhdklEZERKRlorVWUyb2JSem1kY3JZVVF2S1A4VVNONW1tTVRPUUtLZXZQZ1N2eUR4V3AzcWJhaUE5cwpDQVU2UTBONXk0WFZXdzR3R0RjNlpMMFJIbGxSaDYvTktVSUN3NXhtRWJaWWxOU0ZseUJKZWFrL25KTGhFK29LCnNvcmlOeWJteDdRNmdFdjhVcHhKL0dmQ3ZjL1RPWHlKQmsxcFh1YUdMVlAzUVhFWDhTWXdKZVR4ck13RHdPc3IKRXRlV0RJcDVBV0syQzJHNU1LZVY5clhEUzREYWU0eDhTTDh2NTBibHBEbGEvNVdHem1lRC80enpJU25Lckh4dwpaZlZTL1kxYnVVUEZtRVh6YnZsVytKVE1URXRDelRCOVBFeWdkOUdNNjZNVVBHVTZYSitmQWdNQkFBR2pRakJBCk1BNEdBMVVkRHdFQi93UUVBd0lCQmpBUEJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJSZDVkUEMKYkordytXQnI0aDhWSFZoTWovSGRqVEFOQmdrcWhraUc5dzBCQVFzRkFBT0NBUUVBcWcrWmNJWTJvMUpDWWViaAo0TnllZElKNnNyb2JNZHZ1L0JuM3I0amhERUpNOGo4ZjJhWHNlOEl0YWdPNmZmMHA0dmtWTEQvSStjbFlMWUozCkhIb3JuTnBxWFU2TjQ5MUFoL1hUTXI5SHcwRXJRQnJ3NE51dERIWmtaYkVDYXdxK1J4blcyYnRJNVlDYjllMjQKcFoyVmdMd09OVFhSV1M0NHBUZkFlam9TWDIxeDVZSlB1OXNjQjA4VEg1UkozVDd6RUU0NUd2QUlYdWlENS9veQpKU1BOdUdoYmg2SExFZ1NBdVhZd056UGViMVZYRTNrbTArR3F6Q095OW9oVmQvRm55cmZZaTNPaUJEODZlaDNyClBtQ0RIQTVodk04M3BxUEFtby8rVVkvNmwvelQ0Y3RiVUkxTCtZS0JnMG9YcE8zQXN4Q3dBMGlzNXBNYzByZHAKWG9uazRBPT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
      - name: tools.k8s.internal.wmsdev.pl
        cluster:
          server: https://10.1.2.10:6443
          certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJlRENDQVIrZ0F3SUJBZ0lCQURBS0JnZ3Foa2pPUFFRREFqQWtNU0l3SUFZRFZRUUREQmx5YTJVeUxYTmwKY25abGNpMWpZVUF4TnpjMk5qTTJOelV3TUI0WERUSTJNRFF4T1RJeE1USXpNRm9YRFRNMk1EUXhOakl4TVRJegpNRm93SkRFaU1DQUdBMVVFQXd3WmNtdGxNaTF6WlhKMlpYSXRZMkZBTVRjM05qWXpOamMxTURCWk1CTUdCeXFHClNNNDlBZ0VHQ0NxR1NNNDlBd0VIQTBJQUJDODZJNDNWZkFrVDBOcE4vZURQRFVsdWsvLzVYZW9JSGM2cU44YXoKL0FXRm1ZLzZCYytWZEJtNkNxd2JYNEJNWDM3c2pwUVhKNk51dC9RUXEvQlJibDZqUWpCQU1BNEdBMVVkRHdFQgovd1FFQXdJQ3BEQVBCZ05WSFJNQkFmOEVCVEFEQVFIL01CMEdBMVVkRGdRV0JCUm02NDh0ODV6T3N6NVNZS1RnClZ6S0l5UHlwVmpBS0JnZ3Foa2pPUFFRREFnTkhBREJFQWlBTW14ZUphb3YzSEwxcEJZZmlNU2lwaHVuOTBvTk8KRWttSW5rTmRDK2RDMEFJZ2VWYU9ZZHFzRkhWMFMrQndMbHYxZS82SDRrc2dMK0RDSkxteUNUQWMvS3M9Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K

    contexts:
      - name: prod.k8s.internal.wmsdev.pl
        context:
          cluster: prod.k8s.internal.wmsdev.pl
          user: prod-oidc
      - name: "[device] prod.k8s.internal.wmsdev.pl"
        context:
          cluster: prod.k8s.internal.wmsdev.pl
          user: prod-oidc-device
      - name: proxy.k8s.internal.wmsdev.pl
        context:
          cluster: proxy.k8s.internal.wmsdev.pl
          user: proxy-oidc
      - name: "[device] proxy.k8s.internal.wmsdev.pl"
        context:
          cluster: proxy.k8s.internal.wmsdev.pl
          user: proxy-oidc-device

    users:
      - name: prod-oidc
        user:
          exec:
            apiVersion: client.authentication.k8s.io/v1beta1
            command: kubectl
            interactiveMode: IfAvailable
            provideClusterInfo: false
            args:
              - oidc-login
              - get-token
              - --oidc-issuer-url=https://sso.wmsdev.pl/realms/wmsdev
              - --oidc-client-id=api.prod.k8s.internal.wmsdev.pl
              - --oidc-extra-scope=groups
              - --oidc-extra-scope=offline_access
              - --listen-address=localhost:18000,localhost:18001,localhost:18002
      - name: prod-oidc-device
        user:
          exec:
            apiVersion: client.authentication.k8s.io/v1beta1
            command: kubectl
            interactiveMode: IfAvailable
            provideClusterInfo: false
            args:
              - oidc-login
              - get-token
              - --oidc-issuer-url=https://sso.wmsdev.pl/realms/wmsdev
              - --oidc-client-id=api.prod.k8s.internal.wmsdev.pl
              - --oidc-extra-scope=groups
              - --oidc-extra-scope=offline_access
              - --grant-type=device-code
      - name: proxy-oidc
        user:
          exec:
            apiVersion: client.authentication.k8s.io/v1beta1
            command: kubectl
            interactiveMode: IfAvailable
            provideClusterInfo: false
            args:
              - oidc-login
              - get-token
              - --oidc-issuer-url=https://sso.wmsdev.pl/realms/wmsdev
              - --oidc-client-id=api.proxy.k8s.internal.wmsdev.pl
              - --oidc-extra-scope=groups
              - --oidc-extra-scope=offline_access
              - --listen-address=localhost:18000,localhost:18001,localhost:18002
      - name: proxy-oidc-device
        user:
          exec:
            apiVersion: client.authentication.k8s.io/v1beta1
            command: kubectl
            interactiveMode: IfAvailable
            provideClusterInfo: false
            args:
              - oidc-login
              - get-token
              - --oidc-issuer-url=https://sso.wmsdev.pl/realms/wmsdev
              - --oidc-client-id=api.proxy.k8s.internal.wmsdev.pl
              - --oidc-extra-scope=groups
              - --oidc-extra-scope=offline_access
              - --grant-type=device-code
  '';

  # kubectl/kubie merge every file listed here. The three admin-*.yaml
  # fragments are sops secrets (nixos/secrets.nix) written directly to these
  # paths — each is a complete standalone kubeconfig (cluster+context+user)
  # for one cluster's break-glass mTLS admin, same shape as the files pulled
  # off the old machine's backup. Missing until that secret exists is fine:
  # kubectl just won't see that context.
  home.sessionVariables.KUBECONFIG = "$HOME/.kube/config:$HOME/.kube/admin-tools.yaml:$HOME/.kube/admin-homelab.yaml:$HOME/.kube/admin-proxy.yaml";
}
