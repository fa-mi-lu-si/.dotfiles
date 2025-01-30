{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    inputs.newm-next.packages.${pkgs.stdenv.hostPlatform.system}.newm-next
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  hardware.graphics.enable = true;

  # xdg.portal.enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
