{config, ...}: {
  programs.foliate = {
    enable = true;
    settings."viewer/view" = {
      theme = "stylix.json";
    };

    themes.stylix = with config.lib.stylix.colors.withHashtag; {
      label = "Stylix";
      light = {
        fg = base05;
        bg = base00;
        link = base0D;
      };
      dark = {
        fg = base05;
        bg = base00;
        link = base0D;
      };
    };
  };

  stylix.targets.foliate.enable = false;
}
