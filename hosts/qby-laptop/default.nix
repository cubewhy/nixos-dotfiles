{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../software/bootloader/systemd-boot.nix
    ../../users/cubewhy.nix

    ../../desktop/kde-plasma.nix

    ../../software/proxy/mihomo/default.nix
    ../../software/wireshark.nix
    ../../software/steam.nix
    ../../software/wine.nix
    ../../software/kvm.nix
    ../../software/looking-glass.nix
    ../../software/distrobox.nix
    ../../software/reverse-engineering.nix
    ../../software/ai/ollama.nix

    ../../hardware/nvidia.nix
    ../../hardware/amdgpu.nix
    ../../hardware/bluetooth.nix
    ../../hardware/apple-keyboard.nix
    ../../hardware/remap-copilot.nix

    ../../software/vlc.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.loader = {
    systemd-boot = {
      consoleMode = "keep";
      extraInstallCommands = ''
        ${pkgs.gnused}/bin/sed -i '/^console-mode/d' /boot/loader/loader.conf

        echo "console-mode 8" >> /boot/loader/loader.conf
      '';
    };
  };

  systemd.coredump.enable = false;

  environment.sessionVariables = {
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2 -Dglass.gtk.uiScale=192dpi";
  };

  boot.kernelParams = [
    "amdgpu.dcdebugmask=0x10"
  ];

  systemd.services.NetworkManager-wait-online.enable = false;
  networking.networkmanager.wifi.powersave = false;

  programs.firejail.enable = true;

  networking.hostName = "qby-laptop";

  hardware.nvidia = {
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      nvidiaBusId = "PCI:01:00:0";
      amdgpuBusId = "PCI:06:00:0";
    };
  };
}
