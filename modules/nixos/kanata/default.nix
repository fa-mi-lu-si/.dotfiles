{...}: {
  services.kanata = {
    enable = true;
    keyboards = {
      "laptop" = {
        config = builtins.readFile ./kanata.kbd;
        extraDefCfg = "log-layer-changes no";
        devices = ["/dev/input/by-path/platform-i8042-serio-0-event-kbd"];
      };
      "MxMaster3s" = {
        config = builtins.readFile ./MxMaster3s.kbd;
        extraDefCfg = ''
          log-layer-changes no
          linux-dev-names-include ("Logitech MX Master 3S")
        '';
      };
    };
  };
}
