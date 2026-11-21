{$r-}
Unit G_R;

Interface

Uses Gest_Graph,Gest_Dac,MAth,crt;

Type
Ancetre = OBJECT
          _Cx,_Cy,_Cz : Word;

          Z,Y,X     :  Byte; {les 3 angles de l'obj}
          Xc,Yc,Zc  :  Byte; {les 3 angles du centre}
          Rc        :  Byte; {rayon du centre pour la rotation}
          Cx,Cy     :  Word;
          D_O       :  Real; {varie avec rotation du centre}
          Xe,Ye     : Array [1..10]   of Integer ;
          _Xe,_Ye     : Array [1..10]   of Integer ; {les anciennes coordonnees}

          Procedure init_angle_obj ;
          Procedure inc_Angle_obj      (a,b,c  : Byte);
          Procedure init_angle_Centre  (a,b,c,_Rc     : Byte);
          Procedure inc_Angle_centre      (a,b,c  : Byte);

          Procedure init_centre        (a,b      : Integer);
          Procedure inc_centre         (a,b      : ShortInt);
          END;

OObj1      = OBJECT  (Ancetre)
             Z_Face    : ARRAY [1..6] Of LongInt;
             Procedure Matrice (arete : byte);
             END;

Implementation
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
Procedure OObj1.Matrice;
Var
Fm1 : Integer;
M1,m2,m3 : Longint;

Begin; {1.0}


_Cx:=Cx-(Ca[Xc] shr 2);
_Cy:=Cy+(Sa[Yc+Xc] shr 2);

M1:=  Ca[Z]*arete Div CmTrigo;
M2:= -Sa[Z]*arete Div CmTrigo;

Xe[1]:=(-M1+M2)  +_Cx;
Xe[2]:=(+M1+M2)  +_Cx;
Xe[3]:=Xe[2];
Xe[4]:=Xe[1];
Xe[5]:=(-M1-M2)  +_Cx;
Xe[7]:=(+M1-M2)  +_Cx;
Xe[8]:=Xe[5];
Xe[6]:=Xe[7];

M1:=  ( Co[X]*So[Z])*arete div CmTrigo2;
M2:=  (Co[X]*Co[Z])*arete  div CmTrigo2;
M3:=  So[X]*arete  Div CmTrigo;

Ye[1]:=(-M1+M2-m3)  +_Cy;
Ye[2]:=(+M1+M2-m3)  +_Cy;
Ye[3]:=(M1+M2+m3)   +_Cy;
Ye[4]:=(-M1+M2+m3)  +_Cy;
Ye[5]:=(-M1-M2-m3)  +_Cy;
Ye[7]:=(+M1-M2+m3)  +_Cy;
Ye[8]:=(-M1-M2+m3)  +_Cy;
Ye[6]:=(+M1-M2-m3)  +_Cy;

Droite (Xe[1],Ye[1],Xe[2],Ye[2],2);
Droite (Xe[2],Ye[2],Xe[3],Ye[3],2);
Droite (Xe[3],Ye[3],Xe[4],Ye[4],2);
Droite (Xe[4],Ye[4],Xe[1],Ye[1],2);
Droite (Xe[5],Ye[5],Xe[6],Ye[6],2);
Droite (Xe[6],Ye[6],Xe[7],Ye[7],2);
Droite (Xe[7],Ye[7],Xe[8],Ye[8],2);
Droite (Xe[8],Ye[8],Xe[5],Ye[5],2);
Droite (Xe[1],Ye[1],Xe[5],Ye[5],2);
Droite (Xe[2],Ye[2],Xe[6],Ye[6],2);
Droite (Xe[3],Ye[3],Xe[7],Ye[7],2);
Droite (Xe[4],Ye[4],Xe[8],Ye[8],2);
End;  {1}
{---------------------------------------------------------------------}

{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
Procedure Ancetre.Inc_angle_obj;
Begin;
X:=X+a;
Y:=Y+b;
Z:=Z+c;
X:=X and 255;
Y:=Y AND 255;
Z:=Z AND 255;
End;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
Procedure Ancetre.init_Angle_Obj;
Begin;
X:=0;
Y:=0;
Z:=0;
End;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
Procedure Ancetre.Init_Centre;
Begin;
Cx:=a;
Cy:=b;
End;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
Procedure Ancetre.Inc_Centre;
Begin;
Cx:=Cx+a;
Cy:=Cy+b;
End;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
Procedure Ancetre.Inc_angle_Centre;
Begin;
Xc:=Xc+a;
Yc:=Yc+b;
Zc:=Zc+c;
End;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
Procedure Ancetre.init_Angle_centre;
Begin;
Rc:=_Rc;
Xc:=a;
Yc:=b;
Zc:=c;
End;

begin;
GraphMode;
End.
