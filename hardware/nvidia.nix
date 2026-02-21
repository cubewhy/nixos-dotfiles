{
  pkgs,
  lib,
  config,
  ...
}: {
  services.xserver.videoDrivers = [
    "nvidia"
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    open = true;
    nvidiaSettings = false;
    dynamicBoost.enable = lib.mkForce true;

    package = let
      base = config.boot.kernelPackages.nvidiaPackages.latest;
      cachyos-nvidia-patch = pkgs.fetchpatch {
        url = "https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/nvidia/nvidia-utils/kernel-6.19.patch";
        sha256 = "sha256-YuJjSUXE6jYSuZySYGnWSNG5sfVei7vvxDcHx3K+IN4=";
      };

      # Patch the appropriate driver based on config.hardware.nvidia.open
      driverAttr =
        if config.hardware.nvidia.open
        then "open"
        else "bin";
    in
      base
      // {
        ${driverAttr} = base.${driverAttr}.overrideAttrs (oldAttrs: {
          patches = (oldAttrs.patches or []) ++ [cachyos-nvidia-patch];
        });
      };
  };

  hardware.nvidia-container-toolkit.enable = true;

  services.ollama.package = pkgs.ollama-cuda;

  nix.settings = {
    substituters = [
      "https://cache.nixos-cuda.org"
    ];
    trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };
  nixpkgs.config.cudaSupport = true;
}
