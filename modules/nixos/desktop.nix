{
  pkgs,
  # inputs,
  # config,
  ...
}: {
  # boot.plymouth.enable = true; # splash screen
  services.upower = {
    enable = true;
    criticalPowerAction = "Hibernate";
    percentageLow = 30;
  };

  hardware.graphics.enable = true;

  services.blueman.enable = true;

  programs.seahorse.enable = true;

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

  fonts = {
    enableDefaultPackages = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "niri-session";
        user = "samy";
      };
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --greeting 'Welcome To NixOS' --asterisks --remember --remember-user-session --time -cmd niri-session";
        # DO NOT CHANGE THIS USER
        user = "greeter";
      };
    };
  };
  security.pam.services.greetd.enableGnomeKeyring = true;
}
