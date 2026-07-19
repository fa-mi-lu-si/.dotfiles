{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nix-index-database.homeModules.default];
  # use comma to automatically nix shell with the correct package
  programs.nix-index-database.comma.enable = true;
  programs.nix-index.package = inputs.nix-index-database.packages.${pkgs.stdenv.hostPlatform.system}.nix-index-with-small-db;

  # Install nix your shell
  programs.nix-your-shell = {
    enable = true;
    nix-output-monitor.enable = true;
  };
}
