{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nix-index-database.homeModules.nix-index];
  # use comma to automatically nix shell with the correct package
  programs.nix-index-database.comma.enable = true;

  home.packages = [pkgs.nix-your-shell];
  xdg.configFile."nushell/nix-your-shell.nu".source = pkgs.nix-your-shell.generate-config "nu";
  programs.nushell.extraConfig =
    #nu
    ''
      source nix-your-shell.nu
    '';
}
