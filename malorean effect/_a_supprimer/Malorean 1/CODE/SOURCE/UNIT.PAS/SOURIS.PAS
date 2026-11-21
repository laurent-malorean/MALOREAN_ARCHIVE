{***************************************************************************
*                                                                          *
*                    Unit‚ de gestion de la souris                         *
*                      Par Laurent Desechalliers                           *
*                                                                          *
*   Version 1 : 27-04-94   Version Initial repiqu‚ de mes vieilles sources *
*                           sources + inspir‚ de gest_souris de Unit C     *
*                                                                          *
*                                                                          *
*                                                                          *
*                                                                          *
****************************************************************************}


Unit SOURIS;

INTERFACE

USES DOS,VARIABLE;

CONST  IntSouris=$33;

CONST  Pas_Bouton      = 0 ;
       Bouton1         = 1 ;
       Bouton2         = 2 ;
       Bouton1_et_2    = 3 ;

TYPE   OBJET_SOURIS = OBJECT
                      X,Y              : Integer; {Position de la souris}
                      Visible          : Boolean; {True si souris est visible}
                      Button1,Button2  : Boolean; {True si enfonc‚}
                      Click            : Integer; {Valeur des Bouton }
                                                  { 1 si B1 Relach‚ B2 Relach‚ }
                                                  { 2 si B1 Relach‚ B2 Enfonc‚ }
                                                  { 3 si B1 Enfonc‚ B2 Enfonc‚ }
                      Procedure Init;
                      Procedure Show;
                      Procedure Erase;
                      Procedure PUT_XY (NewX,NewY    : Byte);
                      Function  GET_X     : Integer;
                      Function  GET_Y     : Integer;
                      Function  GET_Click : Integer;
                      Procedure Limite (xmin,xmax,ymin,ymax  :integer);
                      Procedure GET_INFO ;
                      Function  STATE (NewX,NewY,New_Lx,New_Ly : Integer;
                                       Etat_des_boutons        : Integer ) : BOOLEAN;
                      End;

VAR Unit_Mouse : OBJET_SOURIS;

IMPLEMENTATION

{-------------------------------------------------------------------------}
Procedure OBJET_SOURIS.Init;
begin;
          ASM
          MOV AX,$0000;
          INT (IntSouris);
          END;
     Button1:=False;
     Button2:=False;
     X:=0;
     Y:=0;
     Visible:=False;

end;
{-------------------------------------------------------------------------}
Procedure OBJET_SOURIS.Show;
begin;
          ASM
          MOV Ax,$1;
          INT (IntSouris);
          END;
          Visible:=True;
end;
{-------------------------------------------------------------------------}
Procedure OBJET_SOURIS.Erase;
begin;
          ASM
          MOV Ax,$2;
          INT (IntSouris);
          END;
          Visible:=False;
end;
{-------------------------------------------------------------------------}
Procedure OBJET_SOURIS.PUT_XY (NewX,NewY    : Byte);
begin;
reg.ax:=4;
reg.dx:=NewY;
reg.cx:=NewX;
intr(IntSouris,registers(reg));
end;
{-------------------------------------------------------------------------}
Procedure OBJET_SOURIS.Limite;
begin;
reg.ax:=8;
reg.dx:=(xmin*8);
reg.cx:=(ymin*8);
intr(IntSouris,registers(reg));
reg.ax:=7;
reg.dx:=(xmax*8);
reg.cx:=(ymax*8);
intr(IntSouris,registers(reg));
end;
{-------------------------------------------------------------------------}
Function OBJET_SOURIS.GET_X;
var
psg    : longint;
begin;
reg.ax:=3;
intr(IntSouris,registers(reg));
psg:=reg.cx;
psg:=(psg div 8)+1;
GET_X:=psg;
end;
{-------------------------------------------------------------------------}
function OBJET_SOURIS.GET_Y;
var
psg    : longint;
begin;
reg.ax:=3;
intr(IntSouris,registers(reg));
psg:=reg.dx;
psg:=(psg div 8)+1;
GET_Y:=psg;
end;
{-------------------------------------------------------------------------}
function OBJET_SOURIS.GET_Click;
begin;
reg.ax:=3;
intr(IntSouris,registers(reg));
GET_Click:=reg.bx;
end;
{-------------------------------------------------------------------------}
PROCEDURE OBJET_SOURIS.GET_INFO ;
VAR       Inter : Byte;
BEGIN;    X     :=GET_X;
          Y     :=GET_Y;
          Click :=GET_Click;
          If Inter=1 Then Button1:=True;  {a completer selon les valeurs}
END;
{-------------------------------------------------------------------------}
Function  OBJET_SOURIS.STATE (NewX,NewY,New_Lx,New_Ly : Integer;
                           Etat_des_boutons        : Integer ) : BOOLEAN;
BEGIN;    GET_INFO; {reactualise les infos}
          If      (NewX<=X) AND (X<=NewX+New_Lx)
              AND (NewY<=Y) AND (Y<=NewY+New_Ly)
              AND (Etat_des_boutons=Click) THEN STATE:=TRUE
                                           ELSE STATE:=FALSE;
END;
{-------------------------------------------------------------------------}

BEGIN; Unit_Mouse.Init;
END.

