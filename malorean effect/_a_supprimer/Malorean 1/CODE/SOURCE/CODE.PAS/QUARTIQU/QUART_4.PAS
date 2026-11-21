USES GEST_GRAPH,GEST_DAC,CRT;

TYPE   T_CORD = Record
                X       : Integer;
                Y       : Integer;
                Z       : Integer;
                End;



TYPE   T_QUAR= Record
               D0    : Integer;
               D1    : T_CORD ;
               D2    : T_CORD ;
               end;

Var  C        : T_CORD;
Var  Q1,Q2,Q3 : T_Quar;
Var  Color    : Byte  ;

Function Image (Q : T_QUAR) : LongInt;
BEGIN;
Image:=(Q.D2.X*C.X*C.X+Q.D2.Y*C.Y*C.Y+Q.D1.X*C.X+Q.D1.Y*C.Y+Q.D0);
END;

Procedure Init;
Begin;
Q1.D2.X:=10 ;   Q1.D1.X:=4 ;   Q1.D0:=5;
Q1.D2.Y:=-5 ;   Q1.D1.Y:=3 ;
Q1.D2.Z:=0 ;   Q1.D1.Z:=0 ;

Q2.D2.X:=-12 ;   Q3.D1.X:=18 ;   Q1.D0:=15;
Q2.D2.Y:=15 ;   Q3.D1.Y:=19  ;
Q2.D2.Z:=0 ;   Q3.D1.Z:=0 ;

Q3.D2.X:=1 ;   Q3.D1.X:=1 ;   Q1.D0:=-5;
Q3.D2.Y:=1 ;   Q3.D1.Y:=1 ;
Q3.D2.Z:=0 ;   Q3.D1.Z:=0 ;



End;


Procedure Courbe;
Begin;
For C.X:=0 To 319 Do
For C.Y:=0 To 199  Do Begin;
                     Color:=((Image(Q1)*Image(Q2))) div 10000000;
                     PutPixel(C.X,C.Y,Color);
                     end;

End;




BEGIN
GraphMode;
Put_Dac(GEST_DAC.Blue);
INIT;
COURBE;
Delay(5000);
END.