{
  description = "NixOS configuration for a Steam gaming machine";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    preservation.url = "github:nix-community/preservation";

    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
    jovian.inputs.nixpkgs.follows = "nixpkgs";
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
