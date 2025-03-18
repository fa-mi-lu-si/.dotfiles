{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./spicetify.nix
  ];
  home.packages = with pkgs; [
    swww
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
  ];

  services.dunst = {
    enable = true;
  };

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
        terminal = "wezterm -e ";
        layer = "top";
      };
      border = {
        width = 2;
      };
    };
  };

  home.sessionVariables = {
    SWWW_TRANSITION = "left";
    SWWW_TRANSITION_DURATION = "1";
  };

  # gtk.iconTheme = {
  #   name = "Adwaita";
  #   package = pkgs.adwaita-icon-theme;
  # };

  # media buttons for bluetoth devices
  services.mpris-proxy.enable = true;

  programs.zathura.enable = true;
}
