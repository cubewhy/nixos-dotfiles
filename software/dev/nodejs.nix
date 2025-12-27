# Deprecared
# Use
# nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#node"
# instead
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nodejs
    pnpm
  ];
}
