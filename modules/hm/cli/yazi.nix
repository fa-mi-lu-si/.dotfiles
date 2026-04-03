{pkgs, ...}: let
  plugins = {
    # https://github.com/yazi-rs/plugins/
    yazi = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "e84f4fe5122b659544b4984e6b7daf14383dbe8f";
      hash = "sha256-FVVUU9c3VQBvfjwBBilbBS8ygU4U97L2DwdT4s55OW0=";
    };

    # https://github.com/Rolv-Apneseth/starship.yazi
    starship = pkgs.fetchFromGitHub {
      owner = "Rolv-Apneseth";
      repo = "starship.yazi";
      rev = "a83710153ab5625a64ef98d55e6ddad480a3756f";
      hash = "sha256-CPRVJVunBLwFLCoj+XfoIIwrrwHxqoElbskCXZgFraw=";
    };
    # https://github.com/grappas/wl-clipboard.yazi
    wl-clipboard = pkgs.fetchFromGitHub {
      owner = "grappas";
      repo = "wl-clipboard.yazi";
      rev = "e9a38e47d07549968019702bdafdc4ed07151b7d";
      hash = "sha256-3PRQl4TvuOe5DwVi1gmtmfTOEVZWRayijIbnPgaR3L8=";
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
      rev = "4506f9d5032e714c0689be09d566dd877b9d464e";
      hash = "sha256-RWCqWBpbmU3sh/A+LBJPXL/AY292blKb/zZXGvIA5/o=";
    };

    # https://github.com/uhs-robert/recycle-bin.yazi
    recycle-bin = pkgs.fetchFromGitHub {
      owner = "uhs-robert";
      repo = "recycle-bin.yazi";
      rev = "fa687116c46a784e664ef96619b32abf51f29b06";
      hash = "sha256-lpxTGWA15szM5VJ+qvV2+GTg7HXiZaZfyWyjeNMsTSM=";
    };
  };
in {
  home.packages = with pkgs; [
    epub-thumbnailer
    exiftool
    mediainfo
    trash-cli
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
      indicator = {
        padding = {
          open = "█";
          close = "█";
        };
      };
      tabs = {
        sep_inner = {
          open = "";
          close = "";
        };
        sep_outer = {
          open = "";
          close = "";
        };
      };
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
        require("starship"):setup({
            hide_flags = true,
            flags_after_prompt = true,
            -- Custom starship configuration file to use
            -- config_file = "~/.config/starship_full.toml", -- Default: nil
            show_right_prompt = false,
            -- Whether to hide the count widget, in case you want only your right prompt to show up. Only has
            -- an effect when `show_right_prompt = true`
            hide_count = false,
            -- Separator to place between the right prompt and the count widget. Use `count_separator = ""`
            -- to have no space between the widgets.
            count_separator = " ",
        })
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
            url = "*";
            run = "git";
          }
          {
            id = "git";
            url = "*/";
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
