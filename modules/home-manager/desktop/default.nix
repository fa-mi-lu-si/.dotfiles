{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./spicetify.nix
    ./anyrun.nix
  ];
  home.packages = with pkgs; [
    swww
    libnotify
    scrcpy

    nautilus
    loupe
    obsidian

    celluloid
    amberol
  ];

  # Stylix theming for obsidian, just copy the file into Style Settings
  home.file.".config/obsidian/style_settings.json".text = with config.lib.stylix.colors.withHashtag; ''
    {
      "minimal-style@@base@@dark": "${base00}",
      "minimal-style@@ax1@@dark": "${base0D}"
    }
  '';

  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;

  services.dunst = {
    enable = true;
  };

  programs.foliate.enable = true;

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
