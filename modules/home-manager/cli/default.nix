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
    plugins = {}; # TODO: get some packages from github
    # TODO: keymap and settings
    keymap = {};
    settings = {};
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
    handlr-regex
    cyme
    bluetuith
    ouch
    gambit-chess

    alejandra
  ];

  programs.nh = {
    enable = true;
    flake = "/home/samy/.dotfiles";
    clean = {
      enable = true;
    };
  };
}
