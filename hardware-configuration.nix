# WARN: Only set the options defined here.
{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.initrd = {
    availableKernelModules = [
      "ahci"
      "xhci_pci"
      "usb_storage"
      "sd_mod"
      "nvme"
      "vmd"
    ];
    kernelModules = [
      "vmd"
      "nvme"
    ];
    supportedFilesystems.ext4.enable = true;
  };
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # WARN: If you dont set this you potentially won't be able to boot your machine.
  hardware.firmware = [ pkgs.linux-firmware ];

  # TODO: Replace this with your actual filesystem layout.
  fileSystems = {
    "/" = {
      device = "/dev/nvme0n1p3";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/nvme0n1p1";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

  };

  swapDevices = [
    { device = "/dev/nvme0n1p2"; }
  ];
}
