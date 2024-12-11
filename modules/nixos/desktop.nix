{
  pkgs,
  inputs,
  config,
  ...
}: {
  # boot.plymouth.enable = true; # splash screen

  # media control
  services.playerctld.enable = true;

  # sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # packages
  environment.systemPackages = with pkgs; [
    brightnessctl # brightness
  ];

  programs.firefox.enable = true; # move to home manager
}
