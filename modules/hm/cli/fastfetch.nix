{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      display = {separator = " - ";};
      logo = {
        padding = {right = 1;};
        source = ./nix.png;
        height = 8;
        type = "kitty";
      };
      modules = [
        {
          format = " {#1}{user-name}{#}@{#2}{host-name}{#}";
          type = "title";
        }
        {
          format = "{name}";
          key = "  ";
          type = "os";
        }
        {
          format = "{release}";
          key = "  ";
          type = "kernel";
        }
        {
          format = "{all}";
          key = " 󰏖 ";
          type = "packages";
        }
        {
          format = "{pretty-name}";
          key = "  ";
          type = "wm";
        }
        {
          format = "{pretty-name}";
          key = "  ";
          type = "shell";
        }
        {
          format = "{pretty-name}";
          key = "  ";
          type = "terminal";
        }
        {
          format = "{name}";
          key = "  ";
          type = "cpu";
        }
        {
          format = "{1} {2}";
          key = " 󰊴 ";
          type = "gpu";
        }
        {
          format = "{1}/{2}";
          key = "  ";
          type = "memory";
        }
        {
          key = " 󰊴 ";
          type = "uptime";
        }
        {
          paddingLeft = 2;
          symbol = "circle";
          type = "colors";
        }
      ];
    };
  };
  home.shellAliases = {
    ff = "fastfetch";
  };
}
