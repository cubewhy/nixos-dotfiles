# https://github.com/NixOS/nixpkgs/blob/nixos-25.11/pkgs/applications/editors/jetbrains/default.nix
final: prev: {
  jetbrains =
    prev.jetbrains
    // {
      # --- IntelliJ IDEA Ultimate ---
      idea = prev.jetbrains.idea.overrideAttrs (old: rec {
        version = "2025.3.1";
        src = final.fetchurl {
          url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
          sha256 = "sha256-IeG5C17GhHZ6A0mLpCTvP5rMXb91nM7v1e3UdPBDrWw=";
        };
      });
    };
}
