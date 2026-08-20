# gruzin-desktop

NixOS + Home Manager for `gruzin-desktop` — a single-host flake where one
`nixos-rebuild switch` applies system and user config together. Structure
started from [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
and grew from there.

- nixpkgs **26.05** stable, with an `unstable-packages` overlay for exceptions
- Home Manager as a **NixOS module** — one `nixos-rebuild switch` applies both
- **tmpfs root** with opt-in persistence (impermanence)
- secrets via **sops-nix**, keyed off the machine's SSH host key

```
nixos/            system config, split by domain (boot, networking, users, ...)
home-manager/     user config (shell, terminal, hyprland, theming, ...)
modules/          reusable nixos/home-manager modules (e.g. wireguard-netdev)
overlays/         package overrides + the unstable-packages overlay
pkgs/             custom package derivations
secrets/          sops-encrypted secrets.yaml
.sops.yaml        sops recipients
```

- `AGENTS.md` — the full per-file map, conventions, known footguns, and how
  to verify a change without touching the live machine.
- `INSTALL.md` — the from-scratch install runbook (partitioning, secrets
  bootstrap, first boot).
