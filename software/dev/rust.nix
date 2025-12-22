# Notes:
# I recommend you to add flake.nix into your project.
# So we just only install rustup there.
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rustup
  ];
}
