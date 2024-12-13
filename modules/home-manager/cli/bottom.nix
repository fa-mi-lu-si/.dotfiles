{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.bottom = {
    enable = true;
    settings = {
      flags = {
        color = "default";
        battery = true;
        show_table_scroll_position = false;
        tree = false;
      };

      # Custom layout
      row = [
        {
          child = [
            {
              type = "disk";
              ratio = 2;
            }
            {
              type = "batt";
            }
          ];
          ratio = 15;
        }
        {
          child = [
            {
              type = "cpu";
              ratio = 3;
            }
            {
              default = true;
              type = "proc";
              ratio = 2;
            }
          ];
          ratio = 30;
        }
        {
          child = [
            {
              type = "mem";
              ratio = 2;
            }
            {
              child = [
                {
                  type = "net";
                  ratio = 3;
                }
                {
                  type = "temp";
                  ratio = 3;
                }
              ];
              ratio = 1;
            }
          ];
          ratio = 30;
        }
      ];
    };
  };
}
