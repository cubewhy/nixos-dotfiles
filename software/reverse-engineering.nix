{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    radare2
    # ghidra
    ltrace
    bintools
    checksec
    strace
    hexdump
    xxd
  ];
}
