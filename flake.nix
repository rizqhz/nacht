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
          echo -e "[λ] Nacht • Akasha's Nix Flake"
          export WORKDIR=$HOME/work;
          export ENVDIR=$HOME/env;
          export GO111MODULE='on';
          export GOPATH=$WORKDIR/go;
          export GOBIN=$ENVDIR/go/bin;
          export GOCACHE=$ENVDIR/go/cache;
          export GOENV=$ENVDIR/go/go.env;
          export GOMODCACHE=$ENVDIR/go/pkg/mod;
          export COMPOSER_HOME=$ENVDIR/composer;
          export COMPOSER_BIN_DIR=$COMPOSER_HOME/bin;
          export COMPOSER_CACHE_DIR=$COMPOSER_HOME/cache;
          export COMPOSER_VENDOR_DIR=$COMPOSER_HOME/vendor;
        '';
      };
    });
  };
}
