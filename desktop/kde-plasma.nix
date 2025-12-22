{ pkgs, ... }:

{
  imports = [
    ./default.nix
  ];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.kcharselect
    kdePackages.plasma-browser-integration
    kdePackages.sddm-kcm
    kdePackages.kdialog

    pinentry-qt
  ];
}
