Uses CGraph,Math,Crt,gest_dac;

Var  Vga   : TgraphVga;
     Angle : Word;
     F,f1     : Word;
     X,Y   : Byte;
     Cx,Cy  : Word;
     AngleCentre : Word;
     s,c : Array [0..360] of Longint;

Procedure Line (x1,y1,x2,y2,c : Byte);
VAR Dx,Dy        : Byte;
    Dx2,Dy2      : Byte;
    S1,S2        : ShortInt;
    X,Y          : Word;
    Erreur       : Integer;
    Temp         : Byte;
    InterChange  : Byte;
    F            : Byte;
    VGA          : TGraphVga;
    compteur: byte;

BEGIN;
compteur:=1;

X:=X1;
Y:=Y1;

Dx:=Abs(X2-X1);
Dy:=Abs(Y2-Y1);

If X2-X1=0 Then S1:=0;
If X2-X1>0 Then S1:=1;
If X2-X1<0 Then S1:=-1;

If Y2-Y1=0 Then S2:=0;
If Y2-Y1>0 Then S2:=1;
If Y2-Y1<0 Then S2:=-1;

If Dy>Dx Then Begin;
              Temp        := Dx;
              Dx          := Dy;
              Dy          := Temp;
              InterChange := 1;
              End
              Else InterChange :=0;

Dx2:=Dx Shl 1;
Dy2:=Dy Shl 1;

Erreur:=Dy2 -Dx;

For F:=1 To Dx Do Begin;
                  Inc(compteur,1);
               If y>1 then     Vga_Ecran [t[y]+x]:=  Vga_Ecran [t[y]+x] + c;

                  While Erreur>=0 Do Begin;
                                     If InterChange=1 Then Inc(X,S1)
                                                      Else Inc(Y,S2);
                                     dec(Erreur,Dx2);
                                     End;
                  If InterChange=1 Then Inc(Y,S2)
                                   Else Inc(X,S1);
                  Inc(Erreur,Dy2);
                  End;

END;



BEGIN;
VGA.GraphMode;
put_dac(pal4);

for f:=0 to 360 do Begin;
                    S[f]:=Round(10*R^.S[f]);
                    C[f]:=Round(10*R^.C[f]);
                    end;


Angle:=0;
For F:=1 To 200 Do Begin;
                    Inc(AngleCentre,1);
                    Cx:=6*c[AngleCentre] ;
                    Cy:=6*s[AngleCentre] ;

For f1:=1 to 30 do begin;
                    Inc(Angle,2);
                    X:=C[Angle] ;
                    Y:=S[Angle] ;
                    Line(X+cx+160,Y+cx+100,-X+cx+160,-Y+cy+100,7);
                    If Angle>360 then Angle:=0;
                    end;
                    If AngleCentre>360 then AngleCentre:=0;
                    delay(10);
                    end;
delay(1000);
END.
