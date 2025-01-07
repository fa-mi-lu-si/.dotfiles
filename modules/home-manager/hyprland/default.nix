{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    swww
    hyprland-workspaces
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    settings = {
      misc.disable_hyprland_logo = true;
      misc.disable_splash_rendering = true;

      general = {
        border_size = 2;
        resize_on_border = false;
      };

      decoration = {
        rounding = 10;
        shadow.enabled = false;
        blur.enabled = false;
      };

      exec-once = [
        "clipse -listen"
        "swww-daemon"
      ];

      exec = [
        "swww restore"
      ];

      monitor = ",preferred, auto, auto";

      "$mod" = "SUPER";
      bind = [
        # Execute Programs
        "$mod, B, exec, zen"
        "$mod, T, exec, kitty"
        "$mod, F, exec, nautilus"
        "$mod, C, exec, code"
        "$mod, O, exec, obsidian"
        "$mod, space, exec, anyrun"
        "$mod, V, exec, kitty --class=float_term -o initial_window_width=450 -o initial_window_height=650 clipse"
        "$mod, Q, killactive"
        "$mod ALT , Q, exit"

        # Move around
        "ALT, tab, cycleNext"
        "$mod, left, moveFocus, l"
        "$mod, right, moveFocus, r"
        "$mod, up, moveFocus, u"
        "$mod, down, moveFocus, d"
        "$mod SHIFT, left, moveWindow, l"
        "$mod SHIFT, right, moveWindow, r"
        "$mod SHIFT, up, moveWindow, u"
        "$mod SHIFT, down, moveWindow, d"
        "$mod, page_up, workspace, -1"
        "$mod, page_down, workspace, +1"
        "$mod SHIFT, page_up, movetoworkspace, -1"
        "$mod SHIFT, page_down, movetoworkspace, +1"

        # Brightness Volume Media Control
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86MonBrightnessUp, exec, brightnessctl s +1%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 1%-"

        # Tiling controls
        "$mod, P, pseudo,"
        "$mod, G, togglefloating,"
        "$mod, U, fullscreen,"

        "$mod, mouse_down, workspace, -1"
        "$mod, mouse_up, workspace, +1"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "suppressevent minimize, class:.*"

        # floating terminals
        "float, class:(float_term)"
      ];

      animations = {
        enabled = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      input.touchpad.natural_scroll = true;
      input.sensitivity = 0.2;
      gestures.workspace_swipe = true;
      cursor.inactive_timeout = 30;
    };
  };
}
