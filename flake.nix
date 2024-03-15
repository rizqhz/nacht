{
  description = "Nacht • Akasha's Nix Flake";

  inputs = rec {
    nixpkgs.url = "flake:nixpkgs";
    utils.url = "flake:flake-utils";
    parts.url = "flake:flake-parts";
  };

  outputs = { self, nixpkgs, utils, parts, ... } @ inputs:
  let
    systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
    forEachSystems = fn: nixpkgs.lib.genAttrs systems (
      system: fn {
        pkgs = import nixpkgs {
          inherit system;
          overlays = import ./overlays { inherit inputs; };
        };
      }
    );
  in rec {
    devShells = forEachSystems ({ pkgs }: rec {
      default = pkgs.mkShell {
        packages = with pkgs; [
          llvm go php composer node
        ];
        shellHook = ''
          echo -e "Hello Flakes"
        '';
      };
    });
  };
}
