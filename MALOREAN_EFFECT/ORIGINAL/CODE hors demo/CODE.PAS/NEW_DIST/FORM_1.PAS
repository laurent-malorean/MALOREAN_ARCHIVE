USES DAC_CODE,DAC_FRAC,GEST_GRAPH,CRT;


Function DIST (X1,Y1,X2,Y2 : WORD ) : Real ;
Begin;   DIST:=SQRT( ABS( SQR(X2-X1) + SQR (Y2-Y1) ) ); End;

Procedure Image;
VAR        X,Y : Word;
VAR        C   : Byte;
BEGIN;
For X:=0 to 319 Do
  For Y:=0 to 199 Do begin;
                     C:=Round( Dist(X,Y,0,0) *Cos(Dist(X,Y,0,0)) /85 );
                     PutPixel(X,Y,C);
                     End;
END;


BEGIN; GraphMode;
       PUT_DAC (PAL4);
       Image;
       Delay(5000);
END.