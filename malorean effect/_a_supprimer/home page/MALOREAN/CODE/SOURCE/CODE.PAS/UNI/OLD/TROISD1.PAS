{$r-}
Unit troisd;

Interface

Uses Math,CGraph;

Type
Ancetre = OBJECT
          Z,Y,X     :  Byte; {les 3 angles}
          Cx,Cy     :  Word;
          D_O       :  Real; {varie avec rotation du centre}
          Xe,Ye     : Array [1..10]   of Integer ;
          Procedure init_angle_obj ;
          Procedure inc_Angle_obj      (a,b,c  : Byte);
          Procedure Config_obj         (nbpt,nbl : Integer;
                                        dobj     : real);
          Procedure init_centre        (a,b      : Integer);
          Procedure inc_centre         (a,b      : ShortInt);
          END;

OObj1      = OBJECT  (Ancetre)

             Z_Face    : ARRAY [1..6] Of LongInt;

             Procedure Matrice (arete : Byte);
             Procedure Ligne;
             Procedure DroiteMin  (X1 : Integer;
                                   Y1 : Byte;
                                   X2 : Integer;
                                   Y2 : Byte);
             Procedure Remplit (X1 : Word;
                                Y1 : byte;
                                X2 : word;
                                Y2 : Byte;
                                X3 : word;
                                Y3 : Byte;
                                X4 : word;
                                Y4 : Byte;
                                Color                   : Byte );
             END;
Var

Buf1   : ^Type_Graph_Ecran;

XMin : Array [0..199] Of WORD;
XMax : Array [0..199] Of WORD;

YMin,Ymax : Byte;
xmi,xma : word; {pour un y donne}
Seg_Xmin,Ofs_Xmin : Word;
Seg_Xmax,Ofs_Xmax : Word;
s,o : Word;
Implementation
{安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安}
Procedure OObj1.Matrice;
Var
Fm1 : Integer;
M1,m2,m3 : Longint;
Begin; {1.0}

arete:=Round(arete/d_o);

M1:=Ca[Y]*Ca[Z]*arete div cmtrigo2;
M2:= -Sa[Z]*Ca[Y]*arete  div cmtrigo2;
M3:= -Sa[Y]         *arete  DIV CmTrigo;


Xe[1]:=(-M1+M2-m3)  +Cx;
Xe[2]:=(+M1+M2-m3)  +Cx;
Xe[3]:=(M1+M2+m3)   +Cx;
Xe[4]:=(-M1+M2+m3)  +Cx;
Xe[5]:=(-M1-M2-m3)  +Cx;
Xe[7]:=(+M1-M2+m3)  +Cx;
Xe[8]:=(-M1-M2+m3)  +Cx;
Xe[6]:=(+M1-M2-m3)  +Cx;

M1:=  ( So[X]*So[Y]*Co[Z]+Co[X]*So2[Z])*arete div CmTrigo3;
M2:=  (Co[X]*Co2[Z]-So[X]*So[Y]*So[Z])*arete  div CmTrigo3;
M3:=  (So[X]*Co[Y]                            *arete ) div CmTrigo2;

Ye[1]:=(-M1+M2-m3)  +Cy;
Ye[2]:=(+M1+M2-m3)  +Cy;
Ye[3]:=(M1+M2+m3)   +Cy;
Ye[4]:=(-M1+M2+m3)  +Cy;
Ye[5]:=(-M1-M2-m3)  +Cy;
Ye[7]:=(+M1-M2+m3)  +Cy;
Ye[8]:=(-M1-M2+m3)  +Cy;
Ye[6]:=(+M1-M2-m3)  +Cy;

M1:= (Co[z]*Co[x]*So[y]-So2[z]*So[x])    ;
M2:=-(So[z]*Co[x]*So[y]+Co2[z]*So2[x])   ;
M3:=+(Co2[y]*Co[x])                      ;

Z_Face[1]:=-((Xe[3]-Xe[4])*(Ye[3]-Ye[7])-(Xe[3]-Xe[7])*(Ye[3]-Ye[4]));
Z_Face[3]:= ((Xe[3]-Xe[2])*(Ye[3]-Ye[7])-(Xe[3]-Xe[7])*(Ye[3]-Ye[2]));
Z_Face[5]:= ((Xe[7]-Xe[6])*(Ye[7]-Ye[8])-(Xe[7]-Xe[8])*(Ye[7]-Ye[6]));
End;
{---------------------------------------------------------------------}
Procedure OObj1.Ligne;
Begin;
If Z_Face[1]<0 Then
Remplit (Xe[3],Ye[3],Xe[4],Ye[4],Xe[8],Ye[8],Xe[7],Ye[7],2)
Else Remplit (Xe[2],Ye[2],Xe[1],Ye[1],Xe[5],Ye[5],Xe[6],Ye[6],3);
If Z_Face[3]<0 Then
Remplit (Xe[2],Ye[2],Xe[3],Ye[3],Xe[7],Ye[7],Xe[6],Ye[6],5)
Else Remplit (Xe[1],Ye[1],Xe[4],Ye[4],Xe[8],Ye[8],Xe[5],Ye[5],6);
If Z_Face[5]<0 Then
Remplit (Xe[5],Ye[5],Xe[6],Ye[6],Xe[7],Ye[7],Xe[8],Ye[8],7)
Else Remplit (Xe[1],Ye[1],Xe[2],Ye[2],Xe[3],Ye[3],Xe[4],Ye[4],8);

End;  {1}
{---------------------------------------------------------------------}
Procedure Oobj1.DroiteMin;
VAR Dx,Dy        : Word;
    Dx2,Dy2      : Word;
    S1,S2        : ShortInt;
    Xi,Yi        : Word;
    Erreur       : Integer;
    Temp         : Word;
    InterChange  : Word;
    F            : Word;

BEGIN;

Xi:=X1;
Yi:=Y1;

If X2>X1 then Dx:=X2-X1 else Dx:=X1-X2;
{Dx:=Abs(X2-X1);}

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
Erreur:=Dy2-Dx;

For F:=1 To Dx Do Begin;

If XMin[Yi]=0 then XMin[Yi]:=XI else If Xi<XMin[Yi] then XMin[Yi]:=Xi;
If XMax[Yi]=0 then XMax[Yi]:=XI else If Xi>XMax[Yi] then XMax[Yi]:=Xi;


{                  Buf1^[t[yi]+Byte(xi)]:=7;       }
                  If Interchange=1 then Begin;
                                        While Erreur>=0 Do Begin;
                                                           Inc(Xi,S1);
                                                           dec(Erreur,Dx2);
                                                           End;
                                       Inc(Yi,S2)
                                       end
                                  else begin
                                       While Erreur>=0 Do Begin;
                                                          Inc(Yi,S2);
                                                          dec(Erreur,Dx2);
                                                          End;
                                      Inc(Xi,S1);
                                      end;
                  Inc(Erreur,Dy2);
If XMin[Yi]=0 then XMin[Yi]:=XI else If Xi<XMin[Yi] then XMin[Yi]:=Xi;
If XMax[Yi]=0 then XMax[Yi]:=XI else If Xi>XMax[Yi] then XMax[Yi]:=Xi;
                  End;


END;
{--------------------------------------------------------------------------}

PROCEDURE OObj1.REMPLIT;
VAR F : Byte;
ff : Byte;
    Ofsetg : Word;
BEGIN;

ASM;
PUSH ES        {for f:=0 to 199 do XMin[f]:=0
                for f:=0 to 199 do XMax[f]:=0; }
PUSH DI
MOV ES,Seg_Xmin;
MOV DI,Ofs_XMin;
MOV DS,Seg_Xmax;
MOV SI,Ofs_Xmax;
MOV AX,0;
MOV BX,Di
ADD BX,400;  {ofset X_Min +199*2 because tableau de word }
MOV CX,Si
ADD CX,400;  {ofset X_Max +199*2 because tableau de word }
@DebutFor:   ;
CMP DI,BX;
JA @Fin
MOV ES:[DI],AX;
MOV DS:[SI],AX;
ADD DI,2;
ADD SI,2;
JMP @DebutFor
@Fin:
POP DI
POP ES
end;


DroiteMin(X1,Y1,X2,Y2);
DroiteMin(X2,Y2,X3,Y3);
DroiteMin(X3,Y3,X4,Y4);
DroiteMin(X1,Y1,X4,Y4);


If Y1<Y2 Then Begin; YMin:=Y1; YMax:=Y2; End
         Else Begin; YMin:=Y2; YMax:=Y1; End;
If YMin>Y3 Then YMin:=Y3;
If YMAx<Y3 Then YMax:=Y3;
If YMin>Y4 Then YMin:=Y4;
If YMAx<Y4 Then YMax:=Y4;

For ff:=(YMin+1) to (YMax-1) do Begin;
                                ofsetg:=t[ff];
                                XMi:=XMIN[ff];
                                XMa:=XMax[ff];
                                ASM;
    {For f:=XMin[ff] To XMax[ff] Do Buf1^[Ofsetg+f]:=Color;}
                                PUSH ES;
                                PUSH DI;
                                MOV Cl,COLOR
                                MOV Ch,COLOR
                                MOV ES,S
                                MOV DI,O
                                MOV AX,DI
                                ADD DI,XMi
                                ADD DI,OfsetG {for f:=a to b ici a calculer a}
                                ADD AX,Xma
                                ADD AX,OfsetG {for f:=a to b ici a calculer b}

                                @DebutFor:
                                CMP DI,AX
                                JA @FinFor
                                MOV ES:[DI],CX
                                ADD DI,2
                                JMP @DebutFor
                                @FinFor:
                                Dec DI
                                CMP DI,AX
                                JA @FinFor2
                                Mov ES:[Di],Cl
                                @FinFor2:
                                POP DI;
                                POP ES;
                                end;

                                 end;
END;
{安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安}
Procedure Ancetre.Inc_angle_obj;
Begin;
X:=X+a;
Y:=Y+b;
Z:=Z+c;
X:=X and 255;
Y:=Y AND 255;
Z:=Z AND 255;
End;
{安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安}
Procedure Ancetre.init_Angle_Obj;
Begin;
X:=0;
Y:=0;
Z:=0;
End;
{安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安}
Procedure Ancetre.Init_Centre;
Begin;
Cx:=a;
Cy:=b;
End;
{安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安}
Procedure Ancetre.Inc_Centre;
Begin;
Cx:=Cx+a;
Cy:=Cy+b;
End;
{安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安}
Procedure Ancetre.Config_Obj;
Begin;
d_o  :=dobj;
End;

{安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安皚
begin;
new(buf1);
Seg_XMin:=Seg(XMin);
Ofs_XMin:=Ofs(XMin);
Seg_XMax:=Seg(XMax);
Ofs_XMax:=Ofs(XMax);
s:=Seg(Buf1^);
o:=Ofs(buf1^);
End.







































For F:=1 To Dx Do Begin;
                  If Xmin[Yi]=0 Then XMin[Yi]:=Xi Else XMax[Yi]:=Xi;

                  While Erreur>=0 Do Begin;
                                     If InterChange=1 Then Inc(Xi,S1)
                                                      Else Inc(Yi,S2);
                                     dec(Erreur,Dx2);
                                     End;
                  If InterChange=1 Then Inc(Yi,S2)
                                   Else Inc(Xi,S1);
                  Inc(Erreur,Dy2);
                  End;