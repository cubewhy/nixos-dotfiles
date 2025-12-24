{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    uv
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        pysocks
      ]))
  ];
}
