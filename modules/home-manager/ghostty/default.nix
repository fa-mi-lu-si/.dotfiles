{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    settings = {
      mouse-hide-while-typing = true;
      command = "nu";
    };
  };
}
