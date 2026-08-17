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

      notification-icon-size = 16;
      notification-body-image-height = 100;
      notification-body-image-width = 200;

      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;

      fit-to-screen = true;
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
      :root {
        --cc-bg: rgba(26, 8, 8, 0.75);
        --noti-border-color: rgba(173, 42, 48, 0.6);
        --noti-bg: 26, 8, 8;
        --noti-bg-alpha: 0.75;
        --noti-bg-darker: rgb(18, 4, 4);
        --noti-bg-hover: rgb(42, 20, 24);
        --noti-bg-focus: rgba(42, 20, 24, 0.7);
        --noti-close-bg: rgba(173, 42, 48, 0.5);
        --noti-close-bg-hover: rgba(173, 42, 48, 0.85);
        --text-color: rgb(254, 254, 254);
        --text-color-disabled: rgb(102, 102, 102);
        --bg-selected: rgb(173, 42, 48);
        --border: 2px solid rgba(173, 42, 48, 0.75);
        --border-radius: 10px;
      }

      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
      }

      .control-center {
        border: var(--border);
      }

      .widget {
        margin: 4px;
        padding: 4px;
      }

      .notification-content image {
        margin-right: 12px;
      }
    '';
  };
}
