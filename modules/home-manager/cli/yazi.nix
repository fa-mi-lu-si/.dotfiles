{pkgs, ...}: let
  plugins = {
    # https://github.com/yazi-rs/plugins/
    yazi = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "5186af7984aa8cb0550358aefe751201d7a6b5a8";
      hash = "sha256-Cw5iMljJJkxOzAGjWGIlCa7gnItvBln60laFMf6PSPM=";
    };

    # https://github.com/Rolv-Apneseth/starship.yazi
    starship = pkgs.fetchFromGitHub {
      owner = "Rolv-Apneseth";
      repo = "starship.yazi";
      rev = "6c639b474aabb17f5fecce18a4c97bf90b016512";
      hash = "sha256-bhLUziCDnF4QDCyysRn7Az35RAy8ibZIVUzoPgyEO1A=";
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
      rev = "4379fcfa2dbe0b81fde2dd67b9ac2e0e48331419";
      hash = "sha256-CIimJU4KaKyaKBuiBvcRJUJqTG8pkGyytT6bPf/x8j8=";
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
