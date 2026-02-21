{inputs, ...}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  services.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
      environment = {
        USE_LAYER_SHELL = 1;
      };
    };
    settings = {
      close_on_focus_loss = true;
      favorites = [];
      launcher_window = {
        client_side_decorations = {enabled = true;};
      };
      pop_to_root_on_close = true;
      providers = {
        "@Gelei/store.vicinae.bluetooth" = {
          entrypoints = {
            devices = {alias = "bl";};
          };
        };
        "@asubbotin/store.raycast.shell" = {
          entrypoints = {
            index = {alias = "sh";};
          };
        };
        "@knoopx/store.vicinae.niri" = {
          entrypoints = {
            windows = {alias = "w";};
          };
        };
        "@knoopx/store.vicinae.otp" = {
          entrypoints = {
            list-codes = {alias = "auth";};
          };
        };
        "@sovereign/store.vicinae.awww-switcher" = {
          preferences = {
            transitionDuration = "1";
            transitionType = "left";
            wallpaperPath = "/home/samy/Pictures/walls";
          };
        };
      };
      theme = {
        dark = {
          icon_theme = "MoreWaita";
          name = "stylix";
        };
      };
    };
  };
}
