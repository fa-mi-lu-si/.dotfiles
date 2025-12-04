{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    xwayland-satellite
  ];
  programs.niri.settings = {
    environment = {
      SDL_VIDEODRIVER = "wayland";
    };
    hotkey-overlay.skip-at-startup = true;
    input.touchpad.accel-speed = 0.4;
    input.power-key-handling.enable = false;

    prefer-no-csd = true;
    overview = {
      zoom = 0.5;
      backdrop-color = config.lib.stylix.colors.withHashtag.base00;
      workspace-shadow.enable = false;
    };
    layer-rules = [
      {
        matches = [{namespace = "swww-daemon";}];
        place-within-backdrop = true;
      }
    ];
    window-rules = [
      # Rounded Corners
      {
        geometry-corner-radius = let
          r = 4.0;
        in {
          top-left = r;
          top-right = r;
          bottom-left = r;
          bottom-right = r;
        };
        clip-to-geometry = true;
        draw-border-with-background = false;
      }

      {
        matches = [{title = "^Picture-in-Picture$";}];
        # add the default window dimensions
        open-floating = true;
        open-focused = false;
        default-column-width = {proportion = 0.15;};
        default-floating-position = {
          relative-to = "bottom-left";
          x = 10;
          y = 10;
        };
      }

      {
        matches = [
          {app-id = "^com.mitchellh.ghostty$";}
          {app-id = "^org.wezfurlong.wezterm$";}
          {app-id = "^org.gnome.Nautilus$";}
        ];
        default-column-width.proportion = 0.5;
      }
      {
        matches = [
          {app-id = "^io.bassi.Amberol$";}
        ];
        default-column-width.proportion = 1.0 / 3.0;
      }
    ];

    layout = {
      border.width = 2;
      gaps = 8;
      always-center-single-column = true;
      empty-workspace-above-first = true;
      preset-column-widths = [
        {proportion = 1.0 / 3.0;}
        {proportion = 1.0 / 2.0;}
        {proportion = 2.0 / 3.0;}
      ];
      shadow.enable = false;
      background-color = "transparent";
      struts = {
        left = 8;
        right = 8;
      };
      tab-indicator = {
        place-within-column = true;
        position = "left";
        corner-radius = 4.0;
        gap = 4;
        gaps-between-tabs = 4;
        width = 4.0;
        length.total-proportion = 1.0;
      };
    };

    spawn-at-startup = [
      {
        command = ["eww" "daemon"];
      }
      {
        command = ["~/.config/eww/scripts/niri-watcher.nu" "${config.xdg.configHome}/eww"];
      }
    ];

    binds = with config.lib.niri.actions; let
      sh = spawn "sh" "-c";
      nu = spawn "nu" "-c";
    in {
      "Mod+T".action = spawn "ghostty";
      "Mod+Shift+T".action = spawn "wezterm";
      "Mod+F".action = spawn "nautilus";
      "Mod+B".action = spawn "librewolf";
      "Mod+O".action = sh "ghostty --working-directory='${config.home.homeDirectory}/Vault' -e hx .";
      "Mod+Shift+O".action = spawn "obsidian";
      "Mod+V".action = sh "vicinae deeplink vicinae://extensions/vicinae/clipboard/history";
      "Mod+Space".action = sh "vicinae toggle";
      "Mod+slash".action = sh "vicinae deeplink vicinae://extensions/vicinae/file/search";

      "Mod+Q".action = close-window;
      "Mod+E".action = center-column;
      "Mod+Shift+E".action = center-visible-columns;
      "Mod+L".action = spawn "swaylock";
      "Mod+A".action = toggle-column-tabbed-display;
      "Mod+F9".action = toggle-overview;
      "Mod+Shift+F9".action = sh "eww close sidebar"; # get rid of a misbehaving sidebar
      "Mod+Shift+Q".action = quit;
      "Mod+Shift+Home".action = consume-or-expel-window-left;
      "Mod+Shift+End".action = consume-or-expel-window-right;
      "Mod+U".action = fullscreen-window;
      "Mod+G".action = toggle-window-floating;
      "Mod+Shift+G".action =
        nu
        # nu
        ''
          niri msg -j windows | from json
          | where workspace_id == (niri msg -j workspaces | from json | where is_focused == true | first | get id)
          | each {niri msg action toggle-window-floating --id $in.id}
        '';
      "Mod+Tab".action = switch-focus-between-floating-and-tiling;
      "Mod+R".action = switch-preset-column-width;
      "Mod+M".action = maximize-column;
      "Mod+Shift+M".action = set-window-height "100%";
      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";

      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Down".action = focus-window-or-workspace-down;
      "Mod+Up".action = focus-window-or-workspace-up;
      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
      "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;

      "Print".action.screenshot = [];
      "XF86AudioRaiseVolume" = {
        action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+";
        allow-when-locked = true;
      };
      "XF86AudioLowerVolume" = {
        action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
        allow-when-locked = true;
      };
      "XF86AudioMute" = {
        action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        allow-when-locked = true;
      };
      "XF86MonBrightnessUp" = {
        action = sh "brightnessctl s +1%";
        allow-when-locked = true;
      };
      "XF86MonBrightnessDown" = {
        action = sh "brightnessctl s 1%-";
        allow-when-locked = true;
      };

      "XF86AudioPause" = {
        action = sh "playerctl play-pause";
        allow-when-locked = true;
      };
      "XF86AudioPlay" = {
        action = sh "playerctl play-pause";
        allow-when-locked = true;
      };
      "XF86AudioNext" = {
        action = sh "playerctl next";
        allow-when-locked = true;
      };
      "XF86AudioPrev" = {
        action = sh "playerctl previous";
        allow-when-locked = true;
      };
    };
  };
}
