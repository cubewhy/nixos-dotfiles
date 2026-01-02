{
  config,
  pkgs,
  ...
}: {
  boot.extraModulePackages = [config.boot.kernelPackages.kvmfr];
  boot.kernelModules = ["kvmfr"];
  boot.extraModprobeConfig = ''
    options kvmfr static_size_mb=64
  '';

  virtualisation.libvirtd.qemu.verbatimConfig = ''
    cgroup_device_acl = [
        "/dev/null", "/dev/full", "/dev/zero",
        "/dev/random", "/dev/urandom",
        "/dev/ptmx", "/dev/kvm",
        "/dev/kvmfr0"
    ]
    cgroup_controllers = [ "cpu", "memory", "blkio", "cpuset", "cpuacct" ]
  '';

  environment.systemPackages = with pkgs; [
    looking-glass-client
  ];
}
