# AGENTS.md

Instructions for AI agents (Claude Code and similar) working in this repo.
`README.md` is a short "what is this" pointer; `INSTALL.md` has the
from-scratch install runbook. This file has the "how to behave while
editing it," plus the gotchas and known-incomplete areas that used to live
in README.

## What this repo is

The single source of truth for `gruzin-desktop`: a NixOS system plus its
Home Manager user environment, applied together by one
`nixos-rebuild switch --flake .#gruzin-desktop`. There is exactly one host.
If you are asked to change how a service, package, dotfile, or desktop
component behaves on this machine, the change belongs here, in Nix — not as
a hand-edited file under `/etc`, not as an imperative `nix-env -i`, and not
as a manually-installed dotfile in `$HOME`. Anything not expressed in this
repo will not survive the next `nixos-rebuild switch` (root is tmpfs) and
will not be reviewable in git history.

## Before editing: find the right file

- `nixos/configuration.nix` — thin entrypoint only: the `imports` list,
  `nixpkgs`/overlay wiring, `nix.settings`, `system.stateVersion`. Domain
  config does not belong here — add a new domain file and import it instead
  of growing this one back to 380 lines.
- `nixos/boot.nix` — bootloader, initrd, `boot.tmp`, `fileSystems`, swap.
- `nixos/persistence.nix` — impermanence (`environment.persistence.*`),
  `systemd.tmpfiles.rules`.
- `nixos/networking.nix` — `networking.*`, `systemd.network.*`, resolved,
  tailscale, and the `wmswg` instantiation of the wireguard-netdev module.
- `nixos/users.nix` — user accounts, ssh, sudo, the (non-wireguard) polkit
  rule, smartcard/yubikey services.
- `nixos/virtualisation.nix` — containers/podman.
- `nixos/display.nix` — gdm, gnome-keyring, xdg-portal.
- `nixos/desktop-hardware.nix`, `nixos/programs.nix` (+`kmonad/`),
  `nixos/fonts.nix`, `nixos/flatpak.nix` — unchanged single-purpose files.
- `nixos/secrets.nix` — sops wiring. See Secrets below.
- `home-manager/*.nix` — user-level config (shell, terminal, apps, theming,
  hyprland). `home.nix` is the entrypoint.
- `modules/nixos/` and `modules/home-manager/` — for genuinely reusable
  modules (the kind you'd upstream or share), not personal config.
  `modules/nixos/wireguard-netdev.nix` is the live example: it turns a
  systemd-networkd WireGuard link (netdev + network + manual-activation
  oneshot service + polkit rule) into one `networking.wireguardNetdevs.<name>`
  block, instantiated once for `wmswg` in `nixos/networking.nix`. Follow that
  shape — options + a single `config = mkIf (cfg != {})` block — if another
  chunk of `nixos/*.nix` turns out to need two copies of the same pattern.
- `overlays/default.nix` — package overrides/patches and the
  `unstable-packages` overlay (exceptions that need `pkgs.unstablePkgs.*`).
- `pkgs/default.nix` — custom package derivations, built via `nix build .#name`.
- `secrets/secrets.yaml` — sops-encrypted. See Secrets below.

When a change spans both a service and its user-facing config (e.g. a new
app needing a systemd unit and a dotfile), expect to touch both `nixos/`
and `home-manager/`.

## Verifying a change

This is someone's real, currently-installed desktop. Never run
`nixos-rebuild switch` (or `boot`/`test`) yourself — that mutates the live
system. Verification here is meant to be possible without touching the
machine at all:

```bash
nix flake check --no-build
nix eval .#nixosConfigurations.gruzin-desktop.config.system.build.toplevel.drvPath
nix build --dry-run .#nixosConfigurations.gruzin-desktop.config.system.build.toplevel
```

Flakes only evaluate git-tracked content. A new file that hasn't at least
been `git add`-ed yet is invisible to every command above and to `nix fmt`
— it'll look like the file doesn't exist rather than error clearly. Stage
new files before trusting a "no errors" result.

Format with the flake's formatter before considering a change done:

```bash
nix fmt -- .
```

(`nix fmt` with no path reads stdin instead of formatting the tree — always
pass `.` explicitly.)

If a change genuinely needs to be applied to the live system (not just
evaluated), say so explicitly and let the user run
`nixos-rebuild switch --flake .#gruzin-desktop` themselves.

## Secrets

`secrets/secrets.yaml` is sops-encrypted, keyed to `user_gruzin` and
`host_gruzin_desktop` in `.sops.yaml`. Rules:

- Never write plaintext secret values into any tracked file, commit
  message, or shell history-visible command.
- Edit secrets only via `sops secrets/secrets.yaml` (opens decrypted in
  `$EDITOR`, re-encrypts on save). Don't decrypt to a scratch file.
- `nixos/secrets.nix` declares which keys exist and how they're delivered
  (owner/group/mode/path) — that file is fine to read and edit normally,
  it holds no secret material itself.
- Respect `.gitignore`'s `*.dec*`/`secrets/*.plain*` patterns — those exist
  because decrypted material has landed on disk before.
- Adding a new secret means: add it under `sops.secrets` in
  `nixos/secrets.nix` *and* add the value via `sops secrets/secrets.yaml`.
  One without the other is a silent no-op or an eval failure.
- `.pre-commit-config.yaml` enforces the sops-encrypted check (pre-commit
  stage) plus `nix fmt` (pre-commit stage) and `nix flake check` (pre-push
  stage). `nix develop` (or direnv via `.envrc`, which already does `use
  flake`) installs both hook types automatically via the `devShells.default`
  shellHook — that's the intended path, not running `pre-commit install`
  by hand.

## Gotchas encoded here

NixOS/HM footguns already hit once on this exact config. Check here before
assuming an option name or module shape — re-discovering one of these costs
real time.

- **`security.run0.enable` does not exist.** run0 ships with systemd; the
  load-bearing line is `security.polkit.enable`, which gates the
  `systemd-run0` PAM service. `wheelNeedsPassword = false` emits a blanket
  `manage-units` YES rule for wheel — do not set it.
- **`services.resolved` options were renamed** in 26.05 to
  `services.resolved.settings.Resolve.*`.
- **`programs.ssh.matchBlocks` is deprecated** — use `programs.ssh.settings`.
- **HM has no `programs.zsh.fastSyntaxHighlighting`.** fast-syntax-highlighting
  comes in via `programs.zsh.plugins`; the palette must load after it.
- **disko generates `fileSystems` without `neededForBoot`.** Not used here, but
  the trap is real if it is ever adopted.
- **`initialPassword` becomes `password` under `mutableUsers = false`** and
  leaks plaintext into the world-readable store.
- **`qt.platformTheme.name = "qtct"` maps to `QT_QPA_PLATFORMTHEME=qt5ct`.**
  Use the literal `"qt6ct"` to match the Hyprland env block.
- **kmonad's module generates `defcfg`/`input`/`output` itself** — the `.kbd`
  here holds only `defsrc`/`defalias`/`deflayer`.
- **Under a Lua Hyprland config, `hyprctl dispatch dpms off` is a syntax
  error.** The working form is `hyprctl dispatch 'hl.dsp.dpms("off")'`.
- **Flakes only see git-tracked files** — see the note in Verifying a change
  above; this bit both `nix flake check` and `nix fmt` while building the
  `nixos/*.nix` domain split.
- **`security.polkit.extraConfig` is `types.lines`**, not a plain string —
  multiple modules can each set it and the rule blocks concatenate, which is
  what lets `wireguard-netdev.nix` add its own polkit rule alongside the one
  in `nixos/users.nix` without conflicting.

## Known-incomplete

Areas that are reconstructed or stubbed rather than faithfully ported.
Treat these as lower-confidence; say so if a change touches one.

| Item | State |
|---|---|
| swaync `settings`/`style` | **reconstructed** from the audit, not ported |
| Flatpak `overrides.global` | **reconstructed** from a one-line description |
| `~/.ssh/config` | `linode`/`proxy` are FIXME stubs |
| `mimeapps.list` | not carried — "open with" will be unset |
| LibreWolf prefs/extensions | extracted from the **Firefox** profile, not LibreWolf's |
| Vault (T7 layer 2) | deferred by choice; sops covers the boot-critical set |
| CoreCtrl | needs `amdgpu.ppfeaturemask` + a polkit rule if kept |
| colourscheme | palette recovered in `terminal.nix`; matugen pipeline not rebuilt |

## Scope discipline

This is a personal, single-host config with a specific partition layout,
impermanence setup, and secrets pipeline already decided. Don't introduce
new patterns (a different secrets tool, a CI pipeline, a disko-managed
layout) unless asked — disko is a known but unused trap, noted above. The
one devShell that exists (`flake.nix`) exists solely to install the
pre-commit hooks; it's not a general-purpose dev environment, so don't grow
it into one without being asked. Prefer the smallest change that fits the
existing `nixos/` / `home-manager/` split, and prefer a new
`nixos/<domain>.nix` file over growing an existing one past a couple
hundred lines.
