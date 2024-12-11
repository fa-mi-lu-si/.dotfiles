{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./anyrun.nix
  ];

  home.packages = with pkgs; [
    dunst
    libnotify

    nautilus
    obsidian

    mpv
    celluloid
    amberol

    foliate
    iagno
  ];

  # media buttons for bluetoth devices
  services.mpris-proxy.enable = true;

  programs.zathura.enable = true;
}
