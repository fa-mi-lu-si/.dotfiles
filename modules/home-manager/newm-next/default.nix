{pkgs, ...}: {
  # home.file.".config/newm/config.py".source = ./config.py;
  home.packages = with pkgs; [
    wob
  ];
}
