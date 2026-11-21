Uses G_R,Gest_Graph,gest_dac;

Const max = 300;

Var Cube  : array [1..max] of Oobj1;
Var angle1 :array [1..max] of byte;
Var angle2 :array [1..max] of byte;

    F     : Word;
    g : word;

PROCEDURE INIT;
BEGIN;
for f:=1 to max do begin;
Cube[f].D_O:=1;
Cube[f].Init_Angle_Obj;
Cube[f].Init_Centre(160,100);
Cube[f].Init_Angle_Centre(random(360)-180,random(360)-180,random(360)-180,f*20);
angle1[f]:=random(6);
angle2[f]:=random(6);
end;
END;

BEGIN
INIT;
put_dac(volpone1);
For f:=0 to 5000 do begin;
for f:=1 to max do begin;
                    Cube[f].Inc_Angle_Obj(f-5,f-5,f-5);
                    Cube[f].Inc_Angle_Centre(random(10)-5,random(15)-7,1);
                    Cube[f].Matrice(random(25));
                    end;

                    end;
END.