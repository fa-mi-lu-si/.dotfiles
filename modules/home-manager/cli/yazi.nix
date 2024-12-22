{
  inputs,
  config,
  pkgs,
  ...
}: let
  plugins = {
    # https://github.com/yazi-rs/plugins/
    yazi = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "7afba3a73cdd69f346408b77ea5aac26fe09e551";
    };

    # https://github.com/boydaihungst/simple-mtpfs.yazi
    simple-mtpfs = pkgs.fetchFromGitHub {
      owner = "boydaihungst";
      repo = "simple-mtpfs.yazi";
      rev = "4941d8f211b620bff3b11d17add6c2f5ccd3781e";
    };

    # https://github.com/Rolv-Apneseth/starship.yazi
    starship = pkgs.fetchFromGitHub {
      owner = "Rolv-Apneseth";
      repo = "starship.yazi";
      rev = "247f49da1c408235202848c0897289ed51b69343";
    };
  };
in {
  programs.yazi = {
    enable = true;

    plugins = {
      starship = plugins.starship;
      git = "${plugins.yazi}/git.yazi";
    };

    initLua =
      #lua
      ''
        require("starship"):setup()
      '';

    # TODO: keymap and settings
    keymap = {};
    settings = {};
  };
}
