{
  description = "Nacht • Akasha's Nix Flake";

  inputs = rec {
    nixpkgs.url = "flake:nixpkgs";
    utils.url = "flake:flake-utils";
    parts.url = "flake:flake-parts";
  };

  outputs = { self, nixpkgs, utils, parts, ... } @ inputs: let
    systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
    forEachSystems = fn: nixpkgs.lib.pkgAttrs systems (system: fn {
      pkgs = import nixpkgs { inherit system; };
    });
  in rec {
    overlays = import ./overlays { inherit inputs; };
    devShells = forEachSystems ({ pkgs }: rec {
      default = pkgs.mkShell {
        shellHook = ''
          echo -e "Hello Flakes"
        '';
      };
    });
  };
}
