{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
  };
}
