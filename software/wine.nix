# Run `nix-shell -p winetricks --command winetricks`
# to get the workaround for Windows dependencies.
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
  ];
}
