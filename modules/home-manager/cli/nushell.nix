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

    # Get the environment variables from home manager
    environmentVariables = config.home.sessionVariables;
  };

  programs.yazi.enableNushellIntegration = true;
  programs.starship.enableNushellIntegration = true;
  programs.zoxide.enableNushellIntegration = true;
  programs.direnv.enableNushellIntegration = true;
}
