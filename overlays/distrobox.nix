final: prev: {
  distrobox = prev.distrobox.overrideAttrs (oldAttrs: {
    src = final.fetchFromGitHub {
      owner = "cubewhy";
      repo = "distrobox";
      rev = "06314c23936f3197d1300325896978818bd4b96e";
      sha256 = "sha256-UfXMxTMmzD2Tx8lf5wtN87NMVnVkux05FMX3FSh1OAs=";
    };
  });
}
