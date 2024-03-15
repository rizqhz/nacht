{ pkgs, lib, ... } @ params: let
   # ...
in lib.mkDerivative {
   name = "llvm-17.0.6";
   buildInputs = [];
}