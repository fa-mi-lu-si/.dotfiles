{...}: {
  home.shell.enableNushellIntegration = true;

  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    shellAliases = {
      l = "eza";
      ll = "ls -l";
      la = "ls -a";
      lt = "eza --tree";
      lla = "ls -l -a";
      man = "batman";
    };
  };
  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;

  programs.yazi.enableNushellIntegration = true;
  programs.starship.enableNushellIntegration = true;
  programs.zoxide.enableNushellIntegration = true;
  programs.direnv.enableNushellIntegration = true;
}
