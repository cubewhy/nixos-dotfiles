# cubewhy's NixOS Configuration

Only for personal usage.

DO NOT USE THIS DIRECTLY ON YOUR MACHINE.

## Apply configuration

```shell
git clone https://github.com/cubewhy/nixos-dotfiles ~/nixos-dotfiles
cd ~/nixos-dotfiles
nix flake update
sudo nixos-rebuild switch --flake .#<machine-name>
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
  # Your CPU arch
  system = "x86_64-linux";

  specialArgs = { inherit inputs; };

  modules = [
    ./configuration.nix
    ./hosts/<machine-name>/default.nix

    # Remove this selection if you don't need home-manager
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      home-manager.users.<username> = import ./home/<username>.nix;

      home-manager.extraSpecialArgs = { inherit inputs; };
    }
  ];
};
```

You may need to specific your kernel package inside your device specific
configuration file, otherwise the LTS kernel will be used.

[Linux Kernel at nixos.wiki](https://nixos.wiki/wiki/Linux_kernel)

```nix
boot.kernelPackages = pkgs.linuxPackages_<kernel_version>;
```
