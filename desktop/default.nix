{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
  };

  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  security.rtkit.enable = true;

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
