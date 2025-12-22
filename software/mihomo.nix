{ pkgs, ... }:

{
  networking.proxy.default = "http://127.0.0.1:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  boot.kernelModules = [
    "tun"
  ];

  networking.firewall = {
    checkReversePath = "loose"; 
  };

  services.mihomo = {
    enable = true;
    # Note: you need to create the file manually.
    configFile = "/etc/mihomo/config.yaml"; 

    tunMode = true;
    webui = pkgs.metacubexd; 
  };

  networking.firewall = {
    trustedInterfaces = [ "mihomo" ];
  };
}
