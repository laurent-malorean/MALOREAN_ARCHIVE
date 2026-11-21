USES CGraph,Crt,GEST_DAC;
VAR
       V        : Type_Graph_Ecran  ABSOLUTE $A000:32160;
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
     TanXY                   : Array [0..319] Of Real;

     PartieA,PartieB        : Real;

     Xecr,Yecr               : word;

     scrool : word;

PROCEDURE ES2;
BEGIN;
Xecr:=160;
Yecr:=140;

Amin:= -18;
Amax:=  18;
Bmin:= -18;
Bmax:=  18;

For scrool :=1 to 280 do begin;
Amin:=Amin+0.01*ABS(Amin);
Bmin:=Bmin+0.01*abs(amin);
Amax:=1.01*Amax;
Bmax:=1.01*Bmax;

pasX:=(Amax-Amin)/Xecr;
pasY:=(Bmax-Bmin)/Yecr;
For xe:=0 to Xecr do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to Yecr do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to Xecr do SinX [xe]:=Px[xe]*Px[Xe]*Px[Xe];
For ye:=0 to Yecr do CosY [ye]:=Py[Ye]*PY[Ye]*Px[Xe];


For Xe:=0 to (Xecr SHR 1) Do Begin;
For Ye:=0 to (Yecr SHR 1) do Begin;
                    Cou:=Round(SinX[XE]+CosY[Ye]);
                    V[T[Ye]+Xe]:=Cou;
                    V[T[Ye]-Xe]:=Cou;
                    V[-T[Ye]+Xe]:=Cou;
                    V[-T[Ye]-Xe]:=Cou;
                    End;
                    End;
end;
end;

BEGIN;
VGA.GraphMode;
PUT_DAC(Blue);
ES2;
REPEAT;until keypressed;
END.