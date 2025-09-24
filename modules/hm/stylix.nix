{pkgs, ...}: {
  home.packages = with pkgs; [adwaita-icon-theme morewaita-icon-theme];

  stylix = {
    enable = true;
    iconTheme = {
      enable = true;
      dark = "MoreWaita";
      light = "MoreWaita";
    };
  };
}
