{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (cutter.withPlugins (ps: with ps; [jsdec rz-ghidra sigdb]))

    (rizin.withPlugins (ps: with ps; [jsdec rz-ghidra sigdb]))

    radare2
    ghidra
    ltrace
    bintools
    checksec
    strace
    hexdump
    xxd
  ];
}
