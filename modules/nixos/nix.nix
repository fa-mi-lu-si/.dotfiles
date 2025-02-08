{...}: {
  nix.settings.auto-optimise-store = true;
  # nix.gc = {
  #   automatic = true;
  #   options = "--delete-older-than 14d";
  # };
}
