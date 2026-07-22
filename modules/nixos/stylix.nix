{
  pkgs,
  # inputs,
  config,
  ...
}: {
  stylix = {
    enable = true;

    base16Scheme = {
      "base00" = "#B6ACAA";
      "base01" = "#AA9C98";
      "base02" = "#9B877F";
      "base03" = "#8F7B73";
      "base04" = "#59453D";
      "base05" = "#473731";
      "base06" = "#352A25";
      "base07" = "#241C19";
      "base08" = "#933e33";
      "base09" = "#a65530";
      "base0A" = "#b57e2c";
      "base0B" = "#6a7938";
      "base0C" = "#605a81";
      "base0D" = "#514167";
      "base0E" = "#7d4454";
      "base0F" = "#9c5c42";
    };
    polarity = "light";

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
