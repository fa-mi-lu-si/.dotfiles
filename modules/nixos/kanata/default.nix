{
  pkgs,
  inputs,
  config,
  ...
}: {
  # environment.systemPackages = with pkgs; [];
  services.kanata = {
    enable = true;
    keyboards = {
      "laptop".configFile = ./kanata.kbd;
    };
  };
}
