Uses GEST_Rotation,Gest_Graph,dac_code,dac_frac;

Const max = 1;

Var Cube  : Oobj1;
Var Cube2  : Oobj1;

    F     : Word;
    g : word;

PROCEDURE INIT;
BEGIN;
Cube.D_O:=1;
Cube.Init_Angle_Obj;
Cube.Init_Centre(160,100);
Cube.Init_Angle_Centre(0,0,0,25);
Cube2.D_O:=1;
Cube2.Init_Angle_Obj;
Cube2.Init_Centre(160,100);
Cube2.Init_Angle_Centre(0,0,0,25);

END;

BEGIN
INIT;
put_dac(volcano);
For f:=0 to 5000 do begin;
                    Cube.Inc_Angle_Obj(1,2,3);
                    Cube.Inc_Angle_Centre(3,2,1);
                    Cube.Matrice(10);
                    Cube2.Inc_Angle_Obj(3,1,1);
                    Cube2.Inc_Angle_Centre(4,2,7);
                    Cube2.Matrice(10);

                    end;
END.