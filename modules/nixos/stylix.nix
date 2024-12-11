{
  pkgs,
  inputs,
  config,
  ...
}: {
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
    polarity = "dark";

    image = pkgs.fetchurl {
      url = "https://images6.alphacoders.com/126/1268195.png";
      sha256 = "3f639d1e0e4d64631d0dc4409e2faa45dba77650261dd33300f7e7682ed7ff1a";
    };

    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";

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
