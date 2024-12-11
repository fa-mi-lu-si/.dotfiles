{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;

    # temporary fix till home manager can set these automatically
    environmentVariables = {
      DIRENV_LOG_FORMAT = "";
      FLAKE = "/home/samy/.dotfiles";
    };
    
  };
  
  programs.yazi.enableNushellIntegration = true;
  programs.starship.enableNushellIntegration = true;
  programs.zoxide.enableNushellIntegration = true;
  programs.direnv.enableNushellIntegration = true;
}
