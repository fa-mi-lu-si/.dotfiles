{pkgs, ...}: {
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

  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;

  services.dunst = {
    enable = true;
  };

  programs.foliate.enable = true;

  services.kdeconnect = {
    enable = true;
    package = pkgs.valent;
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

  # media buttons for bluetoth devices
  services.mpris-proxy.enable = true;

  programs.zathura.enable = true;
  programs.swaylock = {
    enable = true;
  };

  xdg.userDirs = {
    enable = true;
  };
}
