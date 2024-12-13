{
  inputs,
  config,
  pkgs,
  ...
}: {
  # set the desktop portal

  home.packages = with pkgs; [
    # add hyprland specific deps
    # use pkgs.name in binds instead
    wl-clipboard
    clipse # manage config with home manager
  ];

  services.hyprpaper = {
    enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    settings = {
      misc.disable_hyprland_logo = true;
      misc.vfr = true;
      misc.disable_splash_rendering = true;
      general = {
        border_size = 2;
        resize_on_border = false;
      };
      decoration.rounding = 10;

      exec-once = [
        "clipse -listen"
      ];

      monitor = ",preferred, auto, auto";

      "$mod" = "SUPER";
      bind = [
        # Execute Programs
        "$mod, B, exec, firefox"
        "$mod, T, exec, kitty"
        "$mod, F, exec, nautilus"
        "$mod, C, exec, code"
        "$mod, O, exec, obsidian"
        "$mod, space, exec, anyrun"
        "$mod, V, exec, kitty --class=clipse clipse"
        "$mod, Q, killactive"
        "$mod ALT , Q, exit"

        # Move around
        "$mod, left, moveFocus, l"
        "$mod, right, moveFocus, r"
        "$mod, up, moveFocus, u"
        "$mod, down, moveFocus, d"
        "$mod, page_up, workspace, -1"
        "$mod, page_down, workspace, +1"
        "$mod SHIFT, page_up, movetoworkspace, -1"
        "$mod SHIFT, page_down, movetoworkspace, +1"

        # Brightness Volume Media Control
        # make this pipewire native wireplumber
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

        "$mod, mouse_down, workspace, +1"
        "$mod, mouse_up, workspace, -1"
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

        # float the clipboard manager
        "float, class:(clipse)"
        "size 450 652, class:(clipse)"
      ];

      animations = {
        enabled = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      input.touchpad.natural_scroll = true;
      input.sensitivity = 0.2;
      gestures.workspace_swipe = true;
    };
  };
}
