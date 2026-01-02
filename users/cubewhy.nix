{pkgs, ...}: {
  users.users.cubewhy = {
    isNormalUser = true;
    description = "cubewhy";
    extraGroups = ["networkmanager" "wheel" "docker" "kvm" "libvirtd" "wireshark" "podman"];
    shell = pkgs.zsh;
  };
}
