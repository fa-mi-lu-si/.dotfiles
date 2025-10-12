{...}: {
  services.syncthing = {
    enable = true;
    user = "samy";
    group = "users";
    dataDir = "/home/samy";
    openDefaultPorts = true;
    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        "samy-nix-hand" = {id = "TNZDXGR-BAXWRQG-36PTCRU-RGBYRQD-RPGL5FD-EA2IB2K-UNBRUOE-TYIYDQ5";};
      };

      folders = {
        "Vault" = {
          path = "~/Vault";
          devices = ["samy-nix-hand"];
        };

        "Music" = {
          path = "~/Music";
          devices = ["samy-nix-hand"];
        };
      };
    };
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
}
