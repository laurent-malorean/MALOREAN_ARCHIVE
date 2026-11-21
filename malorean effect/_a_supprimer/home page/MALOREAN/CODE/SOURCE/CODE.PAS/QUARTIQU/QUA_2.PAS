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
Var  C1,C2,C3 : T_CORD;
Var  Q1,Q2,Q3 : T_Quar;
Var  Color    : Byte  ;

Function Image (Q : T_QUAR;
                C : T_CORD) : LongInt;
BEGIN;
Image:=Q.D2.X*C.X*C.X+Q.D2.Y*C.Y*C.Y+Q.D1.X*C.X+Q.D1.Y*C.Y+Q.D0;
END;

Procedure Init;
Begin;
Q1.D2.X:=1 ;   Q1.D1.X:=1 ;   Q1.D0:=5;
Q1.D2.Y:=1 ;   Q1.D1.Y:=1 ;
Q1.D2.Z:=0 ;   Q1.D1.Z:=0 ;

Q2.D2.X:=1 ;   Q3.D1.X:=1 ;   Q1.D0:=5;
Q2.D2.Y:=1 ;   Q3.D1.Y:=1 ;
Q2.D2.Z:=0 ;   Q3.D1.Z:=0 ;

Q3.D2.X:=1 ;   Q3.D1.X:=1 ;   Q1.D0:=5;
Q3.D2.Y:=1 ;   Q3.D1.Y:=1 ;
Q3.D2.Z:=0 ;   Q3.D1.Z:=0 ;



End;


Procedure Courbe;
Begin;
C1.X:=-20;
C2.X:=-30;
C3.X:=0;

For C.X:=0 To 319 Do Begin;
                     C1.Y:=0;
                     C2.Y:=-100;
                     C3.Y:=0;
                     Inc(C1.X);
                     Inc(C2.X);
                     Inc(C3.X);
For C.Y:=0 To 199 Do Begin;
                     Inc(C1.Y);
                     Inc(C2.Y);
                     Inc(C3.Y);

                     Color:=(Image(Q1,C1)*Image(Q2,C2)) div 07000;
                     PutPixel(C.X,C.Y,Color);
                     end;
                     end;

End;




BEGIN
GraphMode;
Put_Dac(GEST_DAC.blue );
INIT;
COURBE;
Delay(5000);
END.