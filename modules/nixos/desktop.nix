{
  pkgs,
  # inputs,
  # config,
  ...
}: {
  # boot.plymouth.enable = true; # splash screen

  # media control
  services.playerctld.enable = true;
  hardware.graphics.enable = true;

  # sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
  services.printing.enable = true;

  programs.firefox.enable = true; # TODO: move to home manager
}
