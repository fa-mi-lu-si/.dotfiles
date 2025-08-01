{...}: {
  programs.firefox = {
    enable = true;
    profiles."default" = {
      name = "samy";
      isDefault = true;
      userChrome = builtins.readFile ./userChrome.css;
    };
  };
  stylix.targets.firefox.profileNames = ["default"];
}
