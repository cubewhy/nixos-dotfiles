# cubewhy's NixOS Configuration

Only for personal usage.

DO NOT USE THIS DIRECTLY ON YOUR MACHINE.

## Apply configuration

```shell
git clone https://github.com/cubewhy/nixos-dotfiles ~/nixos-dotfiles
cd ~/nixos-dotfiles
nix flake update
nixos-rebuild switch --flake .#<machine-name> --sudo
```

If you want to add your modifications to this repo, it's recommended to delete
the git root and add your own or create a fork on GitHub.

Alternatively, if you are prefer [nh](https://github.com/nix-community/nh):

```shell
nh os switch . --hostname qby-laptop
```

## Add your Machine

- Create new `<machine-name>/default.nix` file in the `hosts/` folder
- Create new `<username>.nix` file in the `home/` folder if you need home-manager
- Copy `hardware-configuration.nix` from `/etc/nixos`
  (make sure import it at `default.nix` you create from the last step,
  otherwise your computer won't start)
- Add imports for your favorite packages
- Modify the `nixosConfigurations` inside `flake.nix` with this format

```nix
# Replace `<machine-name>` and `<username>` with your values
<machine-name> = nixpkgs.lib.nixosSystem {
  # Your platform
  system = "x86_64-linux";

  specialArgs = { inherit inputs; };

  modules = [
    ./configuration.nix
    ./hosts/<machine-name>/default.nix

    # Remove this selection if you don't need home-manager
    # -hm selection start-
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      home-manager.users.<username> = import ./home/<username>.nix;
      # you can add other users there using this pattern
      # home-manager.users.<username> = import ./home/<username>.nix;

      home-manager.extraSpecialArgs = { inherit inputs; };
    }
    # -hm selection end-
  ];
};
```

You may need to specific your kernel package inside your device specific
configuration file, otherwise the LTS kernel will be used.

[Linux Kernel at nixos.wiki](https://nixos.wiki/wiki/Linux_kernel)

```nix
boot.kernelPackages = pkgs.linuxPackages_<kernel_version>;
```

## License

The dotfiles are licensed under [MIT](LICENSE).

Patches under the `patches/` folder are licensed under [GPLv2](LICENSE-GPLv2).
