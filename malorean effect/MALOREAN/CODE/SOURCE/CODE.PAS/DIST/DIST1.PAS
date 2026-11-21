USES GEST_GRAPH,GEST_DAC,DOS,CRT;

CONST NbPoint=40;
TYPE  Obj    = Record
               X      : Word;
               Y      : Word;
               Poids  : Real;
               End;
TYPE Ensemble = Array[1..NbPoint] Of Obj;

VAR  F1,F2,F3,F4,F5  : Byte    ;
VAR  Ensemble1       : Ensemble;
VAR  Xe,Ye           : Word    ;

Procedure init_points;
Begin
Randomize;
For F1:=1 to NbPoint Do Begin;
                        Ensemble1[f1].X     :=Random(160);
                        Ensemble1[f1].Y     :=Random(100);
                        Ensemble1[f1].Poids :=Random(10) ;
                        End;

End;

Function  Image (X_,Y_ : Word) : Byte;
VAR       BUF1 : REAL;
VAR       BUF2 : REAL;

Begin;    Buf1:=0;
          Buf2:=0;
          For f1:=1 To NbPoint Do Begin;
          Buf1:=Buf1+Ensemble1[F1].poids*sqrt(abs((Sqr(X_-Ensemble1[f1].X)+Sqr(Y_-Ensemble1[f1].Y))));
          Buf2:=Buf2+Ensemble1[F1].poids;
          end;
          Buf1:=Buf1/Buf2;
          Image:=Round(Buf1);
End;


BEGIN GEST_GRAPH.GraphMode;
      Put_Dac(GEST_DAC.Blue);
      init_points;
      For Xe:=0 to 319 do For Ye:=0 to 199 do PutPixel(Xe,Ye,Image(Xe,Ye));
      Delay(5000);


      GEST_GRAPH.TextMode;
END.