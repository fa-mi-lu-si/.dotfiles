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

  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--walker=file,follow"
    ];
  };

  programs.fd = {
    enable = true;
  };

  programs.atuin = {
    enable = true;
    settings = {
      style = "compact";
    };
    flags = [
      "--disable-ctrl-r"
      "--disable-up-arrow"
    ];
  };

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--smart-case"
      "--hyperlink-format=default"
    ];
  };

  home.packages = with pkgs; [
    tree
    serie
    gum

    wl-clipboard
    clipse
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
