# gruzin-desktop

NixOS + Home Manager for `gruzin-desktop`. Built from the pre-wipe migration
audit (T1–T11); this repo is the T-items turned into config.

- nixpkgs **26.05** stable, with an `unstable-packages` overlay for exceptions
- Home Manager as a **NixOS module** — one `nixos-rebuild switch` applies both
- **tmpfs root** with opt-in persistence (impermanence)
- secrets via **sops-nix**, keyed off the machine's SSH host key

```
nixos/           system config     home-manager/     user config
  configuration.nix                  home.nix          hyprland.nix + hypr/
  hardware-configuration.nix         desktop.nix       zsh.nix + zsh/
  desktop-hardware.nix               nvim.nix + nvim/  terminal.nix
  programs.nix + kmonad/             eww/              browser.nix
  fonts.nix flatpak.nix              packages.nix      theming.nix
  secrets.nix                        dev.nix           swaync.nix
secrets/         sops-encrypted     .sops.yaml         recipients
```

## Install runbook

Step 0 happens anywhere. Steps 1–6 happen on the target machine, in order.
Steps 0, 2 and 5 are the ones that fail *silently* if skipped.

### 0. Secrets — before you touch the machine

Nothing here needs the target, and doing it first means the install is not
blocked waiting on it.

```bash
# your age key — you are the first recipient
age-keygen -o ~/.config/sops/age/keys.txt      # prints "Public key: age1..."
```

Paste that into `.sops.yaml` as `user_gruzin`. **Back up
`~/.config/sops/age/keys.txt`** — until step 2 you are the *only* recipient, so
losing it makes the secrets unreadable by anyone, including the machine.

```bash
mkpasswd -m yescrypt        # once per account; let it prompt, do not echo
sops secrets/secrets.yaml
```

```yaml
passwords:
  gruzin: "$y$j9T$..."      # quote these
  root:   "$y$j9T$..."
wireguard:
  wmswg: "<base64 private key from /etc/wireguard/wmswg.conf>"
```

Then commit. `pre-commit install` first — the hook refuses a `secrets/*.yaml`
that is not sops-encrypted, which is the one mistake that would matter.

### 1. Partition — must match `nixos/configuration.nix` exactly

Nothing verifies this; a mismatch surfaces as an emergency shell at boot.

```
nvme0n1  p1  2G    vfat   label BOOT
         p2  rest  LVM PV -> vg_evo
                     lv_nix    200G  xfs
                     lv_state  150G  xfs
                     lv_home   150G  btrfs  subvols @home @cache @persist
sda      p1  all   xfs    label DATA
```

`/` is a tmpfs — there is no root LV. Leave the rest of `vg_evo` unallocated.
XFS must have `ftype=1` (the mkfs default) for podman's overlay store.

**Confirm `nvme1n1` (477 GB, Windows) is untouched.**

### 2. Host key — before `nixos-install`

sops decrypts with the machine's SSH host key, and sshd has not generated one
yet. Create it by hand, then add it as a second recipient.

```bash
install -d -m 0755 /mnt/persist/etc/ssh
ssh-keygen -t ed25519 -N "" -f /mnt/persist/etc/ssh/ssh_host_ed25519_key
nix run nixpkgs#ssh-to-age -- -i /mnt/persist/etc/ssh/ssh_host_ed25519_key.pub
```

Uncomment `host_gruzin_desktop` in `.sops.yaml`, paste the key, then re-key the
existing file — this does not require retyping the secrets:

```bash
sops updatekeys secrets/secrets.yaml
```

Skip this and the install completes, then GDM accepts no password.

### 3. Regenerate hardware config

`nixos/hardware-configuration.nix` is currently **hand-written and inferred**.

```bash
nixos-generate-config --root /mnt --no-filesystems
```

`--no-filesystems` is deliberate: mounts are a design decision and live in
`configuration.nix`. Diff the initrd module list against what is committed.

### 4. Install

```bash
nixos-install --flake /mnt/etc/nixos#gruzin-desktop --no-root-passwd
```

`--no-root-passwd` because root's hash comes from sops. Expect roughly
**8.3 GB of downloads and ~500 local builds**.

### 5. Verify BEFORE rebooting out of the installer

The one check worth making while recovery is still cheap:

```bash
nixos-enter --root /mnt -- ls -l /run/secrets-for-users/passwords/
```

Empty means sops did not decrypt, and you would reach a login screen that
accepts nothing. Fix it here rather than from the ISO afterwards.

Also place the things sops does not manage:

```bash
# HA token for the FiiO script (T10)
install -d -m 0700 /mnt/home/gruzin/.local/share/fiio
# ...write ha-token, 0600, owned by gruzin
```

### 6. After first boot

- `resolvectl status` — three DNS scopes, `wmsdev.pl` routed whole
- `networkctl status` — `wmswg` down until `systemctl start wmswg`
- `systemctl --user status eww-bars soteria hypridle hyprpaper swaync vicinae`
- verify GE appears under Steam → Compatibility (nixpkgs#365497)
- plug in the FiiO and confirm `kmonad-fiio` starts off its `.path` unit
- rotate the HA token — the audit notes it was plaintext for months

## Gotchas encoded here

Things that cost time to find, recorded so they are not re-found:

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

## Known-incomplete

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

## Verifying without a NixOS machine

Evaluation is pure — hardware does not have to match, and device paths are just
strings until install time.

```bash
nix eval .#nixosConfigurations.gruzin-desktop.config.system.build.toplevel.drvPath
nix flake check --no-build
nix build --dry-run .#nixosConfigurations.gruzin-desktop.config.system.build.toplevel
```
