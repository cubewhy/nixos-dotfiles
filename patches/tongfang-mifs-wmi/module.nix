{
  stdenv,
  lib,
  kernel,
}:
stdenv.mkDerivation {
  name = "tongfang-mifs-wmi-${kernel.version}";

  src = "./";

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags =
    kernel.makeFlags
    ++ [
      "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    ];

  installPhase = ''
    install -D tongfang-mifs-wmi.ko $out/lib/modules/${kernel.modDirVersion}/extra/my-module.ko
  '';

  meta = with lib; {
    description = "tongfang-mifs-wmi kernel mod";
    license = licenses.gpl2;
  };
}
