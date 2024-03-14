final: prev: let
   goVersion = 22;
in rec {
   go = prev."go_1_${toString goVersion}";
}