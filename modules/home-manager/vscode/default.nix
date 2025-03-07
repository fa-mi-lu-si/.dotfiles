{
  lib,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [nixd alejandra markdown-oxide]);
    profiles.default = {
      userSettings = lib.mkForce {};
    };
  };
}
