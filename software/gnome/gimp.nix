{pkgs, ...}: {
  imports = [
    ./default.nix
  ];

  environment.systemPackages = with pkgs; [
    gimp-with-plugins
  ];
}
