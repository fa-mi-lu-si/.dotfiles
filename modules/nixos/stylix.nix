{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/mountain.yaml";
    polarity = "dark";

    image = config.lib.stylix.pixel "base00";

    cursor = {
      package = pkgs.callPackage ../../pkgs/cursors-comic-book.nix {};
      name = "MacOS-Comic-Book";
      size = 32;
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
        package = pkgs.callPackage ../../pkgs/libron.nix {};
        name = "Libron H";
      };
      emoji = {
        package = noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
