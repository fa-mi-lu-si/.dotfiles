{
  # inputs,
  # config,
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

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batman
      batgrep
    ];
  };

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--smart-case"
      "--hyperlink-format=default"
    ];
  };

  programs.eza = {
    enable = true;
    colors = "auto";
    icons = "auto";
    extraOptions = [
      "--hyperlink"
      "--git-ignore"
    ];
    # dont replace the default ls
    enableNushellIntegration = false;
  };

  home.packages = with pkgs; [
    presenterm
    serie

    wl-clipboard
    clipse
    handlr-regex
    cyme
    bluetuith
    ouch
  ];

  programs.btop = {
    enable = true;
  };

  programs.fastfetch = {
    enable = true;
  };

  programs.nh = {
    enable = true;
    flake = "/home/samy/.dotfiles";
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };
  };
}
