{pkgs, ...}: {
  home.packages = with pkgs; [adwaita-icon-theme]; # morewaita requires adwaita installed

  stylix = {
    enable = true;
    icons = {
      enable = true;
      dark = "MoreWaita";
      light = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };
  };
}
