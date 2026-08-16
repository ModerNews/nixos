{...}: {
  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "application";

      control-center-width = 420;
      control-center-height = 560;

      notification-icon-size = 16;
      notification-body-image-height = 100;
      notification-body-image-width = 200;

      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;

      fit-to-screen = false;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;

      widgets = ["title" "notifications"];

      widget-config.title = {
        text = "Notifications";
        clear-all-button = true;
        button-text = "Clear";
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
      }

      .notification-content image {
        margin-right: 12px;
      }
    '';
  };
}
