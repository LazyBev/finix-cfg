============== hosts/gentuwu/boot/initrd.nix ==================
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


============== hosts/gentuwu/boot/kernel.nix ==================
{inputs, ...}: {
  boot = {
    kernel = {
      sysctl = {
        "dev.tty.ldisc_autoload" = 0;
        "fs.inotify.max_user_instances" = 524288;
        "fs.inotify.max_user_watches" = 524288;
        "fs.protected_fifos" = 2;
        "fs.protected_hardlinks" = 1;
        "fs.protected_regular" = 2;
        "fs.protected_symlinks" = 1;
        "fs.suid_dumpable" = 0;
        "kernel.dmesg_restrict" = 1;
        "kernel.kptr_restrict" = 2;
        "kernel.perf_event_paranoid" = 3;
        "kernel.randomize_va_space" = 2;
        "kernel.watchdog" = 0;
        "kernel.yama.ptrace_scope" = 2;
        "net.core.bpf_jit_harden" = 1;
        "net.ipv4.conf.all.accept_source_route" = 0;
        "net.ipv4.conf.all.accept_redirects" = 0;
        "net.ipv4.conf.all.log_martians" = 1;
        "net.ipv4.conf.all.rp_filter" = 1;
        "net.ipv4.conf.all.secure_redirects" = 0;
        "net.ipv4.conf.default.accept_source_route" = 0;
        "net.ipv4.conf.default.accept_redirects" = 0;
        "net.ipv4.conf.default.log_martians" = 1;
        "net.ipv4.conf.default.rp_filter" = 1;
        "net.ipv4.conf.default.secure_redirects" = 0;
        "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
        "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
        "net.ipv4.tcp_rfc1337" = 1;
        "net.ipv4.tcp_syncookies" = 1;
        "net.ipv6.conf.all.accept_source_route" = 0;
        "net.ipv6.conf.all.accept_ra_rt_info_max_plen" = 0;
        "net.ipv6.conf.all.accept_redirects" = 0;
        "net.ipv6.conf.all.rp_filter" = 1;
        "net.ipv6.conf.default.accept_source_route" = 0;
        "net.ipv6.conf.default.accept_ra_rt_info_max_plen" = 0;
        "net.ipv6.conf.default.accept_redirects" = 0;
        "net.ipv6.conf.default.rp_filter" = 1;
        "net.ipv6.icmp.echo_ignore_anycast" = 1;
        "net.ipv6.icmp.echo_ignore_multicast" = 1;
        "vm.dirty_background_bytes" = 67108864;
        "vm.dirty_bytes" = 268435456;
        "vm.dirty_expire_centisecs" = 1500;
        "vm.dirty_writeback_centisecs" = 100;
        "vm.max_map_count" = 1048576;
        "vm.mmap_rnd_bits" = 32;
        "vm.mmap_rnd_compat_bits" = 16;
        "vm.page-cluster" = 0;
        "vm.swappiness" = 200;
        "vm.vfs_cache_pressure" = 50;
      };
    };

    kernelPackages = inputs."nix-cachyos-kernel".legacyPackages.x86_64-linux.linuxPackages-cachyos-latest-lto-x86_64-v4;

    kernelModules = [
      "i2c-dev"
      "ntsync"
      "v4l2loopback"
      "vmd"
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    kernelParams = [
      "iommu=pt"
      "pcie_aspm=performance"
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "mitigations=auto"
      "lockdown=integrity"
      "init_on_alloc=1"
      "init_on_free=1"
      "slab_nomerge"
      "page_alloc.shuffle=1"
      "vsyscall=none"
      "oops=panic"
      "nvidia-drm.modeset=1"
      "nvidia.NVreg_EnableGpuFirmware=0"
      "lsm=landlock,yama,bpf"
    ];

    supportedFilesystems = {
      ext4 = {
        enable = true;
      };

      vfat = {
        enable = true;
      };

      luks = {
        enable = true;
      };

      lvm = {
        enable = true;
      };
    };
  };
}


============== hosts/gentuwu/boot/loader/efi.nix ==================
_: {
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };
}


============== hosts/gentuwu/boot/loader/limine.nix ==================
{lib, ...}: {
  imports = [
    (
      lib.mkAliasOptionModule [
        "boot"
        "loader"
        "limine"
      ] [
        "programs"
        "limine"
      ]
    )
  ];

  boot = {
    loader = {
      limine = {
        enable = true;
        maxGenerations = 2;
      };
    };
  };
}


============== hosts/gentuwu/fileSystems/filesystems.nix ==================
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


============== hosts/gentuwu/hjem/users.nix ==================
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

============== hosts/gentuwu/networking/hostName.nix ==================
_: {
  networking = {
    hostName = "gentuwu";
  };
}


============== hosts/gentuwu/time/timeZone.nix ==================
_: {
  time = {
    timeZone = "Europe/Moscow";
  };
}


============== hosts/gentuwu/users/users/yari.nix ==================
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


============== hosts/gentuwu/wayland/niri.nix ==================
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


============== hosts/gentuwu/wayland/noctalia.nix ==================
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    noctalia
  ];
}

============== modules/cpu.nix ==================
_: {
  hardware = {
    cpu = {
      amd = {
        updateMicrocode = true;
      };

      intel = {
        updateMicrocode = true;
      };
    };
  };
}


============== modules/envinronment/systemPackages.nix ==================
{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      attr
      bashInteractive
      bind
      curlFull
      gawk
      getconf
      getent
      gzip
      iproute2
      kmod
      libcap
      libressl
      mkpasswd
      ncurses
      openssh
      patch
      shadow
      su
      jq
      nix
      nix-index
      nix-tree
      nix-direnv
      nixos-rebuild
      nh
      nixfmt-rfc-style
      alejandra
      statix
      util-linux
      uutils-acl
      uutils-coreutils-noprefix
      uutils-findutils
      uutils-hostname
      uutils-procps
      uutils-sed
      uutils-tar
      xz
    ];
  };
}


============== modules/finit/runlevel.nix ==================
_: {
  finit = {
    runlevel = 3;
  };
}


============== modules/finit/services/nix-daemon.nix ==================
{config, ...}: {
  finit = {
    services = {
      "nix-daemon" = {
        environment = {
          CURL_CA_BUNDLE = config.security.pki.caBundle;
        };
      };
    };
  };
}


============== modules/firmware.nix ==================
{pkgs, ...}: {
  hardware = {
    firmware = with pkgs; [
      linux-firmware
      alsa-firmware
      sof-firmware
    ];
  };
}


============== modules/fonts/fonts.nix ==================
{pkgs, ...}: {
  fonts = {
    fontconfig = {
      enable = true;
    };

    packages = with pkgs; [
      nerd-fonts.monaspace
      nerd-fonts.noto
    ];
  };
}


============== modules/graphics.nix ==================
_: {
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}


============== modules/programs/bash.nix ==================
_: {
  programs = {
    bash = {
      enable = true;
    };
  };
}


============== modules/programs/coreutils.nix ==================
{pkgs, ...}: {
  programs = {
    coreutils = {
      package = pkgs.uutils-coreutils-noprefix;
    };
  };
}


============== modules/programs/pipewire.nix ==================
_: {
  programs = {
    pipewire = {
      enable = true;

      alsa = {
        enable = true;
      };

      jack = {
        enable = true;
      };
    };
  };
}


============== modules/programs/resolveconf.nix ==================
_: {
  programs = {
    resolvconf = {
      enable = true;
      settings = {
        name_servers = "127.0.0.1 ::1";
      };
    };
  };
}


============== modules/programs/sudo.nix ==================
{pkgs, ...}: {
  programs = {
    sudo = {
      enable = true;
      package = pkgs.sudo-rs;
    };
  };
}


============== modules/programs/wireplumber.nix ==================
_: {
  programs = {
    wireplumber = {
      enable = true;
    };
  };
}


============== modules/services/blocky.nix ==================
_: {
  services = {
    blocky = {
      enable = true;
      settings = {
        ports = {
          dns = 53;
        };

        caching = {
          minTime = "5m";
          maxTime = "30m";
          prefetching = true;
        };

        bootstrapDns = {
          upstream = "";
          ips = [
            "1.1.1.1"
            "2606:4700:4700::1111"
          ];
        };

        upstreams = {
          groups = {
            default = [
              "tcp-tls:1.1.1.1:853"
              "tcp-tls:[2606:4700:4700::1111]:853"
              "https://cloudflare-dns.com/dns-query"
            ];
          };
        };
      };
    };
  };
}


============== modules/services/chrony.nix ==================
{pkgs, ...}: {
  services = {
    chrony = {
      enable = true;
      configFile = pkgs.writeText "chrony.conf" ''
        server 162.159.200.1 iburst ipv4
        server 2606:4700:f1::1 iburst ipv6

        server time.cloudflare.com iburst nts ipv4
        server time.cloudflare.com iburst nts ipv6

        driftfile /var/lib/chrony/drift
        makestep 1.0 3
        rtcsync
      '';
    };
  };
}


============== modules/services/dbus.nix ==================
{pkgs, ...}: {
  services = {
    dbus = {
      enable = true;
      packages = with pkgs; [
        dconf
        xfconf
      ];
    };
  };
}


============== modules/services/earlyoom.nix ==================
_: {
  services = {
    earlyoom = {
      enable = true;
    };
  };
}


============== modules/services/fcron.nix ==================
_: {
  services = {
    fcron = {
      enable = true;
    };
  };
}


============== modules/services/fstrim.nix ==================
_: {
  services = {
    fstrim = {
      enable = true;
      interval = "weekly";
    };
  };
}


============== modules/services/getty.nix ==================
_: {
  services = {
    getty = {
      enable = true;
    };
  };
}


============== modules/services/logrotate.nix ==================
_: {
  services = {
    logrotate = {
      enable = true;
      rules = {
        system-messages = {
          enable = true;

          text = ''
            /var/log/messages /var/log/secure /var/log/auth.log {
              weekly
              rotate 4
              missingok
              compress
              notifempty
              sharedscripts
            }
          '';
        };
      };
    };
  };
}


============== modules/services/ly.nix ==================
_: {
  services = {
    ly = {
      enable = true;
      settings = {
        animation = "matrix";
        bigclock = true;
        save = true;
      };
    };
  };
}


============== modules/services/mdevd.nix ==================
{
  config,
  lib,
  ...
}: {
  services = {
    mdevd = {
      enable = true;

      hotplugRules = lib.mkMerge [
        (
          lib.mkAfter ''
            SUBSYSTEM=input;.* root:input 660
            SUBSYSTEM=sound;.* root:audio 660
          ''
        )

        ''
          grsec       root:root 660
          kmem        root:root 640
          mem         root:root 640
          port        root:root 640
          console     root:tty 600 @chmod 600 $MDEV
          card[0-9]   root:video 660 =dri/

          # alsa sound devices and audio stuff
          pcm.*       root:audio 0660 =snd/
          control.*   root:audio 0660 =snd/
          midi.*      root:audio 0660 =snd/
          seq         root:audio 0660 =snd/
          timer       root:audio 0660 =snd/

          adsp        root:audio 0660 >sound/
          audio       root:audio 0660 >sound/
          dsp         root:audio 0660 >sound/
          mixer       root:audio 0660 >sound/
          sequencer.* root:audio 0660 >sound/

          event[0-9]+ root:input 660 =input/
          mice        root:input 660 =input/
          mouse[0-9]+ root:input 660 =input/

          rfkill      root:${config.services.seatd.group} 660
        ''
      ];
    };
  };
}


============== modules/services/nftables.nix ==================
_: {
  services = {
    nftables = {
      enable = true;
    };
  };
}


============== modules/services/nix-daemon.nix ==================
_: {
  services = {
    nix-daemon = {
      enable = true;
      settings = {
        allowed-users = [
          "root"
          "@wheel"
        ];

        trusted-users = [
          "root"
          "@wheel"
        ];

        experimental-features = [
          "flakes"
          "nix-command"
        ];
      };
    };
  };
}


============== modules/services/polkit.nix ==================
_: {
  services = {
    polkit = {
      enable = true;
    };
  };
}


============== modules/services/rtkit.nix ==================
_: {
  services = {
    rtkit = {
      enable = true;
    };
  };
}


============== modules/services/seatd.nix ==================
_: {
  services = {
    seatd = {
      enable = true;
    };
  };
}


============== modules/services/sysklogd.nix ==================
_: {
  services = {
    sysklogd = {
      enable = true;
      extraConfig = ''
        user.*                          -/var/log/user.log

        rotate_size  1M
        rotate_count 5
      '';
    };
  };
}


============== modules/uinput.nix ==================
_: {
  hardware = {
    uinput = {
      enable = true;
    };
  };
}


============== flake.nix ==================
{
  description = "yari flake (finix) - gentuwu";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    finix.url = "github:finix-community/finix";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        hjem.follows = "hjem";
      };
    };

    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };
  };

  outputs = { self, nixpkgs, finix, hjem, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
       (final: prev: {
         jq = prev.jq // { dev = prev.jq; };
        })
      ];
    };

    # only import *.nix files as modules; ignore scratch/dotfiles (e.g. *.kdl)
    nixFiles = dir:
      nixpkgs.lib.filter
      (f: nixpkgs.lib.hasSuffix ".nix" f)
      (nixpkgs.lib.filesystem.listFilesRecursive dir);

    mkFinixHost = host: finix.lib.finixSystem {
      inherit (pkgs) lib;
      specialArgs = { inherit inputs self; };
      modules =
        (nixpkgs.lib.attrValues finix.nixosModules)
        ++ nixFiles "${self}/modules"
        ++ nixFiles "${self}/hosts/${host}"
        ++ [
          {
            nixpkgs.pkgs = pkgs.lib.mkDefault pkgs;
          }
          hjem.finixModules.default
        ];
    };
  in {
    nixosConfigurations = {
      gentuwu = mkFinixHost "gentuwu";
    };

    formatter.${system} = pkgs.nixfmt-rfc-style;
  };
}


