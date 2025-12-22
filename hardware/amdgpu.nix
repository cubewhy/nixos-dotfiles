{ ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      linux-firmware = prev.linux-firmware.overrideAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
          cp ${./amdgpu-firmware}/* $out/lib/firmware/amdgpu/
        '';
      });
    })
  ];

  services.xserver.videoDrivers = [
    "amdgpu"
  ];
}
