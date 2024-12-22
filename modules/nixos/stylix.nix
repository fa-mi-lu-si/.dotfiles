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

    image = ./wallpaper.webp;

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
