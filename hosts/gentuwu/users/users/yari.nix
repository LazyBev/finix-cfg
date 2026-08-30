{config, ...}: {
  users = {
    users = {
      "yari" = {
        description = "yari";
        isNormalUser = true;
        password = "pass"; # 100% change in system
        extraGroups = [
          config.services.seatd.group
          "audio"
          "input"
          "video"
          "wheel"
          "tty"
        ];
      };
    };
  };
}
