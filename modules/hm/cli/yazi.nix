{pkgs, ...}: let
  plugins = {
    # https://github.com/yazi-rs/plugins/
    yazi = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "72f9e3c007956c122d8657f6d39c78e7585a4718";
      hash = "sha256-16QrkNkTMVfmjVqnIYsCGlw6jBDstPhOTnuWgyL+i9s=";
    };

    # https://github.com/Rolv-Apneseth/starship.yazi
    starship = pkgs.fetchFromGitHub {
      owner = "Rolv-Apneseth";
      repo = "starship.yazi";
      rev = "ea92cf49380466f07231c952b409831e6afd2156";
      hash = "sha256-Jvoc/7YaOOppu8K2lJaVgiuBIyanRHHjEA6ZvnrFtiQ=";
    };
    # https://github.com/grappas/wl-clipboard.yazi
    wl-clipboard = pkgs.fetchFromGitHub {
      owner = "grappas";
      repo = "wl-clipboard.yazi";
      rev = "8cc55242dbbc0b60fde27ab0d17bf11d91a14e14";
      hash = "sha256-pIKxWhaVDUOUKvVL4hGXn5zT4K7AvDi/VM+zBCX+19c=";
    };

    # https://github.com/kirasok/epub-preview.yazi
    epub-preview = pkgs.fetchFromGitHub {
      owner = "kirasok";
      repo = "epub-preview.yazi";
      rev = "8d894dba0588da4dd54561b975730320723c2d28";
      hash = "sha256-QP92Uk7hDkZduwRSMNXMOygCUeBlXrL7JnKdK1wIRsQ=";
    };

    # https://github.com/Sonico98/exifaudio.yazi
    exifaudio = pkgs.fetchFromGitHub {
      owner = "Sonico98";
      repo = "exifaudio.yazi";
      rev = "4506f9d5032e714c0689be09d566dd877b9d464e";
      hash = "sha256-RWCqWBpbmU3sh/A+LBJPXL/AY292blKb/zZXGvIA5/o=";
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

    settings = {
      mgr = {
        ratio = [0 2 3];
      };
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
            group = "git";
            url = "*";
            run = "git";
          }
          {
            group = "git";
            url = "*/";
            run = "git";
          }
        ];
      };
    };

    plugins = {
      starship = plugins.starship;
      git = "${plugins.yazi}/git.yazi";
      wl-clipboard = plugins.wl-clipboard;
      epub-preview = plugins.epub-preview;
      exifaudio = plugins.exifaudio;
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
            hide_count = false,
            count_separator = " ",
        })

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
          on = "<S-Delete>";
          run = "remove --permanently";
          desc = "Permanently delete selected files";
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
