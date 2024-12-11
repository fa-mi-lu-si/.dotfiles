{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    userSettings = lib.mkForce {};
  };
}
