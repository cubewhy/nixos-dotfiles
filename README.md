# cubewhy's NixOS Configuration

Only for personal usage.

DO NOT USE THIS DIRECTLY ON YOUR MACHINE.

## Apply configuration

```shell
nix flake update
sudo nixos-rebuild switch --flake .#<machine-name>
```
