# Deprecared
# Use
# nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#rust"
# instead
# Notes:
# I recommend you to add flake.nix into your project.
# So we just only install rustup there.
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    rustup
  ];
}
