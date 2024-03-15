final: prev: let
   goVersion = 20;
in rec {
   go = prev."go_1_${toString goVersion}";
}