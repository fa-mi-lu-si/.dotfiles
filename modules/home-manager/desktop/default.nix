{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./spicetify.nix
    ./anyrun.nix
    ./swww.nix
  ];

  home.packages = with pkgs; [
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

  # media buttons for bluetoth devices
  services.mpris-proxy.enable = true;

  programs.zathura.enable = true;

  xdg.userDirs = {
    enable = true;
  };
}
