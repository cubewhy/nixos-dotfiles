{ pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../desktop/kde-plasma.nix
      ../../drivers/nvidia.nix
      ../../drivers/amdgpu.nix
      ../../drivers/bluetooth.nix
    ];

  boot.loader = {
    systemd-boot = {
      consoleMode = "keep";
      extraInstallCommands = ''
        ${pkgs.gnused}/bin/sed -i '/^console-mode/d' /boot/loader/loader.conf

        echo "console-mode 8" >> /boot/loader/loader.conf
      '';
    };
  };

  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';

  services.udev.extraHwdb = ''
    evdev:input:*
     KEYBOARD_KEY_7009c=unknown
     KEYBOARD_KEY_700e8=unknown
  '';

  boot.kernelParams = [
    "amdgpu.dcdebugmask=0x10"
    "amdgpu.sg_display=0"
    "amdgpu.runpm=0"
  ];

  boot.kernelModules = [
    "usbmon"
    "tun"
  ];

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlays.default
  ];

  networking.hostName = "qby-laptop";

  networking.proxy.default = "http://127.0.0.1:7890";

  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "1";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };

  services.xserver = {
    dpi = 180;
  };


  users.users.cubewhy = {
    extraGroups = [ "networkmanager" "wheel" "docker" "wireshark" "libvirtd" ];
  };

  programs.wireshark = {
    enable = true;
    usbmon.enable = true;
    package = pkgs.wireshark;
  };

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    ollama
  ];

  services.ollama = {
    enable = false;
    acceleration = "cuda";
  };

  services.open-webui = {
    enable = false;
    port = 40080;
  };

  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "0001:0001:09b4e68d" ];
        settings = {
          main = {
            "leftshift+leftmeta+f23" = "rightcontrol";
          };
        };
      };
    };
  };

  services.mihomo = {
    enable = true;
    configFile = "/etc/mihomo/config.yaml"; 

    tunMode = true;
    webui = pkgs.metacubexd; 
  };

  networking.firewall = {
    trustedInterfaces = [ "mihomo" ];
  };

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
