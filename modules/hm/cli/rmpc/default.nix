{...}: {
  services.mpd = {
    enable = true;
    network.startWhenNeeded = true;
    extraConfig = ''
       audio_output {
        type "pipewire"
        name "Pipewire Output"
      }
    '';
  };
  services.mpd-mpris.enable = true;

  programs.rmpc = {
    enable = true;
    config = builtins.readFile ./config.ron;
  };

  xdg.configFile."rmpc/themes".source = ./themes;

  xdg.desktopEntries."rmpc" = {
    name = "rmpc";
    exec = "rmpc";
    comment = "Rusty Music Player Client";
    terminal = true;
  };
}
