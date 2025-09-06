{pkgs, ...}: let
  plugins = {
    # https://github.com/yazi-rs/plugins/
    yazi = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "b8860253fc44e500edeb7a09db648a829084facd";
      hash = "sha256-29K8PmBoqAMcQhDIfOVnbJt2FU4BR6k23Es9CqyEloo=";
    };

    # https://github.com/Rolv-Apneseth/starship.yazi
    starship = pkgs.fetchFromGitHub {
      owner = "Rolv-Apneseth";
      repo = "starship.yazi";
      rev = "a63550b2f91f0553cc545fd8081a03810bc41bc0";
      hash = "sha256-PYeR6fiWDbUMpJbTFSkM57FzmCbsB4W4IXXe25wLncg=";
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
      rev = "2e8079e4a7f6315de99a5b968ed5fda479f1f39c";
      hash = "sha256-wHTR8frrFL3cUD8fvSTO+m/77wQ7auVjTZ1uCTB/UzU=";
    };

    # https://github.com/Sonico98/exifaudio.yazi
    exifaudio = pkgs.fetchFromGitHub {
      owner = "Sonico98";
      repo = "exifaudio.yazi";
      rev = "e766cd273246612fe71fc18d2126619a41273c32";
      hash = "sha256-aniuY14pXcoaW6YkUwt7hTl9mWjl5HoOPhHkuY4ooAw=";
    };

    # https://github.com/uhs-robert/recycle-bin.yazi
    recycle-bin = pkgs.fetchFromGitHub {
      owner = "uhs-robert";
      repo = "recycle-bin.yazi";
      rev = "3f36069567b4602f841f2377c5f182f9a2480dea";
      hash = "sha256-f9L8ipErNwFKMqIKUa+1oPmPBk0oh5UCkJJa1tTiIv0=";
    };
  };
in {
  home.packages = with pkgs; [
    epub-thumbnailer
    exiftool
    mediainfo
    trash-cli # TODO: switch to trashy and create aliases
  ];

  programs.yazi = {
    enable = true;

    plugins = {
      starship = plugins.starship;
      git = "${plugins.yazi}/git.yazi";
      wl-clipboard = plugins.wl-clipboard;
      epub-preview = plugins.epub-preview;
      exifaudio = plugins.exifaudio;
      recycle-bin = plugins.recycle-bin;
    };
    theme = {
      mgr = {
        border_symbol = " ";
      };
      status = {
        sep_left = {
          open = "";
          close = "";
        };
        sep_right = {
          open = "";
          close = "";
        };
      };
    };

    initLua =
      #lua
      ''
        require("starship"):setup()
        require("recycle-bin"):setup()

        th.git = th.git or {}

        th.git.modified_sign = " "
        th.git.modified = ui.Style():fg("gray")

        th.git.added_sign = "+ "
        th.git.added = ui.Style():fg("green")

        th.git.untracked_sign = " "
        th.git.untracked = ui.Style():fg("red"):bold()

        th.git.ignored_sign = " "
        th.git.ignored = ui.Style():fg("darkgray"):bold()

        th.git.deleted_sign = " "
        th.git.deleted = ui.Style():fg("red"):bold()

        th.git.updated_sign = " "
        th.git.updated = ui.Style():fg("green"):bold()

        require("git"):setup()
      '';

    keymap = {
      mgr.prepend_keymap = [
        {
          on = ["g" "v"];
          run = "cd ~/Vault";
          desc = "Goto Vault";
        }
        {
          on = ["g" "t"];
          run = "plugin recycle-bin open";
          desc = "Goto Trash";
        }
        {
          on = ["R" "o"];
          run = "plugin recycle-bin open";
          desc = "Goto Trash";
        }
        {
          on = ["R" "e"];
          run = "plugin recycle-bin empty";
          desc = "Empty Trash";
        }
        {
          on = ["R" "d"];
          run = "plugin recycle-bin delete";
          desc = "Delete from Trash";
        }
        {
          on = ["R" "D"];
          run = "plugin recycle-bin emptyDays";
          desc = "Empty by days deleted";
        }
        {
          on = ["R" "r"];
          run = "plugin recycle-bin restore";
          desc = "Restore from Trash";
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
            mime = "audio/*";
            run = "exifaudio";
          }
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
    theme = {
      icon = {
        prepend_dirs = [
          {
            name = "Books";
            text = "";
          }
          {
            name = "Projects";
            text = "";
          }
        ];
      };
    };
  };
}
