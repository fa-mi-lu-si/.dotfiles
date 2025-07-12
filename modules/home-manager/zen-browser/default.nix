{
  config,
  inputs,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.beta];
  programs.zen-browser = {
    enable = true;
    profiles."default" = {
      name = "samy";
      isDefault = true;
      userChrome = (import ./userChrome.nix {inherit config;}).css;
      userContent = (import ./userContent.nix {inherit config;}).css;
    };
  };
}
