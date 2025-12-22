{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
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
    (final: prev: {
      linux-firmware = prev.linux-firmware.overrideAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
          cp ${../../amdgpu}/* $out/lib/firmware/amdgpu/
        '';
      });
    })
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

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  users.users.cubewhy = {
    extraGroups = [ "networkmanager" "wheel" "docker" "wireshark" "libvirtd" ];
  };

  programs.kdeconnect.enable = true;
  programs.wireshark = {
    enable = true;
    usbmon.enable = true;
    package = pkgs.wireshark;
  };

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    dig
    wineWowPackages.yabridge
    wget
    git

    ast-grep
    tree-sitter
    kdePackages.kcharselect
    kdePackages.plasma-browser-integration
    kdePackages.sddm-kcm
    kdePackages.kdialog
    wayland-utils
    wl-clipboard
    net-tools
    lazygit
    neovide
    fzf
    rustup
    uv
    psmisc
    htop-vim

    lua51Packages.lua
    luajitPackages.luarocks

    gnumake
    pkg-config
    cmake
    stdenv.cc.cc
    stdenv.cc.cc.lib
    buildPackages.stdenv.cc
    glibc

    unzip
    pciutils

    (python3.withPackages (python-pkgs: with python-pkgs; [
      pysocks
      pylatexenc
    ]))

    pinentry-qt
    sqlite

    nodejs
    pnpm
    rocmPackages.llvm.clang-unwrapped
    ripgrep
    fd
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

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [
    "nvidia"
    "amdgpu"
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      nvidiaBusId = "PCI:01:00:0";
      amdgpuBusId = "PCI:06:00:0";
    };

    open = true;
    nvidiaSettings = false;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.nvidia-container-toolkit.enable = true;
}
