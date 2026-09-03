_: {
  boot.initrd.fileSystemImportCommands = ''
    # finix/mdevd coldplug race: /dev/disk/by-* symlinks may not exist yet.
    # Populate them manually so wait-dev/mount can find root/boot/swap.
    mkdir -p /dev/disk/by-label /dev/disk/by-uuid

    current_dev=""
    blkid --output export 2>/dev/null | while IFS='=' read -r key value; do
      case "$key" in
        DEVNAME)
          current_dev="$value"
        ;;
        LABEL)
          [ -n "$current_dev" ] || continue
          ln -snf "$current_dev" "/dev/disk/by-label/$value"
        ;;
        UUID)
          [ -n "$current_dev" ] || continue
          ln -snf "$current_dev" "/dev/disk/by-uuid/$value"
        ;;
      esac
    done
  '';

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
