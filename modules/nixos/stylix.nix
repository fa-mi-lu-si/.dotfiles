{
  pkgs,
  # inputs,
  config,
  ...
}: {
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-soft.yaml";
    polarity = "dark";

    image = config.lib.stylix.pixel "base00";

    cursor = {
      package = pkgs.quintom-cursor-theme;
      name = "Quintom_Snow";
      size = 20;
    };

    fonts = with pkgs; {
      monospace = {
        package = nerd-fonts.recursive-mono;
        name = "RecMonoSmCasual Nerd Font";
      };
      sansSerif = {
        package = dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = dejavu_fonts;
        name = "DejaVu Serif";
      };
      emoji = {
        package = noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
