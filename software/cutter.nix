{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (cutter.withPlugins (ps: with ps; [jsdec rz-ghidra sigdb]))

    # Uncomment this line if you want to use rizin
    # (rizin.withPlugins (ps: with ps; [jsdec rz-ghidra sigdb]))
  ];
}
