{pkgs, ...}: let
  amo = slug: "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
  forceInstall = slug: {
    install_url = amo slug;
    installation_mode = "force_installed";
  };
in {
  programs.librewolf = {
    enable = true;

    profiles.gruzin = {
      id = 0;
      isDefault = true;

      settings = {
        "browser.startup.page" = 3; # restore previous session
        "browser.compactmode.show" = true;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.search.region" = "PL";
        "browser.contentblocking.category" = "standard";

        "signon.rememberSignons" = false;

        "privacy.clearOnShutdown_v2.formdata" = true;
        "network.dns.disablePrefetch" = true;

        # DRM (Widevine) and VAAPI, on an RX 9070 with Mesa.
        "media.eme.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.hardware-video-encoding.force-enabled" = true;

        "layout.css.prefers-color-scheme.content-override" = 0;

        # --- Wayland / portal integration, matching the Hyprland env block ---
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "librewolf.resistFingerprinting.block_mozAddonManager" = true;
      };
    };

    # Ported from old config
    policies.ExtensionSettings = {
      "uBlock0@raymondhill.net" = forceInstall "ublock-origin";
      "{446900e4-71c2-419f-a6a7-df9c091e268b}" = forceInstall "bitwarden-password-manager";
      "addon@darkreader.org" = forceInstall "darkreader";
      "sponsorBlocker@ajay.app" = forceInstall "sponsorblock";
      "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = forceInstall "return-youtube-dislikes";
      "enhancerforyoutube@maximerf.addons.mozilla.org" = forceInstall "enhancer-for-youtube";
      "simple-translate@sienori" = forceInstall "simple-translate";
      "{d07ccf11-c0cd-4938-a265-2a4d6ad01189}" = forceInstall "view-page-archive";
      "{1018e4d6-728f-4b20-ad56-37578a4de76b}" = forceInstall "flagfox";
      "{84cbda23-345f-4e74-9695-9a52b9599dc0}" = forceInstall "dotgit";
      "{3579f63b-d8ee-424f-bbb6-6d0ce3285e6a}" = forceInstall "chameleon-ext";
      "@contain-facebook" = forceInstall "facebook-container";
    };
  };

  home.packages = [pkgs.chromium];
}
