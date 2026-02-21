{pkgs, ...}: {
  imports = [
    ./default.nix
  ];

  services.displayManager.plasma-login-manager.enable = true;
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
    kdiff3
    kdePackages.partitionmanager
    kdePackages.kcolorchooser
    kdePackages.kclock
    kdePackages.kate
    kdePackages.kcalc
    kdePackages.ksystemlog
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.kcharselect
    kdePackages.plasma-browser-integration
    kdePackages.sddm-kcm
    kdePackages.kdialog
    kdePackages.filelight
    kdePackages.kfind

    # Spectacle deps
    (pkgs.kdePackages.spectacle.override
      {tesseractLanguages = ["eng" "chi_sim" "chi_tra"];})

    # Ark dependencies
    rar
    p7zip
    arj

    kdePackages.ksshaskpass
  ];

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.discover
  ];

  programs.gnupg.agent = {
    pinentryPackage = pkgs.pinentry-qt;
  };

  environment.sessionVariables = {
    PINENTRY_KDE_USE_WALLET = "1";
    SSH_ASKPASS = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
    SSH_ASKPASS_REQUIRE = "prefer";
  };

  systemd.user.services.gpg-agent.environment = {
    PINENTRY_KDE_USE_WALLET = "1";
  };
}
