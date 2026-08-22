{...}: {
  imports = [
    ./niri-screen-time.nix
  ];

  wayland.windowManager.niri = {
    enable = true;
    extraConfig = builtins.readFile ./config.kdl;
  };
}
