{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    xwayland-satellite
  ];
  programs.niri = {
    settings = {
      hotkey-overlay.skip-at-startup = true;
      input.touchpad.accel-speed = 0.2;

      prefer-no-csd = true;
      window-rules = [
        # Rounded Corners
        {
          geometry-corner-radius = let
            r = 8.0;
          in {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
          clip-to-geometry = true;
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
            {app-id = "^org.wezfurlong.wezterm$";}
            {app-id = "^kitty$";}
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
        preset-column-widths = [
          {proportion = 1.0 / 3.0;}
          {proportion = 1.0 / 2.0;}
          {proportion = 2.0 / 3.0;}
        ];
        struts = {
          left = 8;
          right = 8;
        };
      };

      spawn-at-startup = [
        {
          command = ["swww-daemon"];
        }
        {
          command = ["eww" "daemon"];
        }
        {
          command = ["eww" "open" "sidebar"];
        }
        {
          command = ["clipse" "-listen"];
        }
        {
          command = ["xwayland-satellite"];
        }
      ];

      environment = {
        DISPLAY = ":0";
      };

      binds = with config.lib.niri.actions; let
        sh = spawn "sh" "-c";
      in {
        "Mod+T".action = spawn "wezterm";
        "Mod+Shift+T".action = spawn "kitty";
        "Mod+F".action = spawn "nautilus";
        "Mod+B".action = spawn "zen";
        "Mod+C".action = spawn "code";
        "Mod+O".action = spawn "obsidian";
        "Mod+Shift+O".action = sh "wezterm start --cwd ~/Vault hx ."; # Quick note
        "Mod+Space".action = spawn "anyrun";
        "Mod+F9".action = sh "eww open sidebar --toggle";

        "Mod+Q".action = close-window;
        "Mod+Shift+Q".action = quit;
        "Mod+Shift+Home".action = consume-or-expel-window-left;
        "Mod+Shift+End".action = consume-or-expel-window-right;
        "Mod+U".action = fullscreen-window;
        "Mod+G".action = toggle-window-floating;
        "Mod+Shift+G".action = switch-focus-between-floating-and-tiling;
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

        "Print".action = screenshot;
        "XF86AudioRaiseVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
        "XF86AudioLowerVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        "XF86AudioMute".action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86MonBrightnessUp".action = sh "brightnessctl s +1%";
        "XF86MonBrightnessDown".action = sh "brightnessctl s 1%-";
        "XF86AudioPause".action = sh "playerctl play-pause";
        "XF86AudioPlay".action = sh "playerctl play-pause";
        "XF86AudioNext".action = sh "playerctl next";
        "XF86AudioPrev".action = sh "playerctl previous";
      };
    };
  };
}
