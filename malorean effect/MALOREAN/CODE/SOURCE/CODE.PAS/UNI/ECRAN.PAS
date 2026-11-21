{**********************************************************************
*                                                                     *
*                      Unité de gestion d'ecran                       *
*                      Par Laurent Desechalliers                      *
*                                                                     *
***********************************************************************}

Unit Ecran;

INTERFACE

USES DOS,Mouse,Variable,Pointeur,Curseur,CRT;

Const Noir                  = 0;
      Bleu                  = 1;
      Vert                  = 2;
      Cyan                  = 3;
      Rouge                 = 4;
      Magenta               = 5;
      Brun                  = 6;
      Blanc                 = 7;
      Gris                  = 8;

CONST Page_0                 = 0;
      Page_1                 = 1;
      Page_2                 = 2;
      Page_3                 = 3;

CONST SurIntensite          = True;
      SousIntensite         = False;

CONST Clignotement          = True;
      PasClignotement       = False;

CONST RIEN                  = 0;

CONST CENTRE                = TRUE;
      PAS_CENTRE            = FALSE;

CONST BORDURE               = TRUE;
      PAS_BORDURE           = FALSE;


CONST OFS_Compatible        = $B800;
      OFS_Pas_Compatible    = $B000;

CONST MAX_X                 = 80;
      MAX_Y                 = 25;

TYPE  Type_Attribut_Couleur = (caractere,Attr);
      Type_Ecran_Text       = ARRAY [1..25,1..80,Caractere..Attr] OF Byte;
      Type_pointeur_Ecran   = ^Type_Ecran_Text;

TYPE  SAUVEGARDE_ECRAN      = ARRAY [1..MAX_Y,1..MAX_X,Caractere..Attr] Of Pointeur_Byte;

TYPE  Type_Ecran_Global     = Record
                              Visible             : Boolean; {True si est ecran actif}
                              Color               : Byte;
                              Background          : Byte;
                              SurIntensite        : Boolean;
                              Clignotement        : Boolean;
                              Attribut            : Byte;
                              CurseurX            : Byte;
                              CurseurY            : Byte;
                              Page_Sauve          : Type_Ecran_Text;
                              Page                : Type_pointeur_Ecran;
                              Souris              : Obj_Mouse;
                              CURSEUR             : OBJET_CURSEUR;
                              End;


VAR   PAGE_ACTIVE  : Byte ;    { N° de l'ecran actif}
      Ofset_Vram   : Word;     { Le segment du debut de la vram video texte}
      Compatible   : Boolean;  { TRUE si point en $B800}

      {les 4 ecran pointant sur la RAM video}
      Ecr          : Array [0..3] of Type_Ecran_Global;

{********************* Choix de la page active *******************}
Procedure Put_Page          (Page         : Byte );
Function  Get_Page          : Byte;
{***************** Les attribut des pages ecran ****************** }
Procedure Put_Attribut      (Page         : Byte ;
                             Color        : Byte ;
                             Background   : Byte ;
                             SurIntensite : Boolean;
                             Clignotement : Boolean   );

{***************** La position du curseur  ****************** }
Procedure Put_XY            (Page         : Byte ;
                             X,Y          : Byte );
Function  Get_X             (Page         : Byte ) : Byte;
Function  Get_Y             (Page         : Byte ) : Byte;


{Met True Si carte poite en $B800 sinon False si pointe en $B000}
Procedure Carte_Compatible  (Carte : Boolean);

{***************** Les fonctions d'ecriture  ****************** }
Procedure Ecrit             (Page         : Byte ;
                             X,Y          : Byte ;
                             Color        : Byte ;
                             Background   : Byte ;
                             SurIntensite : Boolean;
                             Clignotement : Boolean;
                             Message      : String );

Procedure Cls               (Page         : Byte ;
                             Color        : Byte );
{******************* les primitives d'écriture **************************}
Procedure Carre             (Page         : Byte ;
                             Color        : Byte ;
                             Background   : Byte ;
                             Depart_X     : Byte ;
                             Depart_Y     : Byte ;
                             Longueur_X   : Byte ;
                             Longueur_Y   : Byte ;
                             BORBURE      : BOOLEAN);

Procedure Ligne             (Page         : Byte ;
                             Color        : Byte ;
                             Depart_X     : Byte ;
                             Y            : Byte ;
                             Longueur_X   : Byte );

Procedure Ligne_Plus_Texte  (Page         : Byte ;
                             Color        : Byte ;
                             Background   : Byte ;
                             SurIntensite : Boolean;
                             Clignotement : Boolean;
                             Depart_X     : Byte ;
                             Y            : Byte ;
                             Longueur_X   : Byte ;
                             Centrage     : Boolean;
                             Texte        : String );



{*****************  Les sauvegardes et restaurations d'ecran ************}
Procedure Sauve_Ecran       (VAR  Sauvegarde   : SAUVEGARDE_ECRAN;
                                  Page         : Byte ;
                                  Depart_X     : Byte ;
                                  Depart_Y     : Byte ;
                                  Longueur_X   : Byte ;
                                  Longueur_Y   : Byte );

Procedure Restaure;


IMPLEMENTATION



{************************************************************************}
Procedure Put_Page       (Page       : Byte );
BEGIN;  Ecr[Page_Active].SOURIS.GET_INFO; {sauve les info de la souris de
					   la page}
        Ecr[Page_Active].SOURIS.ERASE;   {vire la souris}
        Ecr[Page_Active].page_Sauve:=Ecr[Page_Active].page^; {sauve la
                                             page dans la memoire}
        Ecr[PAGE_ACTIVE].Visible:=False ; {l'ancienne page n'est plus active}
        PAGE_ACTIVE:=Page               ; {donne le numéro de la new page active}
        Ecr[PAGE_ACTIVE].Visible:=True  ; {la nouvelle page est active}
        Ecr[PAGE_ACTIVE].Page^:=Ecr[PAGE_ACTIVE].Page_Sauve ;
                     {affiche dans la page active dans la memoire}
        Ecr[Page_Active].SOURIS.SHOW;   {met la souris dans la nouvelle page}
        Ecr[Page_Active].SOURIS.PUT_XY(Ecr[Page_Active].SOURIS.X,Ecr[Page_Active].SOURIS.Y);
                                        {et la met au coordonne de la page}
END;
{************************************************************************}
Function  Get_Page          : Byte;
BEGIN;    Get_Page:=PAGE_ACTIVE; END;
{************************************************************************}
Procedure Put_Attribut (Page         : Byte ;
                        Color        : Byte ;
                        Background   : Byte ;
                        SurIntensite : Boolean;
                        Clignotement : Boolean  );

Begin;   Ecr[Page].Attribut     := Color+BackGround*16+Byte(SurIntensite)*8
                                        +Byte(Clignotement)*128;
         Ecr[Page].Color        := Color;
         Ecr[Page].BackGround   := BackGround;
         Ecr[Page].SurIntensite := SurIntensite;
         Ecr[Page].Clignotement := Clignotement;
End;
{************************************************************************}
Procedure Carte_Compatible   (Carte : Boolean);
BEGIN;    If Carte Then Ofset_Vram:=OFS_Compatible
                   else Ofset_Vram:=OFS_Pas_Compatible;
          Ecr[0].Page:=Ptr(Ofset_Vram,0);  {les ecran pointent tous }
          Ecr[1].Page:=Ptr(Ofset_Vram,0);  {simultanement sur l'ecran}
          Ecr[2].Page:=Ptr(Ofset_Vram,0);  {physique}
          Ecr[3].Page:=Ptr(Ofset_Vram,0);
END;
{************************************************************************}
Procedure Put_XY            (Page         : Byte ;
                             X,Y          : Byte );
Begin;    Ecr[Page].CurseurX:=X;
          Ecr[Page].CurseurY:=Y;
End;
{************************************************************************}
Function  Get_X            (Page         : Byte ) : Byte;
BEGIN;    Get_X := Ecr[Page].CurseurX; END;
{************************************************************************}
Function  Get_Y            (Page         : Byte ) : Byte;
BEGIN;    Get_Y := Ecr[Page].CurseurY; END;
{************************************************************************}
{***************** Les fonctions d'ecriture  ****************** }
Procedure Ecrit             (Page         : Byte ;
                             X,Y          : Byte ;
                             Color        : Byte ;
                             Background   : Byte ;
                             SurIntensite : Boolean;
                             Clignotement : Boolean;
                             Message      : String );
VAR ATTRIBUT_ECRIT : BYTE;
VAR COMPTEUR1      : BYTE;
BEGIN;
IF Page=PAGE_ACTIVE THEN ECR[PAGE_ACTIVE].PAGE_SAUVE:=ECR[PAGE_ACTIVE].PAGE^;
{si page=p_actif alors sauve la ecran réel ds la mem
                       ecrit le texte dans la mem
                       met le mem modifier dans ecrans réel
                 Sinon ecrit seulement dans la mem     }
ATTRIBUT_ECRIT:=Color+BackGround*16
                 +Byte(SurIntensite)*8+Byte(Clignotement)*128;
For COMPTEUR1:=1 To Length(Message) Do
                            Begin;
                            Ecr[Page].PAGE_SAUVE[Y,X-1+Compteur1,Caractere]
                                           :=ORD ( Message[Compteur1] );
                            Ecr[Page].PAGE_SAUVE[Y,X-1+Compteur1,Attr]
                                           :=ATTRIBUT_ECRIT;
                            End;
IF Page=PAGE_ACTIVE THEN ECR[PAGE_ACTIVE].PAGE^:=ECR[PAGE_ACTIVE].PAGE_SAUVE;
END;

{************************************************************************}

{************************************************************************}

Procedure Cls               (Page         : Byte ;
                             Color        : Byte );
VAR ATTRIBUT_CLS : BYTE;
VAR COMPTEUR1      : BYTE;
VAR COMPTEUR2      : BYTE;
BEGIN;
IF Page=PAGE_ACTIVE THEN ECR[PAGE_ACTIVE].PAGE_SAUVE:=ECR[PAGE_ACTIVE].PAGE^;
{si page=p_actif alors sauve la ecran réel ds la mem
                       ecrit le cls dans la mem
                       met le mem modifier dans ecrans réel
                 Sinon ecrit seulement dans la mem     }

ATTRIBUT_CLS:=Color*16;
For COMPTEUR1:=1 To MAX_X Do
For COMPTEUR2:=1 To MAX_Y Do BEGIN;
                             Ecr[Page].PAGE_SAUVE[Compteur2,Compteur1,Caractere]
                                           :=32;
                             Ecr[Page].PAGE_SAUVE[Compteur2,Compteur1,Attr]
                                           :=ATTRIBUT_CLS;
                            End;
IF Page=PAGE_ACTIVE THEN ECR[PAGE_ACTIVE].PAGE^:=ECR[PAGE_ACTIVE].PAGE_SAUVE;

END;
{************************ les primitives d'écriture ********************}
Procedure Carre             (Page         : Byte ;
	                     Color        : Byte ;
                             Background   : Byte ;
                             Depart_X     : Byte ;
                             Depart_Y     : Byte ;
                             Longueur_X   : Byte ;
                             Longueur_Y   : Byte ;
			     BORBURE      : BOOLEAN);
VAR ATTRIBUT_CARRE : BYTE;
VAR COMPTEUR1      : BYTE;
VAR COMPTEUR2      : BYTE;
BEGIN;
IF Page=PAGE_ACTIVE THEN ECR[PAGE_ACTIVE].PAGE_SAUVE:=ECR[PAGE_ACTIVE].PAGE^;
{si page=p_actif alors sauve la ecran réel ds la mem
                       ecrit le carre dans la mem
                       met le mem modifier dans ecrans réel
                 Sinon ecrit seulement dans la mem     }

ATTRIBUT_CARRE:=BACKGROUND*16+color;
For COMPTEUR1:=Depart_X To Depart_X+Longueur_X-1 Do
For COMPTEUR2:=Depart_Y To Depart_Y+Longueur_Y-1 Do BEGIN;
          Ecr[Page].PAGE_SAUVE[Compteur2,Compteur1,Caractere]:=32;
          Ecr[Page].PAGE_SAUVE[Compteur2,Compteur1,Attr]     :=ATTRIBUT_CARRE;
                                                    END;
IF BORDURE THEN BEGIN;
For COMPTEUR1:=Depart_Y+1 To Depart_Y+Longueur_Y-2 Do Begin;
          Ecr[Page].PAGE_SAUVE[Compteur1,Depart_X,Caractere]:=186;
          Ecr[Page].PAGE_SAUVE[Compteur1,Depart_X+LONGUEUR_X-1,Caractere]:=186;
          						              End;
For COMPTEUR1:=Depart_X+1 To Depart_X+Longueur_X-2 Do BEGIN;
          Ecr[Page].PAGE_SAUVE[Depart_Y,Compteur1,Caractere]:=205;
          Ecr[Page].PAGE_SAUVE[Depart_Y+LONGUEUR_Y-1,Compteur1,Caractere]:=205;
                                                      END;
Ecr[Page].PAGE_SAUVE[Depart_Y,DEPART_X,Caractere]:=201; {╔}
Ecr[Page].PAGE_SAUVE[Depart_Y,DEPART_X+Longueur_X-1,Caractere]:=187; {╗}
Ecr[Page].PAGE_SAUVE[Depart_Y+LONGUEUR_Y-1,DEPART_X,Caractere]:=200; {╚}
Ecr[Page].PAGE_SAUVE[Depart_Y+LONGUEUR_Y-1,DEPART_X+LONGUEUR_X-1,Caractere]:=188; {╝}

	        END;
IF Page=PAGE_ACTIVE THEN ECR[PAGE_ACTIVE].PAGE^:=ECR[PAGE_ACTIVE].PAGE_SAUVE;
END;

{*************************************************************************}

Procedure Ligne             (Page         : Byte ;
                             Color        : Byte ;
                             Depart_X     : Byte ;
                             Y            : Byte ;
                             Longueur_X   : Byte );
VAR ATTRIBUT_CARRE : BYTE;
VAR COMPTEUR1      : BYTE;

BEGIN;
IF Page=PAGE_ACTIVE THEN ECR[PAGE_ACTIVE].PAGE_SAUVE:=ECR[PAGE_ACTIVE].PAGE^;
{si page=p_actif alors sauve la ecran réel ds la mem
                       ecrit le carre dans la mem
                       met le mem modifier dans ecrans réel
                 Sinon ecrit seulement dans la mem     }

ATTRIBUT_CARRE:=Color*16;
For COMPTEUR1:=Depart_X To Depart_X+Longueur_X-1 Do BEGIN;
          Ecr[Page].PAGE_SAUVE[Y,Compteur1,Caractere]:=32;
          Ecr[Page].PAGE_SAUVE[Y,Compteur1,Attr]     :=ATTRIBUT_CARRE;
                                                    END;
IF Page=PAGE_ACTIVE THEN ECR[PAGE_ACTIVE].PAGE^:=ECR[PAGE_ACTIVE].PAGE_SAUVE;

END;

{*************************************************************************}

Procedure Ligne_Plus_Texte  (Page         : Byte ;
                             Color        : Byte ;
                             Background   : Byte ;
                             SurIntensite : Boolean;
                             Clignotement : Boolean;
                             Depart_X     : Byte ;
                             Y            : Byte ;
                             Longueur_X   : Byte ;
                             Centrage     : Boolean;
                             Texte        : String );
BEGIN;
Ligne(Page,Background,Depart_X,Y,Longueur_X); {affiche la ligne vierge}
Texte:=COPY(TEXTE,1,Longueur_X-2); {coupe le texte si il est trop long}
IF CENTRAGE Then Depart_X:=Depart_X+(Longueur_X-LENGTH(TEXTE)) SHR 1
            Else Inc(DEPART_X);
{si est demande l'abscice est mise de façon à centrer le texte
 sinon est mis a gauche}
ECRIT(Page,Depart_X,Y,Color,BackGround,SurIntensite,Clignotement,Texte);
{ecrit le texte}

END;

{*****************  Les sauvegardes et restaurations d'ecran ************}
Procedure Sauve_Ecran       (VAR  Sauvegarde   : SAUVEGARDE_ECRAN;
                                  Page         : Byte ;
                                  Depart_X     : Byte ;
                                  Depart_Y     : Byte ;
                                  Longueur_X   : Byte ;
                                  Longueur_Y   : Byte );
VAR COMPTEUR_X : BYTE;
VAR COMPTEUR_Y : BYTE;
BEGIN;
For COMPTEUR_X:=1 To Longueur_X Do
For COMPTEUR_Y:=1 To Longueur_Y Do Begin;
        New(Sauvegarde[COMPTEUR_Y,COMPTEUR_X,Caractere]);
        New(Sauvegarde[COMPTEUR_Y,COMPTEUR_X,Attr]);
        Sauvegarde[COMPTEUR_Y,COMPTEUR_X,Caractere]^:=
         Ecr[Page].page^[COMPTEUR_Y+Depart_Y,COMPTEUR_X+Depart_X,Caractere];
        Sauvegarde[COMPTEUR_Y,COMPTEUR_X,Attr]^:=
         Ecr[Page].page^[COMPTEUR_Y+Depart_Y,COMPTEUR_X+Depart_X,Attr];
                                   End;
END;
{************************************************************************}

{************************************************************************}
{************************************************************************}

Procedure Restaure;
Begin; ECR[0].CURSEUR.OPEN;
       ECR[0].SOURIS.ERASE;
       TEXTCOLOR(BLANC);
       TEXTBACKGROUND(NOIR);
       CLRSCR;
End;



BEGIN;{Carte video compatible ou non}
      Carte_Compatible (True);
      {Pamametres par défaut}
      Put_Page(Page_0); {La page active est la page zero}

      {Parametre par défaut des 4 pages ecran}
      Put_Attribut (Page_0,Blanc,Noir,SurIntensite,PasClignotement);
      Put_Attribut (Page_1,Blanc,Noir,SurIntensite,PasClignotement);
      Put_Attribut (Page_2,Blanc,Noir,SurIntensite,PasClignotement);
      Put_Attribut (Page_3,Blanc,Noir,SurIntensite,PasClignotement);

      {efface les 4 ecran en noir}
      CLS(PAGE_0,NOIR);
      CLS(PAGE_1,NOIR);
      CLS(PAGE_2,NOIR);
      CLS(PAGE_3,NOIR);

      {vire le curseur des 4 pages}
      ECR[0].CURSEUR.CLOSE;
      ECR[1].CURSEUR.CLOSE;
      ECR[2].CURSEUR.CLOSE;
      ECR[3].CURSEUR.CLOSE;

      {affiche la souris}
      ECR[0].SOURIS.SHOW;
      {les souris des 4 ecrans pointent en haut à gauche}
      ECR[0].SOURIS.PUT_XY(1,1);
      ECR[1].SOURIS.PUT_XY(1,1);
      ECR[2].SOURIS.PUT_XY(1,1);
      ECR[3].SOURIS.PUT_XY(1,1);

END.

{sauver un bout de l'ecran | le restaurer
avec une liste chainé déja déclarer ou on donne un nom
à l'ecran sauvegardez}
{efacer une partie de l'ecran}
{choisir une fenetre active}