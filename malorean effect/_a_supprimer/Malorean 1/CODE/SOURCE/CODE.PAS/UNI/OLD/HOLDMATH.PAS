Unit Math;

Interface



Const
cmtrigo=256;
cmtrigo2=cmtrigo*cmtrigo;
cmtrigo3=Cmtrigo2*CmTrigo;
demiAngle = 128;
Type
Rec                         = Record
                              S    : Array [0..360] Of Real;
                              C    : Array [0..360] Of Real;
                              End;
Var

R                       : ^Rec;
Fr                      : File Of Rec;
Sa,Ca,So,Co,so2,co2,SaR,CaR,SoR     : array [0..360] of longint;


Procedure charge_Trigo;

Implementation

{安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安皚
Procedure charge_trigo;
var
doserror : integer;
fc,f : integer;
Begin;
New(r);
{Assign (Fr,'trigo.tbl');
Reset(fr);
Read(fr,r^);
close(fr);}
For Fc:=0 to 360 do Begin; {1.1}
                    R^.S [Fc]:=sin(pi/DemiAngle*Fc);
                    R^.C [Fc]:=cos(pi/DemiAngle*Fc);
                    End;   {1.1}
R^.S[0]  :=0;
R^.S[128]:=0;
R^.S[256]:=0;
R^.C[64] :=0;
R^.C[192]:=0;

for fc:=0 to 360 do Begin;
                    Sa[fc]:=Round(1.12*cmtrigo*R^.S[fc]);
                    Ca[fc]:=Round(1.12*cmtrigo*R^.C[fc]);
                    Sar[fc]:=Round(1.12*50*R^.S[fc]);
                    Car[fc]:=Round(1.12*50*R^.C[fc]);

                    So[fc]:=Round(cmtrigo*R^.S[fc]);
                    Co[fc]:=Round(cmtrigo*R^.C[fc]);

                    SoR[fc]:=Round(50*R^.S[fc]);


                    So2[fc]:=Round(cmtrigo*cmtrigo*R^.S[fc]);
                    Co2[fc]:=Round(cmtrigo*cmtrigo*R^.C[fc]);

                    End;

end;
{安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安}

BEGIN;

Charge_Trigo;

END.