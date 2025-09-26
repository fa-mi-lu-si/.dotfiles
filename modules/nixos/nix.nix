{...}: {
  nix.optimise = {
    automatic = true;
    persistent = true;
    dates = ["daily"];
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    builders-use-substitutes = true;

    extra-substituters = ["https://vicinae.cachix.org"];
    extra-trusted-public-keys = ["vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="];
  };

  # nix.gc = {
  #   automatic = true;
  #   options = "--delete-older-than 14d";
  # };
}
