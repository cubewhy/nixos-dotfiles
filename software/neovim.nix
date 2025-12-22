{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget

    ast-grep
    tree-sitter
    wayland-utils
    wl-clipboard
    lazygit
    fzf
    rustup

    lua51Packages.lua
    luajitPackages.luarocks

    gnumake
    pkg-config
    cmake
    stdenv.cc.cc
    stdenv.cc.cc.lib
    buildPackages.stdenv.cc
    glibc

    unzip

    (python3.withPackages (python-pkgs: with python-pkgs; [
      pysocks
    ]))

    sqlite
    clang

    nodejs
    ripgrep
    fd
  ];

  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlays.default
  ];

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
}
