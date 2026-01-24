{
  config,
  pkgs,
  lib,
  ...
}: let
  tongfang-mifs-wmi = config.boot.kernelPackages.callPackage ({
    stdenv,
    lib,
    kernel,
  }:
    stdenv.mkDerivation {
      pname = "tongfang-mifs-wmi";
      version = "local";

      src = /home/cubewhy/dev/projects/tongfang-mifs-wmi;

      nativeBuildInputs = kernel.moduleBuildDependencies;

      makeFlags =
        kernel.makeFlags
        ++ [
          "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
        ];

      buildPhase = ''
        make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$(pwd) modules
      '';

      installPhase = ''
        local dest=$out/lib/modules/${kernel.modDirVersion}/extra
        mkdir -p $dest
        cp tongfang-mifs-wmi.ko $dest/
      '';

      meta = with lib; {
        description = "Tongfang MIFS WMI driver";
        platforms = platforms.linux;
      };
    }) {};
in {
  boot.extraModulePackages = [tongfang-mifs-wmi];
  boot.kernelModules = ["tongfang-mifs-wmi"];
}
