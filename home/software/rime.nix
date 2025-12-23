# Notes:
# This configuration fetches Rime configuration from
# https://github.com/wongdean/rime-settings/tree/508b0f373fd1a2475a8f531867550220193b30c5
{ pkgs, lib, ... }:

let
  rimeSettings = pkgs.fetchFromGitHub {
    owner = "wongdean";
    repo = "rime-settings";
    rev = "508b0f373fd1a2475a8f531867550220193b30c5";
    hash = "sha256-ZQlFAEnmbtASp/+l/9TEO0+Tys5nhAgYHNmBy6IpbmU="; 
  };
in
{
  home.packages = [ pkgs.rsync ];

  home.activation.installRimeSettings = lib.hm.dag.entryAfter ["writeBoundary"] ''
    TARGET_DIR="$HOME/.local/share/fcitx5/rime"
    mkdir -p "$TARGET_DIR"

    ${pkgs.rsync}/bin/rsync -av --chmod=u+w --exclude='.git' "${rimeSettings}/" "$TARGET_DIR/"

    echo "Rime configuration synchronized"
  '';
}
