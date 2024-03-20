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
      fullstack = pkgs.mkShellNoCC {
        packages = with pkgs; [
          php composer node
        ];

        shellHook = ''
          echo -e "[λ] Nacht • Akasha's Nix Flake"
          export WORKDIR=$HOME/work/fullstack;
          export ENVDIR=$HOME/env;
          export GIT_CONFIG_GLOBAL=$ENVDIR/git/config;
          export COMPOSER_HOME=$ENVDIR/composer;
          export COMPOSER_BIN_DIR=$COMPOSER_HOME/bin;
          export COMPOSER_CACHE_DIR=$COMPOSER_HOME/cache;
          export COMPOSER_VENDOR_DIR=$COMPOSER_HOME/vendor;
          export npm_config_cache=$ENVDIR/npm/cache;
          export npm_config_userconfig=$ENVDIR/npm/config;
          cd $WORKDIR;
        '';
      };

      backend = pkgs.mkShellNoCC {
        packages = with pkgs; [
          go
        ];

        shellHook = ''
          echo -e "[λ] Nacht • Akasha's Nix Flake"
          export WORKDIR=$HOME/work/backend;
          export ENVDIR=$HOME/env;
          export GIT_CONFIG_GLOBAL=$ENVDIR/git/config;
          export GO111MODULE='on';
          export GOPATH=$WORKDIR/backend;
          export GOBIN=$ENVDIR/go/bin;
          export GOCACHE=$ENVDIR/go/cache;
          export GOENV=$ENVDIR/go/go.env;
          export GOMODCACHE=$ENVDIR/go/pkg/mod;
          cd $WORKDIR;
        '';
      };

      default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          llvm libcxx libcxxabi
        ];

        shellHook = ''
          echo -e "[λ] Nacht • Akasha's Nix Flake"
          export WORKDIR=$HOME/work/system;
          export ENVDIR=$HOME/env;
          export GIT_CONFIG_GLOBAL=$ENVDIR/git/config;
          cd $WORKDIR;
        '';
      };
    });
  };
}
