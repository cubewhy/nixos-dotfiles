{...}: {
  virtualisation.oci-containers.containers.sub-store = {
    image = "xream/sub-store:http-meta";

    autoStart = true;

    extraOptions = ["--network=host"];

    environment = {
      SUB_STORE_BACKEND_API_HOST = "127.0.0.1";
      SUB_STORE_BACKEND_API_PORT = "23001";
      SUB_STORE_BACKEND_MERGE = "true";
      SUB_STORE_FRONTEND_BACKEND_PATH = "/nixos";
      PORT = "9876";
      HOST = "127.0.0.1";
    };

    volumes = [
      "sub-store:/opt/app/data"
    ];
  };
}
