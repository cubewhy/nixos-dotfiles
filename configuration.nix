{pkgs, ...}: {
  imports = [
    ./locale/zh-cn.nix

    ./software/nix-ld.nix
    ./software/fcitx5.nix
    ./software/podman.nix
    ./software/direnv.nix
    # ./software/auto-gc.nix
    ./software/dev/python.nix

    ./software/fonts/coding-fonts.nix
    ./software/ccache.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.networkmanager.enable = true;

  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.nix-index-database.comma.enable = true;

  nixpkgs.overlays = [
    # (import ./overlays/jetbrains.nix)
    (import ./overlays/opencode.nix)
  ];

  boot.supportedFilesystems = ["ntfs"];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";

    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    secrets.git_email_config = {
      owner = "cubewhy";
    };
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    dig

    file

    net-tools
    psmisc
    htop-vim

    neovim

    libqalculate

    smartmontools
    pciutils

    uv

    ripgrep
    fd
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    inter
  ];

  fonts.fontconfig.useEmbeddedBitmaps = true;

  programs.mtr.enable = true;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };

  system.stateVersion = "25.11";
}
