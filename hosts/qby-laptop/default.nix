{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../software/bootloader/systemd-boot.nix
    ../../users/cubewhy.nix

    ../../desktop/kde-plasma.nix

    ../../software/proxy/mihomo/default.nix
    ../../software/wireshark.nix
    ../../software/steam.nix
    ../../software/heroic-games-launcher.nix
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

    # ./dev-kernel.nix
    ./dev-kernel-mods.nix
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

  boot.kernel.sysctl = {
    "kernel.core_pattern" = "/dev/null";
  };

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "hard";
      item = "core";
      value = "0";
    }
    {
      domain = "*";
      type = "soft";
      item = "core";
      value = "0";
    }
  ];

  environment.sessionVariables = {
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2 -Dglass.gtk.uiScale=192dpi";
  };

  boot.kernelParams = [
    "quiet"
    "splash"
    "amd_iommu=on"
    "iommu=pt"
    "amdgpu.dcdebugmask=0x10"
  ];

  boot.plymouth = {
    enable = true;
  };

  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  boot.blacklistedKernelModules = [
    "redmi-wmi"
  ];

  # boot.extraModulePackages = with config.boot.kernelPackages; [
  #   acpi_call
  # ];

  # boot.kernelModules = ["acpi_call"];

  boot.tmp.useTmpfs = true;

  systemd.services.NetworkManager-wait-online.enable = false;
  networking.networkmanager.wifi.powersave = false;

  programs.firejail.enable = true;

  networking.hostName = "qby-laptop";

  hardware.nvidia = {
    powerManagement.enable = lib.mkForce false;
    powerManagement.finegrained = lib.mkForce false;
    prime = {
      sync.enable = true;
      # reverseSync.enable = true;
      # allowExternalGpu = false;

      # offload = {
      #   enable = true;
      #   enableOffloadCmd = true;
      # };

      nvidiaBusId = "PCI:01:00:0";
      amdgpuBusId = "PCI:06:00:0";
    };
  };

  environment.sessionVariables = {
    KWIN_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card2";
  };
}
