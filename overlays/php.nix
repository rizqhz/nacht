final: prev: let
   phpVersion = 83;
in rec {
   php = prev."php${toString phpVersion}".buildEnv {
      extensions = { all, enabled }: with all; enabled ++ [
         imagick ds bz2 redis mongodb
      ];
   };

   composer = php.packages.composer;
}