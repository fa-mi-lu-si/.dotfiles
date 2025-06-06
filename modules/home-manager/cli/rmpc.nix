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
  };
}
