{
  lib,
  pkgs,
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
    tuba

    celluloid
    amberol
    euphonica
  ];

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
  programs.swaylock = {
    enable = true;
  };
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${lib.getExe pkgs.swaylock} -f";
      }
      {
        event = "lock";
        command = "${lib.getExe pkgs.swaylock} -f";
      }
    ];
  };

  xdg.userDirs = {
    enable = true;
  };
}
