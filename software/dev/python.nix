# uv was included in configuration.nix
# This file was deprecated, use https://github.com/the-nix-way/dev-templates instead
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    uv
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        pysocks
      ]))
  ];
}
