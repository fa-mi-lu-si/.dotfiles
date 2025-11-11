{
  pkgs,
  # inputs,
  config,
  ...
}: {
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/terracotta-dark.yaml";
    polarity = "dark";

    image = config.lib.stylix.pixel "base00";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 22;
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
        package = noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
