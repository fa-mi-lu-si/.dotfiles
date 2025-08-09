{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      display = {separator = " - ";};
      logo = {
        padding = {right = 1;};
        source = "none";
      };
      modules = [
        {
          format = " {#1}{user-name}{#}@{#2}{host-name}{#}";
          type = "title";
        }
        {
          format = "{2}";
          key = "  ";
          type = "os";
        }
        {
          format = "{2}";
          key = "  ";
          type = "kernel";
        }
        {
          format = "{1}";
          key = " 󰏖 ";
          type = "packages";
        }
        {
          format = "{1}";
          key = "  ";
          type = "wm";
        }
        {
          format = "{6}";
          key = "  ";
          type = "shell";
        }
        {
          format = "{5}";
          key = "  ";
          type = "terminal";
        }
        {
          paddingLeft = 2;
          symbol = "circle";
          type = "colors";
        }
      ];
    };
  };
}
