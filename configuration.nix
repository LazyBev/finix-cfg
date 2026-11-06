{
  config,
  modules,
  lib,
  pkgs,
  ...
}:

{
  imports = with modules; [
    # WARN: Check out the comments in this file too.
    ./hardware-configuration.nix

    nix-daemon
    openssh
    sysklogd
    limine
    doas
    polkit
    # WARN: Either import and enable this or any login manager, if you don't you
    # will be left with an unbootable generation.
    getty
    bash
    dhcpcd
    iwd
    niri
    greetd
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  finit.runlevel = 3;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.emergencyAccess = true;

  programs = {
    limine = {
      enable = true;
      settings.editor_enabled = true; # NOTE: Disable on systems that need security.
    };

    doas.enable = true;

    bash.enable = true;
    # TODO: Pick a DE/WC.
    niri.enable = true;
  };

  services = {
    nix-daemon = {
      enable = true;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [
          "root"
          "@wheel"
        ];
      };
    };

    polkit.enable = true;

    sysklogd.enable = true;

    dbus.enable = true;

    keventd.enable = true;

    # WARN: Are you sure you don't want to enable this? You'll have to configure
    # stuff like DNS manually to be able to access the internet.
    dhcpcd.enable = true;
    iwd.enable = true;

    # WARN: You need a seat.
    seatd.enable = true;

    # WARN: getty is not enabled by default.
    getty.enable = true;

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.tuigreet}";
        };
      };
    };
  };

  fonts = {
    fontconfig.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  };

  # TODO: Define hostname.
  networking.hostName = "gentuwu";

  # TODO: Set timezone.
  time.timeZone = "Europe/London";

  # TODO: Define your user. Create a password with:
  # $ mkpasswd --method=yescrypt
  users.users."yari" = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "input"
      config.services.seatd.group
    ];
    # WARN: Don't forget to set a hashed password here or you'll face the consequences
    # of your actions.
    password = "$y$j9T$QwDmcKYHAT2HFLNxsBmMy/$8ocpuTEentUo0lfkPwV8tuYYDovhcsRupPml/bOyrnA";
    packages = with pkgs; [ ];
  };

  hardware.graphics.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    helix
    wget
    git
    iputils
    iproute2
    # TODO: Pick a wayland terminal.
    alacritty
    foot
    # NOTE: You can get rid of this if you use nh but be aware you need either of
    # them to rebuild your system...
    nixos-rebuild-ng
    firefox
    nh
  ];
}
