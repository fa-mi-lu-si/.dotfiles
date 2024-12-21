{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  programs.eww = {
    enable = true;
    configDir = ./config;
  };

  # TODO: make this autostart on hyprland
}
