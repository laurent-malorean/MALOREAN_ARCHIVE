USES Cgraph;
VAR  VGA  : TGraphVga;

BEGIN;
VGA.GraphMode;
Charge_Shoot (ParamStr(1));
LoadPal(ParamStr(2));
Sauve_Shoot(ParamStr(1));
END.