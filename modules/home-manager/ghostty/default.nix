{...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      mouse-hide-while-typing = true;
      command = "nu";
    };
  };
}
