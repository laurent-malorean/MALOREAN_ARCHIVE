{-------- Unité Gestion Clavier en Objet  (C) Cédric Pulrulczyk ----------}
Unit Gest_souris;

{$F+}
{$O+}

Interface
{------------------------------------------------------------------------}
Type TSouris=Object

Affichee :Boolean;
Gerer    :Boolean;
Procedure Init;
Procedure Montrer;
Procedure Cacher;
Procedure Etat      (Var So1,So2,So3:Boolean;
                     Var XSo,YSo:Integer);
Function Clip      (XSo,YSo,
                    X,Y,
                    LgX,LgY:Integer):Boolean;
End;
{------------------------------------------------------------------------}

Implementation
Uses crt,dos;
Const IntSouris=$33;

{------------------------------------------------------------------------}
Procedure TSouris.Init;

Var R:Registers;
Begin
  R.AX:=$0000;
  Affichee:=False;
  Intr(IntSouris,R);
  If R.AX=$FFFF Then Gerer:=True Else Gerer:=False;
End;

{------------------------------------------------------------------------}
Procedure TSouris.Montrer;

Var R:Registers;
Begin
  If Gerer Then
    Begin
       R.AX:=$0001;
       Intr(IntSouris,R);
       Affichee:=True;
    End;
End;

{------------------------------------------------------------------------}
Procedure TSouris.Cacher;

Var R:Registers;
Begin
  If Gerer Then
     Begin
       R.AX:=$0002;
       Intr(IntSouris,R);
       Affichee:=False;
     End;
End;

{------------------------------------------------------------------------}
Procedure TSouris.Etat(Var So1,So2,So3:Boolean;
                     Var XSo,YSo:Integer);

Var R:Registers;
Begin
   R.AX:=$0003;
   Intr(IntSouris,R);
   So1:=(R.BX And 1)<>0;
   So2:=(R.BX And 4)<>0;
   So3:=(R.BX And 2)<>0;
   XSo:=Trunc(R.CX/8)+1;
   YSo:=Trunc(R.DX/8)+1;
End;

{------------------------------------------------------------------------}
Function TSouris.Clip(XSo,YSo,
                    X,Y,
                    LgX,LgY:Integer):Boolean;

Begin
Clip:=(XSo>=X) And (XSo<=X+LgX) And
            (YSo>=Y) And (YSo<=Y+LgY);
End;
{------------------------------------------------------------------------}
{------------------------------------------------------------------------}

End.