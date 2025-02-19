{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
  ];
  home.packages = with pkgs; [
    xwayland-satellite
  ];
  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      hotkey-overlay.skip-at-startup = true;
      input.focus-follows-mouse.enable = true;

      prefer-no-csd = true;
      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 10.0;
            top-right = 10.0;
            bottom-left = 10.0;
            bottom-right = 10.0;
          };
          clip-to-geometry = true;
        }
      ];
      layout = {
        border.width = 2;
        always-center-single-column = true;
        preset-column-widths = [
          {proportion = 1.0 / 3.0;}
          {proportion = 1.0 / 2.0;}
          {proportion = 2.0 / 3.0;}
          {proportion = 1.0 / 1.0;}
        ];
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
        "Mod+T".action = spawn "kitty";
        "Mod+Shift+T".action = spawn "wezterm";
        "Mod+F".action = spawn "nautilus";
        "Mod+B".action = spawn "zen";
        "Mod+C".action = spawn "code";
        "Mod+O".action = spawn "obsidian";
        "Mod+Space".action = spawn "fuzzel";

        "Mod+Q".action = close-window;
        "Mod+R".action = switch-preset-column-width;
        "Mod+M".action = maximize-column;
        "Mod+U".action = fullscreen-window;
        "Mod+Shift+Q".action = quit;

        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Down".action = focus-window-or-workspace-down;
        "Mod+Up".action = focus-window-or-workspace-up;
        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
        "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
        # "Mod+Home".action = focus-column-first;
        # "Mod+End".action = focus-column-last;
        # "Mod+Shift+Home".action = move-column-to-first;
        # "Mod+Shift+End".action = move-column-to-last;

        # "Mod+Page_Up".action = focus-workspace-up;
        # "Mod+Page_Down".action = focus-workspace-down;
        # "Mod+Shift+Page_Up".action = move-window-to-workspace-up;
        # "Mod+Shift+Page_Down".action = move-window-to-workspace-down;

        "Mod+Shift+TouchpadScrollDown".action = sh "brightnessctl s +1%";
        "Mod+Shift+TouchpadScrollUp".action = sh "brightnessctl s 1%-";
        "Mod+TouchpadScrollDown".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02+";
        "Mod+TouchpadScrollUp".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02-";

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
