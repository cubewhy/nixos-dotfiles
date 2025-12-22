{ inputs, ... }:

{
  home-manager.nixosModules.home-manager = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    # Define your users here
    home-manager.users.cubewhy = import ./cubewhy.nix;

    home-manager.extraSpecialArgs = { inherit inputs; };
  };
}
