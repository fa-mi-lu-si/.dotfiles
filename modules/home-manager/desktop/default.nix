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

  # Stylix theming for obsidian, just copy the file into Style Settings
  home.file.".config/obsidian/style_settings.json".text = with config.lib.stylix.colors.withHashtag; ''
    {
      "minimal-style@@base@@dark": "${base00}",
      "minimal-style@@ax1@@dark": "${base0D}"
    }
  '';

  services.dunst = {
    enable = true;
  };

  programs.vesktop = {
    enable = true;
  };

  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      mpris
      sponsorblock
    ];
  };

  programs.anyrun = {
    enable = true;
    config = {
      closeOnClick = true;
      hidePluginInfo = true;
      x.fraction = 0.5;
      y.fraction = 0.5;
      width.fraction = 0.3;
      height.fraction = 0.3;
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        shell
        websearch
        stdin
        rink
      ];
    };
    extraConfigFiles = {
      "applications.ron".text =
        # ron
        ''
          Config(
            desktop_actions: false,
            max_entries: 5,
            terminal: Some(Terminal(
              command: "wezterm",
              args: "-e {}",
            )),
          )
        '';
      "websearch.ron".text =
        # ron
        ''
          Config(
            prefix: "?",
            engines: [DuckDuckGo]
          )
        '';
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

  xdg.desktopEntries."swww" = {
    name = "swww";
    exec = "swww img --transition-type left --transition-duration 1 %U";
    comment = "Set the wallpaper";
    mimeType = ["image/jpeg" "image/png" "image/gif" "image/webp"];
    noDisplay = true;
  };

  xdg.userDirs = {
    enable = true;
  };
}
