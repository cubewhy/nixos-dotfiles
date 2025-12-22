{ pkgs, ... }:

{
  imports = [
    ./locale/zh-cn.nix

    ./software/neovim.nix
    ./software/nix-ld.nix
    ./software/fcitx5.nix
    ./software/docker.nix
    ./software/dev/python.nix
    ./software/dev/rust.nix
    ./software/dev/nodejs.nix

    ./software/fonts/coding-fonts.nix
  ];

  boot.loader = {
    systemd-boot = {
      enable = true;
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.variables = {
    LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.so";
  };

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  environment.systemPackages = with pkgs; [
    git
    wget
    dig
    wineWowPackages.yabridge

    net-tools
    psmisc
    htop-vim

    gnumake
    pkg-config
    cmake
    stdenv.cc.cc
    stdenv.cc.cc.lib
    buildPackages.stdenv.cc
    glibc

    unzip
    pciutils

    clang

    ripgrep
    fd
  ];

  users.users.cubewhy = {
    isNormalUser = true;
    description = "cubewhy";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    shell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
    noto-fonts
  ];

  fonts.fontconfig.useEmbeddedBitmaps = true;

  programs.mtr.enable = true;
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  nix.settings = {
    substituters = [ 
      "https://cache.nixos-cuda.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [ 
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  system.stateVersion = "25.11"; 
}
