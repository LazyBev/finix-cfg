{inputs, ...}: {
  hjem = {
    clobberByDefault = true;

    extraModules = [
      inputs."hjem-rum".hjemModules."default"
    ];

    users = {
      "yari" = {
        enable = true;
        user = "yari";
        directory = "/home/yari";
        files = {
          "config/niri/config.kdl".source =
            ../wayland/niri-config.kdl;
          "config/niri/larp.png".source =
            ../wayland/niri-larp.png;
          "config/noctalia/config.toml".source =
            ../wayland/noctalia-config.toml;
        };
      };
    };
  };
}