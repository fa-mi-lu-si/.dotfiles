{...}: {
  nix.optimise = {
    automatic = true;
    persistent = true;
    dates = ["daily"];
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  }; # nix.gc = {
  #   automatic = true;
  #   options = "--delete-older-than 14d";
  # };
}
