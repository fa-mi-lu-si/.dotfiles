{
  inputs,
  config,
  pkgs,
  ...
}: let
  plugins = {
    # TODO: make rev HEAD to point to latest commit
    # then fix the hash on failed rebuild :(

    # https://github.com/yazi-rs/plugins/
    yazi = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "7afba3a73cdd69f346408b77ea5aac26fe09e551";
      hash = "sha256-w9dSXW0NpgMOTnBlL/tzlNSCyRpZNT4XIcWZW5NlIUQ=";
    };

    # https://github.com/Rolv-Apneseth/starship.yazi
    starship = pkgs.fetchFromGitHub {
      owner = "Rolv-Apneseth";
      repo = "starship.yazi";
      rev = "247f49da1c408235202848c0897289ed51b69343";
      hash = "sha256-0J6hxcdDX9b63adVlNVWysRR5htwAtP5WhIJ2AK2+Gs=";
    };
    # https://github.com/grappas/wl-clipboard.yazi
    wl-clipboard = pkgs.fetchFromGitHub {
      owner = "grappas";
      repo = "wl-clipboard.yazi";
      rev = "c4edc4f6adf088521f11d0acf2b70610c31924f0";
      hash = "sha256-jlZgN93HjfK+7H27Ifk7fs0jJaIdnOyY1wKxHz1wX2c=";
    };
  };
in {
  programs.yazi = {
    enable = true;

    plugins = {
      # starship = plugins.starship;
      git = "${plugins.yazi}/git.yazi";
      wl-clipboard = plugins.wl-clipboard;
    };
    theme = {
      manager = {
        border_symbol = " ";
      };
    };

    initLua =
      #lua
      ''
        require("starship"):setup()
        require("git"):setup()
        THEME.git = THEME.git or {}
        THEME.git.deleted = ui.Style():fg("red"):bold()
        THEME.git.modified_sign = " "
        THEME.git.added_sign = "+ "
        THEME.git.untracked_sign = " "
        THEME.git.deleted_sign = "󰗨 "
      '';

    keymap = {
      manager.prepend_keymap = [
        {
          on = "!";
          run = ["shell --block nu"];
          desc = "open shell here";
        }
        {
          on = "<F9>";
          run = "quit";
          desc = "Quit the process";
        }
        {
          on = "<C-c>";
          run = ["plugin wl-clipboard" "yank"];
        }
        {
          on = "<C-v>";
          run = "paste";
        }
      ];
      input.prepend_keymap = [
        {
          on = "<Esc>";
          run = "close";
          desc = "cancel input";
        }
      ];
    };
    settings = {
      plugin = {
        prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
      };
    };
  };
}
