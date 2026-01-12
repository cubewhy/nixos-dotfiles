{pkgs, ...}: {
  imports = [
    ./default.nix
  ];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  programs.kdeconnect.enable = true;

  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  environment.systemPackages = with pkgs; [
    kdePackages.kio # needed since 25.11
    kdePackages.kio-fuse #to mount remote filesystems via FUSE
    kdePackages.kio-extras #extra protocols support (sftp, fish and more)
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.kcharselect
    kdePackages.plasma-browser-integration
    kdePackages.sddm-kcm
    kdePackages.kdialog
    kdePackages.filelight
    kdePackages.kfind

    # Ark dependencies
    rar
    p7zip
    arj
  ];

  programs.gnupg.agent = {
    pinentryPackage = pkgs.pinentry-qt;
  };

  environment.sessionVariables = {
    PINENTRY_KDE_USE_WALLET = "1";
  };

  systemd.user.services.gpg-agent.environment = {
    PINENTRY_KDE_USE_WALLET = "1";
  };
}
