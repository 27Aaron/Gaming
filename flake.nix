{
  description = "NixOS configuration for a Steam gaming machine";

  inputs = {
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
    jovian.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    preservation.url = "github:nix-community/preservation";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations.steam-machine = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/steam-machine/configuration.nix
          inputs.disko.nixosModules.default
          inputs.jovian.nixosModules.default
          inputs.preservation.nixosModules.default
        ];
      };
    };
}
