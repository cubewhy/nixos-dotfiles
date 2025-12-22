{ pkgs, ... }:

{
  users.users.cubewhy = {
    isNormalUser = true;
    description = "cubewhy";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "wireshark" ];
    shell = pkgs.zsh;
  };
}
