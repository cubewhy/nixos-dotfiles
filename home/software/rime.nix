# Notes:
# This configuration fetches Rime configuration from
# https://github.com/cubewhy/rime-settings/tree/bd1d5044f0680571cb6d738140a480418e374f24
{ pkgs, lib, ... }:

let
  rimeSettings = pkgs.fetchFromGitHub {
    owner = "cubewhy";
    repo = "rime-settings";
    rev = "bd1d5044f0680571cb6d738140a480418e374f24";
    hash = "sha256-JCJc0mCFGxB332HUsL61XrcMN95nBKTNG/KFkfPvpt0=";
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
