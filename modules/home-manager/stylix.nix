{
  config,
  lib,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    iconTheme = {
      enable = true;
      package = pkgs.adwaita-icon-theme;
      dark = "Adwaita";
      light = "Adwaita";
    };

    # use sww instead of hyprpaper
    targets.hyprland.hyprpaper.enable = false;
    targets.hyprpaper.enable = false;
  };
}
