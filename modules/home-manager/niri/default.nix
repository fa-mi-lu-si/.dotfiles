{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
  ];
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
}
