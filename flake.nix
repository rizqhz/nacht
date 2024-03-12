{
  description = "Nacht • Akasha Nix Flake";

  inputs = rec {
    nixpkgs.url = "flake:nixpkgs";
  };

  outputs = { self, nixpkgs, ... }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system} = {
      backend = pkgs.mkShellNoCC rec {
        packages = with pkgs; [
          go_1_22
        ];
      };

      llvm = pkgs.mkShellNoCC rec {
        packages = with pkgs.llvmPackages; [
          clangUseLLVM
        ];
      };
    };
  };
}
