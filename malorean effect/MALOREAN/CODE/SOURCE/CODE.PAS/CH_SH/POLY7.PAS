USES CGraph,Crt,GEST_DAC;
VAR
       V        : Type_Graph_Ecran  ABSOLUTE $A000:$0000;
       VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       Xe,Ye    : Word;
       cou      : Byte;


     {Variables pour la partie ES}
     Amin,Bmin,Amax,Bmax    : Real;
     pasX,pasY              : Real;
     module                 : real;
     NbIter                 : Byte;

     Px                     : Array [0..319] Of Real;
     Py                     : Array [0..199] Of Real;
     CosY                   : Array [0..199] Of Real;
     SinX                   : Array [0..319] Of Real;

     PartieA,PartieB        : Real;



PROCEDURE ES2;
BEGIN;
Amin:= -20;
Amax:=  20;
Bmin:= -20;
Bmax:=  20;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px   [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py   [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=Px[xe]*Px[xe]*Px[xe];
For ye:=0 to 199 do CosY [ye]:=Py[Ye]*Py[Ye]*Py[Ye];


For Xe:=0 to 159 Do Begin;
For Ye:=0 to 99 do Begin;
                    Cou:=Round((SinX[XE]-CosY[Ye]));
                    VGA_Ecran[T[Ye]+Xe]:=Cou;
                    VGA_Ecran[T[199-Ye]+Xe]:=Cou;
                    VGA_Ecran[T[Ye]+319-Xe]:=Cou;
                    VGA_Ecran[T[199-Ye]+319-Xe]:=Cou;

                    End;
                    End;
end;

BEGIN;
VGA.GraphMode;
PUT_DAC(PAL4);
ES2;
REPEAT;until keypressed;
END.