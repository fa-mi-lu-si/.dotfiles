{
  lib,
  pkgs,
  ...
}: {
  programs.swaylock = {
    enable = true;
  };
  services.swayidle = {
    enable = true;
    events = {
      "before-sleep" = "${lib.getExe pkgs.swaylock} -f";
      "lock" = "${lib.getExe pkgs.swaylock} -f";
    };
  };
}
