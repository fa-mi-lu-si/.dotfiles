{pkgs, ...}: let
  plugins = {
    # https://github.com/yazi-rs/plugins/
    yazi = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "63f9650e522336e0010261dcd0ffb0bf114cf912";
      hash = "sha256-ZCLJ6BjMAj64/zM606qxnmzl2la4dvO/F5QFicBEYfU=";
    };

    # https://github.com/Rolv-Apneseth/starship.yazi
    starship = pkgs.fetchFromGitHub {
      owner = "Rolv-Apneseth";
      repo = "starship.yazi";
      rev = "6a0f3f788971b155cbc7cec47f6f11aebbc148c9";
      hash = "sha256-q1G0Y4JAuAv8+zckImzbRvozVn489qiYVGFQbdCxC98=";
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
      rev = "521feb15502f0424027db77cdab635dba58e0617";
      hash = "sha256-PUwHtd5KeXiieeomQYuazfagJUMlkbU9hb30EKH7Mp4=";
    };

    # https://github.com/Sonico98/exifaudio.yazi
    exifaudio = pkgs.fetchFromGitHub {
      owner = "Sonico98";
      repo = "exifaudio.yazi";
      rev = "e766cd273246612fe71fc18d2126619a41273c32";
      hash = "sha256-aniuY14pXcoaW6YkUwt7hTl9mWjl5HoOPhHkuY4ooAw=";
    };
  };
in {
  home.packages = with pkgs; [
    epub-thumbnailer
    exiftool
    mediainfo
  ];

  programs.yazi = {
    enable = true;

    plugins = {
      starship = plugins.starship;
      git = "${plugins.yazi}/git.yazi";
      wl-clipboard = plugins.wl-clipboard;
      epub-preview = plugins.epub-preview;
      exifaudio = plugins.exifaudio;
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
