{config, ...}: {
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    shellAliases = {
      l = "eza";
      ll = "ls -l";
      la = "ls -a";
      lt = "eza --tree";
      lla = "ls -l -a";
      bg = "batgrep";
      man = "batman";
    };

    # Get the environment variables from home manager
    environmentVariables = config.home.sessionVariables;
  };
  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;

  programs.yazi.enableNushellIntegration = true;
  programs.starship.enableNushellIntegration = true;
  programs.zoxide.enableNushellIntegration = true;
  programs.direnv.enableNushellIntegration = true;
}
