{
  description = "My Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/nix-community/nix-index-database
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-index-database,
    sops-nix,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      qby-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
          pkgs-unstable = pkgs-unstable;
        };

        modules = [
          ./configuration.nix
          ./hosts/qby-laptop/default.nix
          sops-nix.nixosModules.sops

          nix-index-database.nixosModules.default

          {
            disabledModules = ["services/misc/angrr.nix"];
          }
          "${nixpkgs-unstable}/nixos/modules/services/misc/angrr.nix"

          # Enable home-manager for my laptop
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.cubewhy = import ./home/cubewhy.nix;

            home-manager.extraSpecialArgs = {
              inherit inputs;

              pkgs-unstable = pkgs-unstable;
            };
          }
        ];
      };
    };
  };
}
