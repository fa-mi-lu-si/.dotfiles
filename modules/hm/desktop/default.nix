{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./obsidian.nix
    ./awww.nix
    ./vicinae.nix
  ];

  home.packages = with pkgs; [
    libnotify
    wiremix

    nautilus
    loupe

    amberol
  ];

  xdg.desktopEntries."wiremix" = {
    name = "wiremix";
    exec = "wiremix";
    comment = "Simple TUI mixer for PipeWire";
    terminal = true;
  };

  services.poweralertd = {
    enable = true;
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        dmenu = "vicinae dmenu";
      };
    };
  };

  programs.foliate.enable = true;

  # programs.vesktop = {
  #   enable = true;
  # };

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

  programs.sioyek = {
    enable = true;
    config = {
      should_launch_new_window = "1";
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
