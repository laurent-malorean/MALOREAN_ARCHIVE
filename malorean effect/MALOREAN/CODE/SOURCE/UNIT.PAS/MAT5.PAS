{ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                      ■
; ■                       DEMO MATHEMATICA 5                             ■
; ■                                                                      ■
; ■                      1993 MALOREAN EFFECT                            ■
; ■                                                                      ■
; ■     CREDIT POUR LA DEMO :  Volpone : CODE                            ■
; ■                            Toto    : Idees sur la manipulation des   ■
; ■                                         quartiques                   ■
; ■                                                                      ■
; ■       RELEASE : Decembre 1993                                        ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■}

USES GEST_GRAPH,DAC_CODE,DAC_TOTO,DAC_FRAC,CRT,CSCREEN,VARIABLE;

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
Var  C1,C2,C3 : T_CORD;
Var  Color    : Byte  ;

Function Image (Q : T_QUAR) : LongInt;
BEGIN;
Image:=Q.D2.X*C.X*C.X+Q.D2.Y*C.Y*C.Y+Q.D1.X*C.X+Q.D1.Y*C.Y+Q.D0;
END;


Procedure Quart_1;
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

For C.X:=0 To 319 Do
For C.Y:=0 To 199 Do Begin;
                     Color:=(Image(Q1)*Image(Q2)) div 10000;
                     PutPixel(C.X,C.Y,Color);
                     end;

End;
{------------------------------------------------------------------------}
Procedure Quart_2;
Begin;
Q1.D2.X:=1 ;   Q1.D1.X:=0 ;   Q1.D0:=5;
Q1.D2.Y:=3 ;   Q1.D1.Y:=2 ;
Q1.D2.Z:=0 ;   Q1.D1.Z:=0 ;

Q2.D2.X:=4 ;   Q3.D1.X:=7 ;   Q1.D0:=5;
Q2.D2.Y:=3 ;   Q3.D1.Y:=-4;
Q2.D2.Z:=0 ;   Q3.D1.Z:=0 ;

Q3.D2.X:=8 ;   Q3.D1.X:=-7;   Q1.D0:=5;
Q3.D2.Y:=-9;   Q3.D1.Y:=-2;
Q3.D2.Z:=0 ;   Q3.D1.Z:=0 ;

For C.X:=+0   To 159 Do
For C.Y:=+0   To 99  Do Begin;
                     Color:=((Image(Q1)+Image(Q2))*Image(Q3)) div 3000000 ;
                     PutPixel(C.X+160,C.Y+100,Color);
                     PutPixel(C.X+160,-C.Y+100,Color);
                     PutPixel(-C.X+160,C.Y+100,Color);
                     PutPixel(-C.X+160,-C.Y+100,Color);
                     end;

End;
{------------------------------------------------------------------------}
Procedure QUART_3;
Begin;
Q1.D2.X:=1 ;   Q1.D1.X:=0 ;   Q1.D0:=5;
Q1.D2.Y:=3 ;   Q1.D1.Y:=0 ;
Q1.D2.Z:=0 ;   Q1.D1.Z:=0 ;

Q2.D2.X:=-2 ;   Q3.D1.X:=0  ;   Q1.D0:=15;
Q2.D2.Y:=5 ;   Q3.D1.Y:=0   ;
Q2.D2.Z:=0 ;   Q3.D1.Z:=0 ;

Q3.D2.X:=1 ;   Q3.D1.X:=1 ;   Q1.D0:=-5;
Q3.D2.Y:=1 ;   Q3.D1.Y:=1 ;
Q3.D2.Z:=0 ;   Q3.D1.Z:=0 ;

For C.X:=0 To 319 Do
For C.Y:=0 To 199  Do Begin;
                     Color:=((Image(Q1)*Image(Q2))) div 10000000;
                     PutPixel(C.X,C.Y,Color);
                     end;

End;


{------------------------------------------------------------------------}
Procedure QUAD_1;
Function Image (Q : T_QUAR;
                C : T_CORD) : LongInt;
BEGIN;
Image:=Q.D2.X*C.X*C.X+Q.D2.Y*C.Y*C.Y+Q.D1.X*C.X+Q.D1.Y*C.Y+Q.D0;
END;

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

C1.X:=0;
C2.X:=0;
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

                     Color:=(Image(Q1,C1)*Image(Q2,C2)) div 10000;
                     PutPixel(C.X,C.Y,Color);
                     end;
                     end;

End;
{------------------------------------------------------------------------}
PROCEDURE PAGE_CREDIT;
VAR WIN1  : OBJWIN;
VAR    TEXT                                   : TTEXT;

BEGIN;

ASM; MOV AX,3; INT 10h; END;
TEXT.FOND_ECRAN(ECRAN,BLANC,BRUN);
TEXT.WRITE(ECRAN,1,1,BLANC,BLEU,'                      MALOREAN EFFECT  : "MATEMATICA 5"                         ');
TEXT.WRITE(ECRAN,1,25,BLANC,BLEU,'                         RELEASE : DECEMBER 1993                                ');
WIN1.WIN4 (ECRAN,'CREDIT FOR THE DEMO',10,5,70,22,BLANC,BLEU,MAGENTA);
TEXT.WRITE(ECRAN,24,07,BLANC,MAGENTA,'VOLPONE          : CODE ');
TEXT.WRITE(ECRAN,24,09,BLANC,MAGENTA,'TOTO             : Idea for some Images  ');

TEXT.WRITE(ECRAN,10,11,BLANC,BLEU,'                      SHAREWARE CREDIT                       ');
TEXT.WRITE(ECRAN,12,13,BLANC,MAGENTA,'PALETTES         : ALL PALETTES ARE RIPED FROM FRACTINT');
TEXT.WRITE(ECRAN,12,14,BLANC,MAGENTA,'PALETTES         :                     AND TOTO''S CODE');
TEXT.WRITE(ECRAN,12,15,BLANC,MAGENTA,'SCREEN CAPTURE   : SHOOT 2 By PHAM CONG-DUC ');

TEXT.WRITE(ECRAN,10,18,BLANC,BLEU,'                           HELLO TO                          ');
TEXT.WRITE(ECRAN,12,20,BLANC,MAGENTA,'Fbi,Silk,Weg,TmB,42 Crew,Sally,Jurassique Marc,Sun,Redlight');
TEXT.WRITE(ECRAN,12,21,BLANC,MAGENTA,'Mc2,Locked,Fafa');

PULSE:=0; REPEAT; UNTIL PULSE=250;
Clrscr;
END;


{------------------------------------------------------------------------}


BEGIN
GraphMode;
loadShoot('data.000'); Delay(5000);
cls(0); Put_Dac(TOTO17);          Quart_1;   Delay(5000);
cls(0); Put_Dac(Dac_Frac.Blue);   Quart_2;   Delay(5000);
cls(0); Put_Dac(Dac_Frac.Blue);   Quart_3;   Delay(5000);
cls(0); Put_Dac(TOTO17);          Quad_1 ;   Delay(5000);
loadShoot('data.001'); Delay(5000);
PAGE_CREDIT;
END.