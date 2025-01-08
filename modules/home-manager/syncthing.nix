{...}: {
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        "phone" = {id = "Z3333AJ-D2F75MK-WL53VSO-BIZNTED-UF6636U-A736VZD-CMBR4IE-L22AAQ5";};
      };

      folders = {
        "Vault" = {
          path = "~/Vault";
          devices = ["phone"];
        };

        "Music" = {
          path = "~/Music";
          devices = ["phone"];
        };
      };
    };
  };
}
