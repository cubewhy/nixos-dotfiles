# Notes:
# You can manage your subscriptions with Substore by accessing the following url
# http://127.0.0.1:23001
# (You need to create a proxy collection called `subscriptions` to make the things work)
# Switch node with the webui
# http://127.0.0.1:9090/ui
# Never open the 23001 and 9090 port to the public!

{ pkgs, ... }:

{
  imports = [
    ../substore.nix
  ];
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
    configFile = "/etc/mihomo/config.yaml"; 

    tunMode = true;
    webui = pkgs.metacubexd; 
  };

  environment.etc."mihomo/config.yaml" = {
    source = ./config.yaml;
    mode = "0700";
    user = "root";
  };

  networking.firewall = {
    trustedInterfaces = [ "mihomo" ];
  };
}
