_: {

  fileSystems = {
    "/boot" = {
      device = "/dev/nvme0n1p1";
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
      device = "/dev/nvme0n1p3";
      fsType = "ext4";
      options = [
        "noatime"
        "errors=remount-ro"
      ];
    };
  };

  swapDevices = [
    {
      device = "/dev/nvme0n1p2";
    }
  ];
}
