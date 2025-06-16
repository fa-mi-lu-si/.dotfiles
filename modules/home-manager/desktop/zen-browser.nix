{inputs, ...}: {
  imports = [inputs.zen-browser.homeModules.beta];
  programs.zen-browser = {
    enable = true;
  };
  # TODO: use home.file for the userchrome and template stylix colours
}
