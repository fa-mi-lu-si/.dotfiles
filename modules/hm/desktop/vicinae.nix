{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  programs.vicinae = {
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
        client_side_decorations = {
          enabled = true;
          shadow_size = 0;
        };
      };
      pop_to_root_on_close = true;
      theme = {
        dark = {
          icon_theme = config.stylix.icons.dark;
          name = "stylix";
        };
      };
    };
  };
}
