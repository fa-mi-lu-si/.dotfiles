{
  lib,
  pkgs,
  ...
}: {
  security.pam.services.swaylock.text = ''
    auth include login
  '';

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchDocked = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "lock";
    HandlePowerKey = "hibernate";
  };
  systemd.sleep.extraConfig = "HibernateDelaySec=30m";
}
