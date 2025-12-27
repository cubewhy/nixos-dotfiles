# Deprecared
# Use
# nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#rust"
# instead
# If you want nightly or old versions, you may need rust-overlay
# https://github.com/oxalica/rust-overlay
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    rustup
  ];
}
