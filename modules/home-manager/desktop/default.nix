{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./spicetify.nix
  ];
  home.packages = with pkgs; [
    dunst
    libnotify
    scrcpy
    inputs.zen-browser.packages."${system}".default

    nautilus
    loupe
    obsidian
    vesktop

    celluloid
    amberol

    foliate
    eartag
  ];

  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      mpris
      sponsorblock
    ];
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "kitty";
        layer = "top";
      };
      border = {
        width = 2;
      };
    };
  };

  home.sessionVariables = {
    SWWW_TRANSITION = "center";
  };

  # gtk.iconTheme = {
  #   name = "Adwaita";
  #   package = pkgs.adwaita-icon-theme;
  # };

  # media buttons for bluetoth devices
  services.mpris-proxy.enable = true;

  programs.zathura.enable = true;
}
