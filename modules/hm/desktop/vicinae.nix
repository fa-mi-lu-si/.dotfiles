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
      closeOnFocusLoss = true;
      faviconService = "twenty";
      font = {size = 10.5;};
      keybinding = "default";
      keybinds = {};
      popToRootOnClose = true;
      rootSearch = {searchFiles = false;};
      window = {
        csd = true;
        rounding = 4;
      };
    };
  };
}
