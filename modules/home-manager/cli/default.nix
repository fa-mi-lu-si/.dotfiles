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
    ./yazi.nix
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
    serie
    gum

    wl-clipboard
    clipse
    termusic
    handlr-regex
    cyme
    bluetuith
    ouch
    gambit-chess
  ];

  programs.nh = {
    enable = true;
    flake = "/home/samy/.dotfiles";
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };
  };
}
