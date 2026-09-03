_: {
  boot = {
    initrd = {
      compressorArgs = [
        "-22"
        "--ultra"
        "-T8"
      ];

      kernelModules = [
        "nvme"
      ];

      supportedFilesystems = {
        ext4 = {
          enable = true;
        };

        vfat = {
          enable = true;
        };
      };

      emergencyAccess = true;
    };
  };
}
