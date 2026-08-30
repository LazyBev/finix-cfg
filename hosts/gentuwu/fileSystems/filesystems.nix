_: {
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
        "noexec"
        "nosuid"
        "nodev"
        "rw"
      ];
    };

    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      options = [
        "noatime"
        "errors=remount-ro"
      ];
    };
  };

  swapDevices = [
    {
      device = "/dev/disk/by-label/swap";
    }
  ];
}
