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
    ./scrcpy.nix
  ];

  home.packages = with pkgs; [
    libnotify
    wiremix

    # phone stuff
    android-tools

    nautilus
    loupe
    tuba

    amberol
    euphonica

    authenticator
  ];

  xdg.desktopEntries."wiremix" = {
    name = "wiremix";
    exec = "wiremix";
    comment = "Simple TUI mixer for PipeWire";
    terminal = true;
  };

  programs.fuzzel = {
    enable = true;
  };

  services.poweralertd = {
    enable = true;
  };

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
    events = {
      "before-sleep" = "${lib.getExe pkgs.swaylock} -f";
      "lock" = "${lib.getExe pkgs.swaylock} -f";
    };
  };

  xdg.userDirs = {
    enable = true;
  };

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = ["com.mitchellh.ghostty.desktop"];
    };
  };
}
