{...}: {
  # no need anymore since the new linux-firmware was published
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     linux-firmware = prev.linux-firmware.overrideAttrs (oldAttrs: {
  #       postInstall =
  #         (oldAttrs.postInstall or "")
  #         + ''
  #           cp ${./amdgpu-firmware}/* $out/lib/firmware/amdgpu/
  #         '';
  #     });
  #   })
  # ];

  services.xserver.videoDrivers = [
    "amdgpu"
  ];
}
