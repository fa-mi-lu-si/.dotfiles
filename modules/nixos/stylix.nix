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
      "base08" = "#B66467";
      "base09" = "#C8907A";
      "base0A" = "#D9BC8C";
      "base0B" = "#8C977D";
      "base0C" = "#8AA6A2";
      "base0D" = "#959BC3";
      "base0E" = "#A988B0";
      "base0F" = "#BE95FF";
    };
    polarity = "dark";

    image = config.lib.stylix.pixel "base00";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = with pkgs; {
      monospace = {
        package = nerd-fonts._0xproto;
        name = "0xProto Nerd Font";
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
  stylix.targets.chromium.enable = false;
}
