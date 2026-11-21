USES DAC_CODE,DAC_FRAC,GEST_GRAPH,CRT;

{**************************************************************************}

Function DIST (X1,Y1,X2,Y2 : Word ) : Real ;
Begin;   DIST:=SQRT( ABS( SQR(X2-X1) + SQR (Y2-Y1) ) ); End;

{**************************************************************************}

Function Moy_CL  (X,Y : Word) : Real;
VAR Xi,Yi  : Word;
VAR Inter  : Real;
Begin;
Inter:=0;
For Xi:=0 to 319 do
    For Yi:=0 to 199 Do inter:=Inter+(Getpixel(Xi,Yi)*Dist(X,Y,Xi,Yi));
    Moy_CL:=Inter;
End;

{**************************************************************************}

Function Moy_C   : Real;
VAR Xi,Yi  : Word;
VAR Inter  : Real;
Begin;
Inter:=0;
For Xi:=0 to 319 do
    For Yi:=0 to 199 Do inter:=Inter+Getpixel(Xi,Yi);
    Moy_C:=Inter;
End;

{**************************************************************************}

Function Moy_L  (X,Y : Word) : Real;
VAR Xi,Yi  : Word;
VAR Inter  : Real;
Begin;
Inter:=0;
For Xi:=0 to 319 do
    For Yi:=0 to 199 Do inter:=Inter+Dist(X,Y,Xi,Yi);
    Moy_L:=Inter;
End;

{**************************************************************************}

Procedure Image;
VAR        X,Y,Z   : Word;
VAR        Xpt,Ypt : Word;
VAR        C       : Byte;

BEGIN;
For Z:=1 to 2 Do Begin;
                  X:=Random(320);
                  Y:=Random(200);
                  C:=Random(250);
                  PutPixel(X,Y,C);
                  End;{for z}

For Z:=1 to 5000 Do Begin;
                    X:=Random(320);
                    Y:=Random(200);
                    C:=Round( Moy_CL(X,Y) ); {  / (MOY_C*MOY_L(X,Y))) ;}
{                    If C<>0 then Sound(500);
                    delay(100);
                    nosound;}
                    PutPixel(X,Y,C);
                    End;{for z}
END;


BEGIN; GraphMode;
       PUT_DAC (PAL4);
       Image;
       Delay(5000);
END.