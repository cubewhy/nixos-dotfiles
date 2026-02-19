# Run `nix-shell -p winetricks --command winetricks`
# to get the workaround for Windows dependencies.
{pkgs-stable, ...}: {
  environment.systemPackages = with pkgs-stable; [
    wineWowPackages.stableFull
  ];
}
