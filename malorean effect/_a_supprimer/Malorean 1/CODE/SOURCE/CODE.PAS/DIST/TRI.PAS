USES GEST_GRAPH,GEST_DAC,DOS,CRT;

CONST NbPoint=1;
TYPE  Obj    = Record
               X      : Word;
               Y      : Word;
               End;
TYPE Ensemble = Array[1..NbPoint] Of Obj;

VAR  F1,F2,F3,F4,F5  : Byte    ;
VAR  Ensemble1       : Ensemble;
VAR  COMPTEUR        : LongInt;
VAR       X,Y    : WORD;
VAR       Buf1,Buf2 : Word;
VAR       C         : Byte;

Procedure init_points;
Begin
Randomize;
For F1:=1 to NbPoint Do Begin;
                        Ensemble1[f1].X     :=Random(320);
                        Ensemble1[f1].Y     :=Random(200);
                        End;

End;

Function  Image  : Byte;
Begin;
End;


BEGIN GEST_GRAPH.GraphMode;
      Put_Dac(GEST_DAC.Blue);
      init_points;
For Compteur:=0 to 250000 Do Begin;
          Buf1:=0;
          Buf2:=0;
          For f1:=1 to NbPoint Do begin;
                                  Buf1:=Buf1+Ensemble1[f1].X;
                                  Buf2:=Buf2+Ensemble1[f1].Y;
                                  end;
         C   :=Buf1 AND Buf2;
         Buf1:=Buf1 div NbPoint;
         Buf2:=Buf2 div NbPoint;
         PutPixel(Buf1,Buf2,C);
         For f1:=2 to NbPoint Do Ensemble1[f1-1]:=Ensemble1[f1];
                        Ensemble1[f1].X     :=Random(320);
                        Ensemble1[f1].Y     :=Random(200);

end;
      Delay(5000);


      GEST_GRAPH.TextMode;
END.