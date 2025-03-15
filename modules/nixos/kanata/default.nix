{...}: {
  services.kanata = {
    enable = true;
    keyboards = {
      "laptop" = {
        config = builtins.readFile ./kanata.kbd;
        devices = ["/dev/input/by-path/platform-i8042-serio-0-event-kbd"];
      };
    };
  };
}
