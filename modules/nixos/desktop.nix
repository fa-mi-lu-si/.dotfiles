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

  # Make removable storage work
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  hardware.bluetooth.enable = true;

  # enable the A2DP audio Sink
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };
  # Something the audio server needs
  security.rtkit.enable = true;
  services.blueman.enable = true;

  programs.seahorse.enable = true;

  # sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    wireplumber.extraConfig = {
      "10-bluez" = {
        "monitor.bluez.properties" = {
          # Disable Bluetooth speaker mode.
          # Keep only roles needed to use Bluetooth headsets.
          "bluez5.roles" = [
            "a2dp_source"
            "bap_source"
            "hfp_ag"
          ];
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    networkmanagerapplet
  ];
  services.printing.enable = true;

  fonts = {
    enableDefaultPackages = true;
  };
}
