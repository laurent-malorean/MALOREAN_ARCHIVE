Unit CScreen;

INTERFACE


USES DOS,Crt;

Const   Noir    =0;
        Bleu    =1;
        Vert    =2;
        Cyan    =3;
        Rouge   =4;
        Magenta =5;
        Brun    =6;
        Blanc   =7;
        Gris    =8;


TYPE    Typee = (caractere,couleur);
        Type_text_Ecran = array [1..25,1..80,Caractere..couleur] Of Byte;

        TState =(alume,eteint);
        TextButton = String[7];
        TypeContenu= Array[0..50] Of String[60];
        Tm = Array [0..150,0..150] of word;
        TypeContenuWinauto =Array[1..22] Of String [45];

Rmouse      = RECORD
              X  : Byte;
              Y  : Byte;
              B  : Byte;
              END;

ObjMouse    = OBJECT
               Procedure Init;
               Procedure Show;
               Procedure Erase;
               Procedure GoToXY(X,Y    : Byte);
               Procedure Limite (xmin,xmax,ymin,ymax  :integer);
               Function  WhereX : Integer;
               Function  WhereY : Integer;
               Function  Click  : Integer;
               End;


TTEXT    = OBJECT (ObjMouse)
           Procedure Erase_Curseur;
           Procedure Show_Curseur;
           Procedure Write (Var Buffer_ecran         : Type_Text_Ecran ;
                                X,Y,Color,Background : Byte;
                                Message              : String);

           Procedure Cls           (Color      : Byte );
           Procedure Clear_Buffer  (Var Buffer_ecran         : Type_Text_Ecran;
                                        Couleur_Fond         : Byte  ) ;
           Procedure Fond_ecran    (Var Buffer_ecran         : Type_Text_Ecran;
                                     Couleur_ecriture,couleur_fond : Byte) ;
           Procedure Ligne         (Var Buffer_ecran         : Type_Text_Ecran;
                                     Y,Couleur_ligne : Byte);
           Procedure TextScrool  (Texte                    : String;
                                   XMin,XMax                : Byte;
                                   Y                        : Byte;
			           Couleur_ecriture,
                                   Couleur_Fond             : Byte);
           Function HowColor     (Buffer_ecran         : Type_Text_Ecran;
                                  X,Y                  : Byte) : Integer;
           Function HowBackGround (Buffer_ecran         : Type_Text_Ecran;
                                  X,Y                  : Byte) : Byte;

           Procedure BackColor( Color : Byte);
           Procedure ColorBackground (X,y   : Byte;
                                     Color,Background,clignote : Byte);
           Procedure InvCli          (X,y   : Byte);
           Procedure InvNoCli          (X,y   : Byte);

           END;


ObjButton     = OBJECT (TText)
                {variable pour le bouton}
                Xb,Yb : Byte;
                Message : String[7];
                Ce,Cf   : Byte ;
                Cfond   : Byte ;
                Long    : Byte;
                Procedure Util1 (Var Buffer  : Type_text_Ecran);
                Procedure Util2 (Var Buffer  : Type_text_Ecran);
                Procedure Init  (Var Buffer  : Type_text_Ecran;
                                    X,Y,Ced,Cfd      : Byte;
                                    Mess             : TextButton    );
                Procedure Show  ( Var Buffer : Type_Text_Ecran);
                Function  State : TState;
                END;


ObjExit       = OBJECT (TText)
                {Variables pour l'icone de sortie}
                Xe,Ye   : Byte;
                Procedure Show (Var Buffer_ecran     : Type_Text_Ecran;
                                    X,Y,Ced,Cfd      : Byte);
                Function  State : TState;
                END;

AncetreObjWin = OBJECT (TText)
                Procedure Shadow (Var Buffer_ecran                   : Type_Text_Ecran;
                                      xmin,ymin,xmax,ymax            : Byte);

                End;

ObjWin     = OBJECT (AncetreObjWin)
           Procedure Win1         (Var Buffer_ecran                   : Type_Text_Ecran;
                                       xmin,ymin,xmax,ymax            : Byte;
                                       Couleur_ecriture,Couleur_Fond  : Byte);

           Procedure Win2         (Var Buffer_ecran                   : Type_Text_Ecran;
                                       xmin,ymin,xmax,ymax            : Byte;
                                       Couleur_ecriture,Couleur_Fond  : Byte);

           Procedure Win3         (Var Buffer_ecran                   : Type_Text_Ecran;
                                       Message                        : String;
                                       xmin,ymin,xmax,ymax            : Byte;
                                       Couleur_ecriture_Ligne,
                                       Couleur_Fond_Ligne,
                                       Couleur_Fond_Fenetre            : Byte);
           Procedure Win4         (Var Buffer_ecran                   : Type_Text_Ecran;
                                       Message                        : String;
                                       xmin,ymin,xmax,ymax            : Byte;
                                       Couleur_ecriture_Ligne,
                                       Couleur_Fond_Ligne,
                                       Couleur_Fond_Fenetre            : Byte);
             End;


ObjWinAuto    = OBJECT (ObjWin)
                Xmin : Byte;
                Ymin : Byte;
                Hauteur : Byte;
                Messag : String;
                Contenu : TypeContenuWinauto;
                Longeur : Byte;
                Couleur_langue_ecriture  : Byte;
                Couleur_langue_fond      : byte;
                Couleur_fenetre_ecriture : byte;
                Couleur_fenetre_fond     : byte;
                NoInv                    : Byte;


                Procedure Init(I_Xmin    : Byte;
                               I_Ymin    : Byte;
                               I_Hauteur : Byte;
                               I_Couleur_langue_ecriture  : Byte;
                               I_Couleur_langue_fond      : byte;
                               I_Couleur_fenetre_ecriture : byte;
                               I_Couleur_fenetre_fond     : byte;
                               I_Message : String;
                               I_Contenu : TypeContenuWinauto );

               Procedure Show (Var Buffer_ecran     : Type_Text_Ecran);
               Function  State : ShortInt;

                END;

ObjWinMenuD   = OBJECT (AncetreObjWin)
                Xmin : Byte;
                Ymin : Byte;
                Hauteur : Byte;
                Contenu : TypeContenuWinauto;
                Longeur : Byte;
                Color : byte;
                BackGround   : byte;
                NoInv                    : Byte;


                Procedure Init(I_Xmin    : Byte;
                               I_Ymin    : Byte;
                               I_Hauteur : Byte;
                               I_Couleur : byte;
                               I_BackGround     : byte;
                               I_Contenu : TypeContenuWinauto );

               Procedure Show ;
               Function  State : Byte;
               END;



ObjElevator   = OBJECT (ObjWin)
                    NB_Colone             : byte;
                    Hauteur_colone        : byte;
                    Largeur_colone        : Byte;
                    Xmin,Ymin             : Byte;
                    Couleur_ecriture      : Byte;
                    Couleur_Fond          : Byte;
                    Couleur_fenetre       : Byte;
                    Couleur_ligne_fenetre : Byte;
                    Mess                  : String;
                    NbContenu             : Word;
                    Contenu               : Typecontenu;
                    First                 : Word;
                    noInv                 : word;

                Procedure init (I_Nb_Colone              : Byte;
                                i_Largeur_Colone         : Byte;
                                I_Hauteur_Colone         : Byte;
                                I_Xmin,I_Ymin            : Byte;
                                I_Couleur_ecriture       : Byte;
                                I_Couleur_Fond           : Byte;
                                I_Couleur_fenetre        : Byte;
                                I_Couleur_ligne_fenetre  :Byte;
                                I_Mess                   : String;
                                I_Contenu                : Typecontenu;
                                I_NbContenu              : Word );

                Procedure ShoW (Var Buffer_ecran     : Type_Text_Ecran);

                Function State  : Word ;

                Procedure Util1;

                END;




Var   Ecran          : Type_Text_Ecran ABSOLUTE $B800:$0000;
      INTERNE1       : Type_Text_Ecran ABSOLUTE $B800:4480;
      INTERNE2       : Type_Text_Ecran ABSOLUTE $B800:8960;
      INTERNE3       : Type_Text_Ecran ABSOLUTE $B800:13440;

      Reg            : Registers;


Procedure MovEcran (Var Destination   : Type_text_ecran;
                        Source        : Type_Text_Ecran);
Procedure  Mouse_State (Var T : Rmouse );

IMPLEMENTATION
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
PROCEDURE Mouse_State;
VAR       Mouse : ObjMouse;
BEGIN;
T.X :=Mouse.WhereX;
T.Y :=Mouse.WhereY;
T.B :=Mouse.Click;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
Procedure MovEcran;
VAR      Mouse : ObjMouse;
Begin;
Mouse.Erase;
Destination:=Source;
Mouse.Show;
End;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
Procedure OBjMouse.Init;
BEGIN;    ASM
          MOV AX,$0000;
          INT ($33);
          END;
END;
{-------------------------------}
Procedure OBjMouse.Show;
BEGIN;    ASM
          MOV Ax,$1;
          INT ($33);
          END;
END;
{-------------------------------}
Procedure ObjMouse.Erase;
BEGIN;    ASM
          MOV Ax,$2;
          INT ($33);
          END;
END;
{-------------------------------}
PROCEDURE ObjMouse.GoToXY;

BEGIN;   reg.ax:=4;
         reg.dx:=y;
         reg.cx:=x;
         intr($33,registers(reg));
END;
{-------------------------------}
PROCEDURE ObjMouse.Limite;
BEGIN;   reg.ax:=8;
         reg.dx:=(xmin*8);
         reg.cx:=(ymin*8);
         intr($33,registers(reg));
         reg.ax:=7;
         reg.dx:=(xmax*8);
         reg.cx:=(ymax*8);
         intr($33,registers(reg));
END;
{-------------------------------}
Function ObjMouse.WhereX;
var
psg    : longint;
begin;
reg.ax:=3;
intr($33,registers(reg));
psg:=reg.cx;
psg:=(psg div 8)+1;
WhereX:=psg;
end;
{-------------------------------}
function ObjMouse.WhereY;
var
psg    : longint;
begin;
reg.ax:=3;
intr($33,registers(reg));
psg:=reg.dx;
psg:=(psg div 8)+1;
WhereY:=psg;
end;
{-------------------------------}
function ObjMouse.Click;
begin;
reg.ax:=3;
intr($33,registers(reg));
Click:=reg.bx;
end;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
Procedure TText.BackColor;
Var       Reg : Registers;
Begin;
Reg.AH:=$0b;
Reg.BH:=$00;
Reg.Bl:=Color;
Intr($10,Registers(Reg));
End;
{--------------------------------------------------------------------------}
Function TText.HowColor;
BEGIN;
HowColor:=Buffer_Ecran[Y,X,Couleur]- Buffer_Ecran[Y,X,Couleur] Shr 4;
END;
{--------------------------------------------------------------------------}
Function TText.HowBackGround;
BEGIN;
HowBackground:=Buffer_Ecran[Y,X,Couleur] Shr 4 -Buffer_Ecran[Y,X,Couleur] Shr 8;
END;
{--------------------------------------------------------------------------}
Procedure TText.Cls  (color : Byte);
BEGIN;
          Reg.ah:=$06;
          Reg.al:=0;
          Reg.bh:=color Shl 4;
          Reg.ch:=0;
          Reg.cl:=0;
          Reg.dh:=24;
          Reg.dl:=80;
          Intr($10,registers(reg));
END;
{--------------------------------------------------------------------------}
Procedure TText.Write;
Var   Mouse : ObjMouse;
F : Integer;
Attribut : Byte;
Begin;
message:=message+('Æ');
f:=0;
Mouse.Erase;
Attribut:=Color+BackGround shl 4 +8;
Repeat;
Buffer_ecran [Y,X+F,caractere]:=ord(message[f+1]);
Buffer_ecran [Y,X+F,couleur]:=Attribut;
f:=f+1;
Until (message [f+1]=('Æ')) or (X+F>80) ;
Mouse.Show;
End;
{--------------------------------------------------------------------------}
Procedure TText.Clear_Buffer;
Var
X,Y : Byte;
Begin;
For Y:=1 to 25 Do
For X:=1 To 80 Do Begin;
Buffer_ecran[Y,X,Couleur]:=Couleur_Fond Shl 4 +couleur_fond;
Buffer_ecran[Y,X,Caractere]:=32;
End;
End;
{--------------------------------------------------------------------------}
Procedure TText.Fond_Ecran;
Var       X,Y : Byte;
Begin;
For Y:=1 to 25 Do
For X:=1 To 80 Do Begin;
                  Buffer_Ecran[Y,X,Couleur]:=Couleur_Fond Shl 4 +couleur_Ecriture;
                  Buffer_Ecran[Y,X,Caractere]:=176;
                  End;
End;
{--------------------------------------------------------------------------}
Procedure TText.Ligne;
Var       X : Byte;
Begin;
For X:=1 To 80 Do Buffer_Ecran[Y,X,Couleur]:=Couleur_Ligne Shl 4 +couleur_Ligne;
end;
{--------------------------------------------------------------------------}
Procedure TText.Erase_Curseur;
BEGIN;
          Reg.ah:=$01;
          Reg.ch:=$20;
          Intr($10,registers(reg));
END;
{--------------------------------------------------------------------------}
Procedure TText.Show_Curseur;
BEGIN;
Reg.AH:=$01;
Reg.CH:=6;
Reg.CL:=7;
Intr ($10,Registers(reg));
END;
{--------------------------------------------------------------------------}
Procedure TText.ColorBackground;
BEGIN;
Ecran[Y,X,Couleur]:=Clignote Shl 7 + Background Shl 4 + Color;
END;
{--------------------------------------------------------------------------}
PROCEDURE TText.InvCli;
VAR       C,B : Byte;
BEGIN;
C:=Ecran[Y,X,Couleur] AND 7;
B:=Ecran[Y,X,Couleur] SHR 4;
Ecran[Y,X,Couleur]:=B+(C SHL 4)+128;
END;
{--------------------------------------------------------------------------}
PROCEDURE TText.InvNoCli;
VAR       C,B : Byte;
BEGIN;
C:=Ecran[Y,X,Couleur] AND 7;
B:=Ecran[Y,X,Couleur] SHR 4;
Ecran[Y,X,Couleur]:=B+(C SHL 4);
END;
{--------------------------------------------------------------------------}
Procedure TText.TextScrool;
Var
Long            : Byte; {Longueur de la bande}
Longeur_txt           : Byte; {longueur du texte}
F               : Byte;
Ecran_precedent : Type_Text_Ecran;
Buffer          : Type_Text_Ecran;
buffertravail   : Type_Text_Ecran;
BEGIN;

Ecran_Precedent:=Ecran;
buffertravail:=ecran;

Long :=XMax-XMin;
Longeur_txt:=Length (Texte);
Texte:=Texte+('                                                                ');

For F:=Xmin To Xmax-1 Do Begin;
buffertravail [Y,F,caractere]:=32;
buffertravail [Y,F,couleur]:=Couleur_fond shl 4;
End;


For f:=1 to Long   do Begin;
                      Delay(100);
                      Buffer:=buffertravail;
                      Write(Buffer,XMax-F,Y,Couleur_ecriture,
                      Couleur_Fond, Copy(Texte,0,f));
                      Ecran:=buffer;
                      End;

For f:=1 to Longeur_txt  do begin;
                      Buffer:=buffertravail;
                      Write (Buffer,XMin,Y,Couleur_Ecriture,
                      Couleur_fond, Copy(Texte,f,long) );
                      Delay(100);
                      Ecran:=buffer;
                      End;

Delay(200);
Ecran:=Ecran_Precedent;
End;     {Text_scrool_x}

{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}

Procedure AncetreObjWin.Shadow;

VAR       F : Byte;
BEGIN;
          {Calcule et affiche ombre dans le buffer}
          For f:=Xmin+1 To Xmax+2 Do Buffer_Ecran[Ymax+1,f,Couleur]:=7;
          For F:=Ymin+1 to ymax   Do Buffer_Ecran[F,Xmax+1,Couleur]:=7;
          For F:=Ymin+1 to ymax   Do Buffer_Ecran[F,Xmax+2,Couleur]:=7;
END;

{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}

Procedure ObjWin.Win1;

Var       F,F2       :  Integer;

BEGIN; {Trace les ═════════════════════════════════════ en haut et en bas }
       For F:=Xmin+1 To Xmax-1 Do Begin;
                                  Buffer_Ecran[Ymin,F,Couleur]:=
                                  Couleur_ecriture+Couleur_Fond Shl 4 +8;
                                  Buffer_Ecran[Ymin,F,Caractere] :=205;
                                  Buffer_Ecran[Ymax,F,Couleur]   :=
                                  Couleur_ecriture+Couleur_Fond Shl 4 +8;
                                  Buffer_Ecran[Ymax,F,Caractere] :=205;
                                  End;

       {Trace les ╔╗╚╝  aux 4 coins}
       Buffer_Ecran[Ymin,Xmin,Couleur]:=Couleur_ecriture+Couleur_Fond Shl 4 +8;
       Buffer_Ecran[Ymin,Xmin,Caractere] :=201;
       Buffer_Ecran[Ymax,Xmin,Couleur]:=Couleur_ecriture+Couleur_Fond Shl 4 +8;
       Buffer_Ecran[Ymax,Xmin,Caractere] :=200;
       Buffer_Ecran[Ymin,Xmax,Couleur]:=Couleur_ecriture+Couleur_Fond Shl 4 +8;
       Buffer_Ecran[Ymin,Xmax,Caractere] :=187;
       Buffer_Ecran[Ymax,Xmax,Couleur]:=Couleur_ecriture+Couleur_Fond Shl 4 +8;
       Buffer_Ecran[Ymax,Xmax,Caractere] :=188;

       {Trace les ║             ║}
       for f:=(ymin+1) to (ymax-1) do Begin;
                                      Buffer_Ecran[F,Xmin,Couleur]:=Couleur_ecriture+Couleur_Fond Shl 4 +8;
                                      Buffer_Ecran[F,Xmin,Caractere] :=186;
                                      Buffer_Ecran[F,Xmax,Couleur]:=Couleur_ecriture+Couleur_Fond Shl 4 +8;
                                      Buffer_Ecran[F,Xmax,Caractere] :=186;
                                      End;

       {Remplit la fenetre}

       for f :=(ymin+1) to (ymax-1) do
       For f2:=(Xmin+1) To (Xmax-1) do Begin;
                                       Buffer_Ecran[F,F2,Couleur]:=Couleur_ecriture+Couleur_Fond Shl 4 +8;
                                       Buffer_Ecran[F,F2,Caractere] :=32;
                                       End;

END;
{-----------------------------------------------------------}
PROCEDURE ObjWin.Win2;

Var       F : Byte;
          Couleur_Pre : Byte;

BEGIN;    {Calcule et affiche fenetre dans le buffer}
          Win1(Buffer_ecran,Xmin,Ymin,Xmax,Ymax,Couleur_ecriture,Couleur_Fond);
          {affiche l'ombre}
          Shadow(Buffer_ecran,Xmin,Ymin,Xmax,Ymax);
END;

{-----------------------------------------------------------}
PROCEDURE ObjWin.Win3;

VAR       F1,F2 : Byte;
          F : Byte;
BEGIN;    For F1:=Xmin To Xmax Do Begin;
                                  Buffer_Ecran[Ymin,F1,Couleur]:=
                                  Couleur_Ecriture_ligne+ Couleur_Fond_Ligne Shl 4 +8;
                                  Buffer_Ecran[Ymin,F1,Caractere] :=32;
                                  For F2:= Ymin+1 To Ymax Do Begin;
                                                             Buffer_Ecran[F2,F1,Couleur]:=
                                                             Couleur_Fond_Fenetre Shl 4 +Couleur_Fond_Fenetre;
                                                             Buffer_Ecran[F2,F1,Caractere] :=32;
                                                             End;
                                  End;

message:=copy(message,1,Xmax-Xmin-2);
message:=message+('Æ');
f:=0;
Repeat;
f:=f+1;
Until (message [f+1]=('Æ'))  ;
Write (Buffer_ecran,(Xmax+Xmin) Shr 1 - F Shr 1 ,Ymin,
couleur_ecriture_ligne,couleur_fond_ligne,Message);
END;
{-----------------------------------------------------------}
Procedure ObjWin.Win4;
Begin;
Win3 (Buffer_ecran,Message,xmin,ymin,xmax,ymax,
      Couleur_ecriture_Ligne,Couleur_Fond_Ligne,Couleur_Fond_Fenetre);
Shadow(Buffer_ecran,Xmin,Ymin,Xmax,Ymax);
End;
{-----------------------------------------------------------}

{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
Procedure ObjButton.util1;
VAR        f: Byte;
Begin;
For F:=Xb to Xb+9 Do Begin;
                     Buffer[Yb,F,Couleur]:=Cf Shl 4;
                     Buffer[Yb,F,Caractere]:=32;
                     End;
For F:=Xb+1 to Xb+10 Do Begin;
                        Buffer[Yb+1,F,Couleur]:=CFond Shl 4;
                        Buffer[Yb+1,F,Caractere]:=223;
                        End;
Buffer[Yb,Xb+10,Couleur]:=CFond Shl 4;;
Buffer[Yb,Xb+10,Caractere]:=220;
Write (Buffer,(Xb+Xb+10) Shr 1 - Long Shr 1 ,Yb,Ce,Cf,message);
End;
{-----------------------------------------------------------}
Procedure ObjButton.util2;
Var       f,f2 : Byte;
Begin;
For f:=Xb to Xb+10 Do For F2:=Yb To Yb+1 Do Begin;
                     Buffer[F2,F,Couleur]:=CFond Shl 4;
                     Buffer[F2,F,Caractere]:=32;
                     End;

For F:=Xb+1 to Xb+10 Do Begin;
                     Buffer[Yb,F,Couleur]:=Cf Shl 4;
                     Buffer[Yb,F,Caractere]:=32;
                     End;

Write (Buffer,(Xb+Xb+10+2) Shr 1 - Long Shr 1 ,Yb,Ce,Cf,message);
End;
{-----------------------------------------------------------}
Procedure ObjButton.Init;

VAR       F    : Byte;

BEGIN;
Xb:=X;
Yb:=Y;
Ce:=ced;
Cf:=Cfd;
Message:=Mess;
message:=message+('Æ');
Long:=0;
Repeat;
Long:=Long+1;
Until (message [Long+1]=('Æ')) or (Long=8) ;
Message:=Copy(Message,1,Long);
message:=Copy(Message,1,8);
CFond:=Buffer[Yb,Xb,Couleur] Shr 4;
End;


Procedure ObjButton.SHow;
VAr       f : Byte;
Begin;
If ObjButton.State=eteint then Util1 (Buffer);
If ObjButton.State=Alume  Then util2 (buffer);
END;
{-----------------------------------------------------------}
Function ObjButton.State;
BEGIN;
State :=Eteint;
If     (WhereX<=Xb+10)
   And (Xb<=WhereX)
   And (Yb=WhereY)
   And (Click=1) Then Begin;
                While (Click=1) Do If    (WhereX<=Xb+10)
                                     And (Xb<=WhereX)
                                     And (Yb=WhereY)
                                     Then   begin;
                                            Util2(ecran);
                                            While     (WhereX<=Xb+10)
                                                  And (Xb<=WhereX)
                                                  And (Yb=WhereY)
                                                  And (Click=1)
                                                   Do;
                                            State:=Alume;
                                            end
                                            Else
                                            Begin;
                                            util1(ecran);
                                            State:=eteint;
                                            Repeat;
                                            Until ((WhereX<=Xb+10)
                                               And (Xb<=WhereX)
                                               And (Yb=WhereY)
                                               And (Click=1)) Or (Click=0);
                                          end;
                      Util1(ecran);
                      End;
END;
{-----------------------------------------------------------}
{----------------------------------------------------------}
Procedure ObjExit.Show;
Begin;
Xe:=X;
Ye:=Y;
Buffer_Ecran[Y,X,Couleur]:=CFd Shl 4;
Buffer_Ecran[Y,X,Caractere]:=32;
Buffer_Ecran[Y,X+1,Couleur]:=CFd Shl 4 +Ced;
Buffer_Ecran[Y,X+1,Caractere]:=45;
Buffer_Ecran[Y,X+2,Couleur]:=CFd Shl 4;
Buffer_Ecran[Y,X+2,Caractere]:=32;
End;
{----------------------------------------------------------}
Function ObjExit.State;
Begin;
If (     (ObjMouse.WhereX=Xe)
     Or  (ObjMouse.WhereX=Xe+1)
     Or  (ObjMouse.WhereX=Xe+2) )
     And (ObjMouse.WhereY=Ye)
     And (Click           =1) Then State:=Alume Else State:=Eteint;

End;
{-----------------------------------------------------------}
{----------------------------------------------------------}
Procedure ObjElevator.util1;
Var       F1,F2  : Byte;
Begin;
End;
{----------------------------------------------------------}
Procedure ObjElevator.Init;
VAR       F : Word;
BEGIN;
          NB_Colone             :=I_NB_Colone             ;
          Hauteur_colone        :=I_Hauteur_colone        ;
          Largeur_colone        :=I_Largeur_colone        ;
          Xmin                  :=I_Xmin                  ;
          Ymin                  :=I_Ymin                  ;
          Couleur_ecriture      :=I_Couleur_ecriture      ;
          Couleur_Fond          :=I_Couleur_Fond          ;
          Couleur_fenetre       :=I_Couleur_fenetre       ;
          Couleur_ligne_fenetre :=I_Couleur_ligne_fenetre ;
          Mess                  :=I_Mess                  ;
          Nbcontenu             :=I_Nbcontenu             ;
          For F:=0 to NbContenu-1 Do Contenu[f]:=Copy (I_contenu[f]+
          '                                                     '
          ,1,Largeur_colone);
          First                 :=0;
          NoInv                 :=0;
END;
{----------------------------------------------------------}
Procedure ObjElevator.Show;
Var       F1,F2 : Byte;
          Max   : Byte;
BEGIN;

{creation de la fenetre et de l'assenceur}
ObjWin.WIn3 (Buffer_Ecran,Mess,
             Xmin,Ymin,
             Xmin+Nb_Colone*(Largeur_Colone)+3*(nb_colone-1)+2 ,
             Ymin+Hauteur_colone+1,
             Couleur_Ecriture,Couleur_Fond,Couleur_Fenetre);
For F1:=1 To NB_colone-1 Do Begin;
For F2:=Ymin+1 To Ymin+Hauteur_Colone+1 Do Begin;
Buffer_Ecran[F2,Xmin+(Largeur_colone+3)*F1-1,Couleur]:=Couleur_fenetre Shl 4 + Couleur_Ligne_Fenetre;
Buffer_Ecran[F2,Xmin+(Largeur_colone+3)*F1-1,Caractere]:=179 ;
End;
End;
For F1:=Ymin+2 To Ymin+Hauteur_Colone Do Begin;
Buffer_Ecran[F1,Xmin+Largeur_colone*Nb_Colone+3*(nb_colone-1)+2,Couleur]:=Couleur_Ligne_fenetre Shl 4;
Buffer_Ecran[F1,Xmin+Largeur_colone*Nb_Colone+3*(nb_colone-1)+2,Caractere]:=32 ;
End;

Buffer_Ecran[Ymin+1,Xmin+Largeur_colone*Nb_Colone+3*(nb_colone-1)+2,Couleur]:=Couleur_Ligne_fenetre + Couleur_fenetre Shl 4;
Buffer_Ecran[Ymin+1,Xmin+Largeur_colone*Nb_Colone+3*(nb_colone-1)+2,Caractere]:=24 ;
Buffer_Ecran[Ymin+Hauteur_Colone+1,Xmin+Largeur_colone*Nb_Colone+3*(nb_colone-1)+2,Couleur]:=
Couleur_Ligne_fenetre + Couleur_fenetre  Shl 4;
Buffer_Ecran[Ymin+Hauteur_Colone+1,Xmin+Largeur_colone*Nb_Colone+3*(nb_colone-1)+2,Caractere]:=25 ;

{Remplit l'assenceur par les message}
If (nbContenu-first)<nb_colone*hauteur_colone then max:=(NbContenu-first) Else Max:=Nb_colone*hauteur_colone;

For F1:=0 To Max-1 Do
Write (Buffer_Ecran,
    Xmin+(F1 DIV Hauteur_Colone)*Largeur_Colone+1+3*(f1 div hauteur_colone),
       Ymin+((F1)  MOD Hauteur_Colone)+1,
       Couleur_Ligne_Fenetre+8,
       Couleur_Fenetre,
       Contenu[f1+First]                    );
Write (Buffer_Ecran,
    Xmin+( (NoInv-first) DIV Hauteur_Colone)*Largeur_Colone
    +1+3*( (NoInv-first) DIV hauteur_colone),
       Ymin+((NoInv-First)  MOD Hauteur_Colone)+1,
 {      Couleur_fenetre,
       Couleur_Ligne_Fenetre,} 7,0,
       Contenu[NoInv]                    );



Buffer_ecran
[Ymin+2+ ((NoInv)*(hauteur_colone-1)) Div NbContenu,
Xmin+Nb_Colone*(Largeur_Colone)+3*(nb_colone-1)+2 ,
caractere]:=219;
Buffer_ecran
[Ymin+2+ ((NoInv)*(hauteur_colone-1)) Div NbContenu,
Xmin+Nb_Colone*(Largeur_Colone)+3*(nb_colone-1)+2 ,
couleur]:=Couleur_fenetre+Couleur_ligne_fenetre shl 4 +8;


END;

{----------------------------------------------------------}

Function ObjElevator.State;
Begin;
If   (ObjMouse.WhereX=Xmin+Largeur_colone*Nb_Colone+3*(nb_colone-1)+2)
And  (ObjMouse.WhereY=Ymin+Hauteur_Colone+1)
And  (ObjMouse.Click=1)
Then Begin ;
     If        (NoInv+1<NbContenu)
        And    ( (NoInv-First+1)<Nb_Colone*Hauteur_Colone)
                  Then  Begin;
                        NoInv:=NoInv+1;
                        INTERNE1:=ECran;
                        Show(INTERNE1);
                        Ecran:=INTERNE1;
                        end;

      If     ( (NoInv-First+1)=Nb_Colone*Hauteur_Colone )
         AND   (NoInv+1<NbContenu)
           Then Begin;
                First:=first+1;
                NoInv:=NoInv+1;
                        INTERNE1:=ECran;
                        Show(INTERNE1);
                        Ecran:=INTERNE1;
                end;

     End;

If   (ObjMouse.WhereX=Xmin+Largeur_colone*Nb_Colone+3*(nb_colone-1)+2)
And  (ObjMouse.WhereY=Ymin+1)
And  (ObjMouse.Click=1)
Then Begin ;
     If        (NoInv>first)
                  Then  Begin;
                        NoInv:=NoInv-1;
                        INTERNE1:=ECran;
                        Show(INTERNE1);
                        Ecran:=INTERNE1;
                        end;
    If        (NoInv=First)
           and (first>0)
                  Then begin;
                        first:=first-1;
                        NoInv:=NoInv-1;
                        INTERNE1:=ECran;
                        Show(INTERNE1);
                        Ecran:=INTERNE1;
                        end;
     End;

If   (ObjMouse.WhereX=Xmin+Largeur_colone*Nb_Colone+3*(nb_colone-1)+2)
And  (ObjMouse.WhereY>=Ymin+2)
And  (ObjMouse.WhereY<=Ymin+Hauteur_colone)
And  (ObjMouse.Click=1)
Then Begin;
First:=NbContenu*(ObjMouse.WhereY-2-Ymin) Div Hauteur_colone;
NoInv:=NbContenu*(ObjMouse.WhereY-2-Ymin) Div Hauteur_colone;
                        INTERNE1:=ECran;
                        Show(INTERNE1);
                        Ecran:=INTERNE1;
end;

State:=noInv;
End;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}

Procedure ObjWinAuto.Init;
Var       F : Byte;
Begin;
Xmin                     := I_Xmin;
Ymin                     := I_Ymin;
Hauteur                  := I_Hauteur;
Messag                   := I_Message;
Contenu                  := I_Contenu;
Couleur_langue_ecriture  := I_Couleur_langue_ecriture;
Couleur_langue_fond      := I_Couleur_langue_fond ;
Couleur_fenetre_ecriture := I_Couleur_fenetre_ecriture;
Couleur_fenetre_fond     := I_Couleur_fenetre_fond  ;
NoInv                    :=1;
Longeur:=0;
For F:=1 to Hauteur do If Length (Contenu[F]) >Longeur
Then Longeur:=Length(Contenu[F]);
Longeur:=longeur+2;
For F:=1 to Hauteur do Contenu[f]:=Copy(' '+Contenu[f]+('                                                 '),1,Longeur);
While Xmin+Longeur>78 Do Xmin:=Xmin-1;
End;
{----------------------------------------------------------}
Procedure ObjWinAuto.Show;
Var       F : Byte;
Begin;
Win4( Buffer_ecran,messag,Xmin,Ymin,Xmin+Longeur-1,Ymin+Hauteur+1,
couleur_langue_ecriture,couleur_langue_fond,couleur_fenetre_fond);
For f:=1 to Hauteur Do Write (Buffer_ecran,Xmin,Ymin+f,
Couleur_fenetre_ecriture,couleur_fenetre_fond,contenu[f]);
Write (Buffer_ecran,Xmin,Ymin+NoInv,couleur_fenetre_fond,
Couleur_fenetre_ecriture,Contenu[NoInv]);
End;
{----------------------------------------------------------}
Function ObjWinAuto.State;
Var Inter : Byte;
    M     : Rmouse;
    Test  : Boolean;
Begin;
Test:=False;
State:=0;
Mouse_State (m);
While   (M.X<Xmin+Longeur)
And     (M.X>=Xmin)
And     (M.Y>Ymin)
And     (M.Y<=Ymin+hauteur)
And     (M.B=1) DO Begin;
                   NoInv:=M.Y-Ymin;
                   INTERNE1:=ECran;
                   ObjWinAuto.Show(INTERNE1);
                   Ecran:=INTERNE1;
                   Mouse_State (m);
                   Test:=True;

                   End;

Mouse_State (m);

If      (M.X<Xmin+Longeur)
And     (M.X>=Xmin)
And     (M.Y>Ymin)
And     (M.Y<=Ymin+hauteur)
And     (Test=True)
        Then State:=M.Y-Ymin;


End;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
Procedure ObjWinMenuD.Init;
Var       F : Byte;
Begin;
Xmin                     := I_Xmin;
Ymin                     := I_Ymin;
Hauteur                  := I_Hauteur;
Contenu                  := I_Contenu;
Color                    := I_Couleur;
BackGround               := I_BackGround;
NoInv                    :=1;
Longeur:=0;
For F:=1 to Hauteur do If Length (Contenu[F]) >Longeur
Then Longeur:=Length(Contenu[F]);
Longeur:=longeur+2;
For F:=1 to Hauteur do Contenu[f]:=Copy(' '+Contenu[f]+('                                                 '),1,Longeur);
While Xmin+Longeur>78 Do Xmin:=Xmin-1;
End;
{-----------------------------------}
Procedure ObjWinMenuD.Show;
Var       F     : Byte;
          F1,F2 : Byte;
Begin;
   For F1:=Xmin To Xmin+Longeur-1 Do
          For F2:= Ymin+1 To Ymin+Hauteur+1 Do Begin;
                                     INTERNE1[F2,F1,Couleur]:=
                                     BackGround Shl 4 +Color;
                                     INTERNE1[F2,F1,Caractere] :=32;
                                     End;

Shadow(INTERNE1,Xmin,Ymin,Xmin+longeur-1,Ymin+Hauteur+1);
For f:=1 to Hauteur Do
Write (INTERNE1,Xmin,Ymin+f,Color,BackGround,contenu[f]);
Write (INTERNE1,Xmin,Ymin+NoInv,BackGround,Color,Contenu[NoInv]);
End;
{------------------------------------}
Function ObjWinMenuD.State;
Var Inter : Byte;
    M     : Rmouse;
    Test  : Boolean;
Begin;
Test:=False;
State:=0;
Mouse_State (m);


While   (M.X<Xmin+Longeur)
And     (M.X>=Xmin)
And     (M.Y>Ymin)
And     (M.Y<=Ymin+hauteur)
And     (M.B=1) DO Begin;
                   Mouse_State (m);
                   NoInv:=M.Y-Ymin;
                   INTERNE1:=ECran;
                   ObjWinMenuD.Show;
                   Ecran:=INTERNE1;
                   Mouse_State (m);

                   Test:=True;
                   End;

If      (M.X<Xmin+Longeur)
And     (M.X>=Xmin)
And     (M.Y>Ymin)
And     (M.Y<=Ymin+hauteur)
And     (Test=True)
        Then State:=NoInv;

END;


END.
