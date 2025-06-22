{
  lib,
  pkgs,
  ...
}: {
  security.pam.services.swaylock.text = ''
    auth include login
  '';

  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    lidSwitchDocked = "suspend";
    lidSwitchExternalPower = "lock";
    powerKey = "hibernate";
  };
  systemd.sleep.extraConfig = "HibernateDelaySec=30m";
}
