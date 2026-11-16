{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./niri-screen-time.nix
  ];

  wayland.windowManager.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.system}.niri-unstable;
    extraConfig = builtins.readFile ./config.kdl;
    # TODO: append some config from stylix
  };
}
