{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [nixd alejandra markdown-oxide]);
    userSettings = lib.mkForce {};
  };
}
