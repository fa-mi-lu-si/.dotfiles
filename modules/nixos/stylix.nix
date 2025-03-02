{
  pkgs,
  # inputs,
  config,
  ...
}: {
  stylix = {
    enable = true;

    base16Scheme = {
      # Paradise
      "base00" = "#151515";
      "base01" = "#1B1B1B";
      "base02" = "#242424";
      "base03" = "#424242";
      "base04" = "#bbb6b6";
      "base05" = "#E8E3E3";
      "base06" = "#dcdcdc";
      "base07" = "#f0f0f0";
      "base08" = "#B66467";
      "base09" = "#C8907A";
      "base0A" = "#D9BC8C";
      "base0B" = "#8C977D";
      "base0C" = "#8AA6A2";
      "base0D" = "#8DA3B9";
      "base0E" = "#A988B0";
      "base0F" = "#C0784D";
    };
    polarity = "dark";

    image = config.lib.stylix.pixel "base00";

    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;

    fonts = with pkgs; {
      monospace = {
        package = nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
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
