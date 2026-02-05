{pkgs ? import <nixpkgs> {}}: let
  kernel = pkgs.linuxPackages_zen.kernel;
in
  pkgs.mkShell {
    nativeBuildInputs = kernel.moduleBuildDependencies;

    shellHook = ''
      export KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build
      echo "Kernel headers found in $KDIR"
    '';
  }
