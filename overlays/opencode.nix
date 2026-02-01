final: prev: {
  opencode =
    # REF: <https://github.com/NixOS/nixpkgs/issues/432051#issuecomment-3172569639>
    prev.opencode.overrideAttrs (o: {
      nativeBuildInputs = o.nativeBuildInputs or [] ++ [final.makeWrapper];
      postFixup = ''
        wrapProgram $out/bin/opencode \
          --set LD_LIBRARY_PATH "${final.stdenv.cc.cc.lib}/lib"
      '';
    });
}
