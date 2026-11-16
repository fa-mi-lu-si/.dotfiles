{
  inputs,
  pkgs,
  ...
}: {
  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.system}.niri-unstable;
  };
}
