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
Var  C1,C2,C3 : T_Cord;
Var  Color    : Byte  ;

Function Image1  : LongInt;
BEGIN;
Image1:=(Q1.D2.X*C1.X*C1.X+Q1.D2.Y*C1.Y*C1.Y+Q1.D1.X*C1.X+Q1.D1.Y*C1.Y+Q1.D0);
END;

Function Image2  : LongInt;
BEGIN;
Image2:=(Q2.D2.X*C2.X*C2.X+Q2.D2.Y*C2.Y*C2.Y+Q2.D1.X*C2.X+Q2.D1.Y*C2.Y+Q2.D0);
END;

Function Image3  : LongInt;
BEGIN;
Image3:=(Q3.D2.X*C3.X*C3.X+Q3.D2.Y*C3.Y*C3.Y+Q3.D1.X*C3.X+Q3.D1.Y*C3.Y+Q3.D0);
END;


Procedure Init;
Begin;
Q2.D2.X:=2 ;   Q1.D1.X:=0 ;   Q1.D0:=5;
Q1.D2.Y:=3 ;   Q1.D1.Y:=2 ;
Q1.D2.Z:=0 ;   Q1.D1.Z:=0 ;

Q2.D2.X:=4 ;   Q3.D1.X:=7 ;   Q1.D0:=5;
Q2.D2.Y:=3 ;   Q3.D1.Y:=-4;
Q2.D2.Z:=0 ;   Q3.D1.Z:=0 ;

Q3.D2.X:=8 ;   Q3.D1.X:=-7;   Q1.D0:=5;
Q3.D2.Y:=-9;   Q3.D1.Y:=-2;
Q3.D2.Z:=0 ;   Q3.D1.Z:=0 ;

C1.X:=-50;     C2.X:= 0;  C3.X:= 50;
C1.Y:=-20;     C2.Y:= 0;  C3.Y:= 100;


End;


Procedure Courbe;
Begin;
For C.X:=0 To 319 Do  Begin;
                      Inc(C1.X);
                      Inc(C2.X);
                      Inc(C3.X);

For C.Y:=0 To 199  Do Begin;
                      Inc(C1.Y);
                      Inc(C2.Y);
                      Inc(C3.Y);

                     Color:=((Image1+Image2+Image3)) DIV 500;
                     PutPixel(C.X,C.Y,Color);
                     end;
                     end;

End;




BEGIN
GraphMode;
Put_Dac(GEST_DAC.Blue);
INIT;
COURBE;
Delay(5000);
END.