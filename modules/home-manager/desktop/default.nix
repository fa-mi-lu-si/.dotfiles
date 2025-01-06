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
    scrcpy
    inputs.zen-browser.packages."${system}".default

    nautilus
    obsidian

    celluloid
    amberol

    foliate
    iagno
    eartag
  ];

  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      mpris
      sponsorblock
    ];
  };

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
