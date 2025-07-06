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
      default = ["foot.desktop"];
    };
  };

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
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting 'Welcome To NixOS' --asterisks --remember --remember-user-session --time -cmd niri-session";
        # DO NOT CHANGE THIS USER
        user = "greeter";
      };
    };
  };
}
