{...}: {
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        shell = "nu";
        pad = "24x24";
      };
    };
  };
}
