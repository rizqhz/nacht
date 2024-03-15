{ inputs, ... } @ params: [
   (import ./llvm.nix)
   (import ./go.nix)
   (import ./php.nix)
   (import ./node.nix)
]