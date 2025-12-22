# This script auto clones my lazyvim dotfiles into ~/.config/nvim
# https://github.com/cubewhy/.lazyvim
# Make sure you have nvim installed

# Notes:
# You should always run `git pull` to update the LazyVim dotfiles manually.
# Call `git pull` inside .nix is not a good practice.
{ pkgs, config, lib, ... }:

{
  home.activation.installLazyVim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    NVIM_CONFIG="${config.home.homeDirectory}/.config/nvim"
    REPO_URL="https://github.com/cubewhy/.lazyvim"

    if [ ! -d "$NVIM_CONFIG" ]; then
      ${pkgs.git}/bin/git clone "$REPO_URL" "$NVIM_CONFIG"
    elif [ -z "$(ls -A "$NVIM_CONFIG")" ]; then
      ${pkgs.git}/bin/git clone "$REPO_URL" "$NVIM_CONFIG"
    fi
  '';
}
