{inputs, ...}: {
  imports = [inputs.zen-browser.homeModules.beta];
  programs.zen-browser = {
    enable = true;
    profiles."default" = {
      name = "samy";
      isDefault = true;
    };
  };
  stylix.targets.zen-browser.profileNames = ["default"];
}
