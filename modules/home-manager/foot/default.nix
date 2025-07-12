{...}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        shell = "nu";
        pad = "24x24";
      };
    };
  };
}
