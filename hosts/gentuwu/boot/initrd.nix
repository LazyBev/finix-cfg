_: {
  boot = {
    initrd = {
      compressorArgs = [
        "-22"
        "--ultra"
        "-T8"
      ];

      supportedFilesystems = {
        ext4 = {
          enable = true;
        };

        vfat = {
          enable = true;
        };
      };
    };
  };
}
