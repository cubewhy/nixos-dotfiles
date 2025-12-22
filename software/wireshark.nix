{ pkgs, ... }:

{
  boot.kernelModules = [
    "usbmon"
  ];

  users.users.cubewhy = {
    extraGroups = [ "wireshark" ];
  };

  programs.wireshark = {
    enable = true;
    usbmon.enable = true;
    package = pkgs.wireshark;
  };
}
