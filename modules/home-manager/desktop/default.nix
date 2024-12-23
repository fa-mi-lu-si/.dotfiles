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
    eartag
  ];

  home.sessionVariables = {
    SWWW_TRANSITION = "center";
  };

  # gtk.iconTheme = {
  #   name = "Adwaita";
  #   package = pkgs.adwaita-icon-theme;
  # };

  # media buttons for bluetoth devices
  services.mpris-proxy.enable = true;

  programs.zathura.enable = true;
}
