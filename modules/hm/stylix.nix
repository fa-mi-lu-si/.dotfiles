{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [adwaita-icon-theme]; # morewaita requires adwaita installed

  stylix = {
    enable = true;
    icons = {
      enable = true;
      dark = "MoreWaita";
      light = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };

    # spicetify stylix doesn't work well
    targets.spicetify.enable = false;
    # this takes too long to build
    targets.gtksourceview.enable = false;

    # force transparent helix
    targets.helix.transparent = lib.mkForce true;
  };

  # make the ghostty cursor white
  programs.ghostty.themes.stylix.cursor-color = "#EFEAE8";

  # yazi highlighted item
  programs.yazi.theme = {
    indicator.parent = lib.mkForce {bg = config.lib.stylix.colors.withHashtag.base01;};
    indicator.preview = lib.mkForce {bg = config.lib.stylix.colors.withHashtag.base01;};
  };

  # TODO: make helix comments white

  # white borders in niri
  programs.niri.settings = {
    layout.border = {
      active = {color = "#EFEAE8";};
      inactive = {color = "transparent";};
    };
  };
}
