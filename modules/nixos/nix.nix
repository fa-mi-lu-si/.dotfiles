{...}: {
  nix.optimise = {
    automatic = true;
    persistent = true;
    dates = ["daily"];
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    builders-use-substitutes = true;
  };

  # nix.gc = {
  #   automatic = true;
  #   options = "--delete-older-than 14d";
  # };
}
