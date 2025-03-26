{pkgs, ...}: {
  stylix = {
    enable = true;
    iconTheme = {
      enable = true;
      package = pkgs.adwaita-icon-theme;
      dark = "Adwaita";
      light = "Adwaita";
    };
  };
}
