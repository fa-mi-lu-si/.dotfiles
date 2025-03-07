{...}: {
  nix.settings.auto-optimise-store = true;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  }; # nix.gc = {
  #   automatic = true;
  #   options = "--delete-older-than 14d";
  # };
}
