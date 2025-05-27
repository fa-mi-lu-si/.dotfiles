{...}: {
  services.mpd = {
    enable = true;
  };
  services.mpd-mpris.enable = true;

  programs.rmpc = {
    enable = true;
  };
}
