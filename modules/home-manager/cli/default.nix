{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./nushell.nix
    ./bottom.nix
    ./starship.nix
    ./git.nix
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
  };

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };
  programs.yazi = {
    enable = true;
    plugins = {}; # get some packages from github
    # check the other home-manager options
  };

  programs.tealdeer = {
    enable = true;
    settings = {
      updates.auto_update = true;
    };
  };

  home.packages = with pkgs; [
    bottom
    tree
    ripgrep
    fd

    termusic
    handlr-regex # alternative to xdg-open
    cyme # list usb devices
    bluetuith # bluetooth connection managern
    ouch # compression helper
    gambit-chess

    alejandra # nix formatter
  ];

  programs.nh = {
    enable = true;
    flake = "/home/samy/.dotfiles";
    clean = {
      enable = true;
    };
  };
}
