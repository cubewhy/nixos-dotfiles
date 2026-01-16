# https://github.com/linyinfeng/angrr
{...}: {
  services.angrr = {
    enable = true;
    settings = {
      temporary-root-policies = {
        direnv = {
          path-regex = "/\\.direnv/";
          period = "14d";
        };
        result = {
          path-regex = "/result[^/]*$";
          period = "3d";
        };
        # You can define your own policies
        # ...
      };
      profile-policies = {
        system = {
          profile-paths = ["/nix/var/nix/profiles/system"];
          keep-since = "14d";
          keep-latest-n = 5;
          keep-booted-system = true;
          keep-current-system = true;
        };
        user = {
          enable = false; # Policies can be individually disabled
          profile-paths = [
            # `~` at the beginning will be expanded to the home directory of each discovered user
            "~/.local/state/nix/profiles/profile"
            "/nix/var/nix/profiles/per-user/root/profile"
          ];
          keep-since = "1d";
          keep-latest-n = 1;
        };
        # You can define your own policies
        # ...
      };
    };
  };
  # angrr.service runs before nix-gc.service by default
  nix.gc.automatic = true;
  programs.direnv.enable = true;
}
