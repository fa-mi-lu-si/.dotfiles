{
  inputs,
  pkgs,
  config,
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

  # Stylix theme for foliate
  home.file.".config/com.github.johnfactotum.Foliate/themes/stylix.json".text = with config.lib.stylix.colors.withHashtag; ''
    {
      "label": "Stylix",
      "light": {
        "fg": "${base05}",
        "bg": "${base00}",
        "link": "${base04}"
      },
      "dark": {
        "fg": "${base05}",
        "bg": "${base00}",
        "link": "${base04}"
      }
    }
  '';

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

  xdg.userDirs = {
    enable = true;
  };
}
