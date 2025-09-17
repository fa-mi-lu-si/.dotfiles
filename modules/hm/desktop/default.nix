{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./spicetify.nix
    ./obsidian.nix
    ./swww.nix
    ./vicinae.nix
  ];

  home.packages = with pkgs; [
    libnotify
    wiremix
    scrcpy

    nautilus
    loupe
    tuba

    celluloid
    amberol
    euphonica

    authenticator
  ];

  programs.fuzzel = {
    enable = true;
  };

  services.poweralertd = {
    enable = true;
  };

  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;

  services.dunst = {
    enable = true;
    settings = {
      global = {
        dmenu = "fuzzel -d";
      };
    };
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

  # media control
  services.playerctld.enable = true;
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

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = ["org.wezfurlong.wezterm.desktop"];
    };
  };
}
