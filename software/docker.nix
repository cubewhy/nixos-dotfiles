{...}: {
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings.features.cdi = true;

  # networking.firewall = {
  #   trustedInterfaces = ["docker0"];
  #
  #   extraCommands = ''
  #     iptables -A INPUT -i docker+ -p udp --dport 53 -j ACCEPT
  #     iptables -A INPUT -i docker+ -p tcp --dport 53 -j ACCEPT
  #   '';
  # };

  networking.localCommands = ''
    ip rule add from 172.16.0.0/12 lookup main priority 8000 2>/dev/null || true
  '';
}
