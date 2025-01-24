{pkgs, ...}: let
  plugins = {
    # https://github.com/yazi-rs/plugins/
    yazi = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "600614a9dc59a12a63721738498c5541c7923873";
      hash = "sha256-mQkivPt9tOXom78jgvSwveF/8SD8M2XCXxGY8oijl+o=";
    };

    # https://github.com/Rolv-Apneseth/starship.yazi
    starship = pkgs.fetchFromGitHub {
      owner = "Rolv-Apneseth";
      repo = "starship.yazi";
      rev = "4053c8c486f9cfd60f1f42fa5d80e97caef41eb1";
      hash = "sha256-KTN3gf3VFGlBxgsQFMa/fdhoovapXo0X65IJjXcl98A=";
    };
    # https://github.com/grappas/wl-clipboard.yazi
    wl-clipboard = pkgs.fetchFromGitHub {
      owner = "grappas";
      repo = "wl-clipboard.yazi";
      rev = "c4edc4f6adf088521f11d0acf2b70610c31924f0";
      hash = "sha256-jlZgN93HjfK+7H27Ifk7fs0jJaIdnOyY1wKxHz1wX2c=";
    };

    # https://github.com/kirasok/epub-preview.yazi
    epub-preview = pkgs.fetchFromGitHub {
      owner = "kirasok";
      repo = "epub-preview.yazi";
      rev = "77a76b8dc36c52b8713bd3745456d096732be7bd";
      hash = "sha256-Ig0sUamVUmveOm0EuCBE2hzk53LdDVjUg7Ij0CnnDmE=";
    };
  };
in {
  home.packages = with pkgs; [
    epub-thumbnailer
  ];

  programs.yazi = {
    enable = true;

    plugins = {
      starship = plugins.starship;
      git = "${plugins.yazi}/git.yazi";
      wl-clipboard = plugins.wl-clipboard;
      epub-preview = plugins.epub-preview;
    };
    theme = {
      manager = {
        border_symbol = " ";
      };
      status = {
        separator_open = "";
        separator_close = "";
      };
    };

    initLua =
      #lua
      ''
        require("starship"):setup()

        THEME.git = THEME.git or {}

        THEME.git.modified_sign = " "
        THEME.git.modified = ui.Style():fg("gray")

        THEME.git.added_sign = "+ "
        THEME.git.added = ui.Style():fg("green")

        THEME.git.untracked_sign = " "
        THEME.git.untracked = ui.Style():fg("red"):bold()

        THEME.git.ignored_sign = " "
        THEME.git.ignored = ui.Style():fg("darkgray"):bold()

        THEME.git.deleted_sign = " "
        THEME.git.deleted = ui.Style():fg("red"):bold()

        THEME.git.updated_sign = " "
        THEME.git.updated = ui.Style():fg("green"):bold()

        require("git"):setup()
      '';

    keymap = {
      manager.prepend_keymap = [
        {
          on = ["g" "v"];
          run = "cd ~/Vault";
          desc = "Goto Vault";
        }
        {
          on = ["g" "."];
          run = "cd ~/.dotfiles";
          desc = "Goto dotfiles";
        }
        {
          on = ["g" "p"];
          run = "cd ~/Projects";
          desc = "Goto Projects";
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
        {
          on = "<C-t>";
          run = "tab_create --current";
        }
        {
          on = "<C-w>";
          run = "close";
        }
        {
          on = "<C-PageUp>";
          run = "tab_switch -1 --relative";
        }
        {
          on = "<C-PageDown>";
          run = "tab_switch 1 --relative";
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
        prepend_previewers = [
          {
            mime = "application/epub+zip";
            run = "epub-preview";
          }
        ];
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
