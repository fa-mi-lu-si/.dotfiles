{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # newm = {
    #     url = "github:EpsilonKu/newm-atha";
    #     inputs.nixpkgs.follows = "nixpkgs";
    # };
    hyprland.url = "github:hyprwm/Hyprland";
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations.samy-nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/default/configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.stylix.nixosModules.stylix
      ];
    };
  };
}
