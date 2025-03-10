{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    # inputs.niri.nixosModules.niri
  ];
  environment.systemPackages = [pkgs.xdg-utils];
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
    ];
  };
}
