{...}: {
  nix.optimise = {
    automatic = true;
    persistent = true;
    dates = ["daily"];
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    builders-use-substitutes = true;
    extra-substituters = [
      "https://anyrun.cachix.org"
    ];

    extra-trusted-public-keys = [
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };

  # nix.gc = {
  #   automatic = true;
  #   options = "--delete-older-than 14d";
  # };
}
