{
  pkgs,
  # inputs,
  config,
  ...
}: {
  stylix = {
    enable = true;

    base16Scheme = {
      "base00" = "#151515";
      "base01" = "#1B1B1B";
      "base02" = "#242424";
      "base03" = "#393939";
      "base04" = "#BBBEC9";
      "base05" = "#E8E3E3";
      "base06" = "#DCDCDC";
      "base07" = "#F0F0F0";
      "base08" = "#f6998f";
      "base09" = "#ffa888";
      "base0A" = "#ffc37a";
      "base0B" = "#b6c68a";
      "base0C" = "#c0bcdb";
      "base0D" = "#b0a4c3";
      "base0E" = "#d8a2b0";
      "base0F" = "#f1ae97";
    };
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
        package = noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
