{pkgs, ...}: {
  users.users.cubewhy = {
    isNormalUser = true;
    description = "cubewhy";
    extraGroups = ["networkmanager" "wheel" "docker" "kvm" "libvirtd" "wireshark" "podman"];
    shell = pkgs.zsh;
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="kvmfr", OWNER="cubewhy", GROUP="kvm", MODE="0660"
  '';
}
