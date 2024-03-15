final: prev: let
   nodeVersion = 21;
in {
   node = prev."nodejs_${toString nodeVersion}";
}