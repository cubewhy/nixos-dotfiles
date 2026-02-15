{
  pkgs,
  pkgs-unstable,
  ...
}: let
  ghidraScripts = pkgs.stdenv.mkDerivation {
    name = "ghidra-scripts-pack";
    src = ./ghidra/scripts;
    installPhase = ''
      mkdir -p $out/ghidra_scripts
      cp -r * $out/ghidra_scripts/
    '';
  };
in {
  environment.systemPackages = with pkgs; [
    radare2
    ltrace
    bintools
    checksec
    strace
    hexdump
    xxd

    (pkgs-unstable.ghidra.withExtensions (p:
      with p; [
        ret-sync
        findcrypt
        ghidra-firmware-utils
        kaiju
        # ghidraScripts
      ]))
  ];
}
