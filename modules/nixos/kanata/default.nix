{...}: {
  services.kanata = {
    enable = true;
    keyboards = {
      "laptop".configFile = ./kanata.kbd;
    };
  };
}
