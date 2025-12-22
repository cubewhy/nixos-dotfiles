{ pkgs, ... }:

{
  boot.kernelModules = [
    "usbmon"
  ];

  programs.wireshark = {
    enable = true;
    usbmon.enable = true;
    package = pkgs.wireshark;
  };
}
