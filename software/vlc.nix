{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.symlinkJoin {
      name = "vlc";
      paths = [pkgs.vlc];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/vlc \
          --unset DISPLAY

        rm $out/share/applications/vlc.desktop
        substitute "${pkgs.vlc}/share/applications/vlc.desktop" "$out/share/applications/vlc.desktop" \
          --replace "Exec=${pkgs.vlc}/bin/vlc" "Exec=$out/bin/vlc"
      '';
    })
  ];
}
