USES DAC_CODE,DAC_FRAC,GEST_GRAPH,CRT;


Function DIST (X1,Y1,X2,Y2 : Real ) : Real ;
Begin;   DIST:=SQRT( ABS( SQR(X2-X1) + SQR (Y2-Y1) ) ); End;

Procedure Image;
VAR        X,Y   : Word;
VAR        C     : Byte;
VAR        Tx,Ty : Array[0..350] of Real;
Var        Xmin,Xmax,Ymin,Ymax : Real;
BEGIN;
Xmin:=0;
Xmax:=1;
Ymin:=0;
Ymax:=1;
For X:=0 to 319 Do Tx[X]:=Xmin+(Xmax-Xmin)/320*X;
For Y:=0 to 199 Do Ty[Y]:=Ymin+(Ymax-Ymin)/200*Y;

For X:=0 to 319 Do
  For Y:=0 to 199 Do begin;
                     C:=Round(25* Dist(Tx[X],Ty[Y],0,0) *Cos(25*Dist(Tx[X],Ty[Y],0,0))  );
                     PutPixel(X,Y,C);
                     End;
END;


BEGIN; GraphMode;
       PUT_DAC (PAL4);
       Image;
       Delay(5000);
END.