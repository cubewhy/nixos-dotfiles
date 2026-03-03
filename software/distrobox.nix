{pkgs, ...}: {
  nixpkgs.overlays = [
    (import ../overlays/distrobox.nix)
  ];

  environment.systemPackages = [pkgs.distrobox];

  environment.sessionVariables = {
    DBX_CONTAINER_MANAGER = "docker";
  };

  environment.etc."distrobox/distrobox.conf".text = ''
    container_additional_volumes="/nix/store:/nix/store:ro /etc/profiles/per-user:/etc/profiles/per-user:ro /etc/static/profiles/per-user:/etc/static/profiles/per-user:ro"
  '';
}
