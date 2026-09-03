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

    # hjem = {
    #   url = "github:feel-co/hjem";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # hjem-rum = {
    #   url = "github:snugnug/hjem-rum";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     hjem.follows = "hjem";
    #   };
    # };

    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };
  };

  outputs = { self, nixpkgs, finix, ... }@inputs: let
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
          # hjem.finixModules.default
        ];
    };
  in {
    nixosConfigurations = {
      gentuwu = mkFinixHost "gentuwu";
    };

    formatter.${system} = pkgs.nixfmt-rfc-style;
  };
}
