# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default

    ../../modules/nixos/nix.nix
    ../../modules/nixos/sops.nix
    ../../modules/nixos/kde-connect.nix
    ../../modules/nixos/newm-next.nix
    ../../modules/nixos/niri.nix
    ../../modules/nixos/swaylock.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/nix-ld.nix
    ../../modules/nixos/probe-rs
    ../../modules/nixos/syncthing.nix
    ../../modules/nixos/stylix.nix
    ../../modules/nixos/kanata
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # use the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-0b6c3343-110b-4bf3-b393-a4589d300f07".device = "/dev/disk/by-uuid/0b6c3343-110b-4bf3-b393-a4589d300f07";
  networking.hostName = "samy-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  hardware.bluetooth.enable = true;
  # enable the A2DP audio Sink
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  # Make removable storage work
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true; # powersave on wifi

  # Something the audio server needs
  security.rtkit.enable = true;

  # laptop stuff
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
  services.thermald.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Harare";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_ZW.UTF-8";
    LC_IDENTIFICATION = "en_ZW.UTF-8";
    LC_MEASUREMENT = "en_ZW.UTF-8";
    LC_MONETARY = "en_ZW.UTF-8";
    LC_NAME = "en_ZW.UTF-8";
    LC_NUMERIC = "en_ZW.UTF-8";
    LC_PAPER = "en_ZW.UTF-8";
    LC_TELEPHONE = "en_ZW.UTF-8";
    LC_TIME = "en_ZW.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # TODO: set users.mutableUsers to false
  users.users.samy = {
    isNormalUser = true;
    description = "samy";
    extraGroups = ["networkmanager" "wheel" "video" "audio" "sound" "dialout" "input"];
    # packages = with pkgs; [
    # ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "samy" = import ./home.nix;
    };
    useGlobalPkgs = true;
    backupFileExtension = "hm-backup";
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "samy";
  services.getty.autologinOnce = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  # ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
