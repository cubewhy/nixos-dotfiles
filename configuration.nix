{ pkgs, ... }:

{
  imports = [
    ./locale/zh-cn.nix

    ./software/neovim.nix
    ./software/nix-ld.nix
    ./software/fcitx5.nix
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

    wayland-utils
    net-tools
    rustup
    uv
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

    (python3.withPackages (python-pkgs: with python-pkgs; [
      pysocks
    ]))

    sqlite
    clang

    nodejs
    pnpm
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
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
  fonts.fontconfig.useEmbeddedBitmaps = true;

  programs.mtr.enable = true;
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings.features.cdi = true;

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
