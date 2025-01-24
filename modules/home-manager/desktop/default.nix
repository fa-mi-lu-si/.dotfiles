{
  inputs,
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
    iagno
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
