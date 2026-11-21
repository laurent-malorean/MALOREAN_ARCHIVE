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


For Xe:=0 to 319 Do Begin;
For Ye:=0 to 199 do Begin;
                    Cou:=(Ye AND XE) XOR (Xe OR Ye);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;

                    End;
                    End;
end;

BEGIN;
VGA.GraphMode;
PUT_DAC(BLUE);
ES2;
REPEAT;until keypressed;
END.