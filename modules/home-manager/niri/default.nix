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
  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      binds = with config.lib.niri.actions; let
        sh = spawn "sh" "-c";
      in {
        "Mod+T".action = spawn "kitty";
        "Mod+Shift+T".action = spawn "wezterm";
        "Mod+F".action = spawn "nautilus";
        "Mod+B".action = spawn "zen";
        "Mod+C".action = spawn "code";
        "Mod+Space".action = spawn "fuzzel";

        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Down".action = focus-window-or-workspace-down;
        "Mod+Up".action = focus-window-or-workspace-up;
        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
        "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;

        "Mod+Page_Up".action = focus-workspace-up;
        "Mod+Page_Down".action = focus-workspace-down;
        "Mod+Shift+Page_Up".action = move-window-to-workspace-up;
        "Mod+Shift+Page_Down".action = move-window-to-workspace-down;

        "Mod+Q".action = close-window;
        "Mod+Shift+Q".action = quit;

        "XF86AudioRaiseVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
        "XF86AudioLowerVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        "XF86AudioMute".action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86MonBrightnessUp".action = sh "brightnessctl s +1%";
        "XF86MonBrightnessDown".action = sh "brightnessctl s 1%-";
        "XF86AudioPause".action = sh "playerctl play-pause";
        "XF86AudioNext".action = sh "playerctl next";
        "XF86AudioPrev".action = sh "playerctl previous";
      };
    };
  };
}
