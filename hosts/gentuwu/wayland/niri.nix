{config, pkgs, ...}: {
  programs.niri.enable = true;

  environment = {
    systemPackages = with pkgs; [
      alacritty
    ];

    # ensure ly can discover niri's wayland session
    pathsToLink = [
      "/share/wayland-sessions"
    ];
  };
}
