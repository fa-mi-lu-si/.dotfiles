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

  services.blueman.enable = true;

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
    networkmanagerapplet
  ];
  services.printing.enable = true;

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = ["org.wezfurlong.wezterm.desktop"];
    };
  };

  fonts = {
    enableDefaultPackages = true;
  };
}
