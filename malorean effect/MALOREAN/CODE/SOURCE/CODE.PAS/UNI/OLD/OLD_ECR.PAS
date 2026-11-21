{**********************************************************************
*                                                                     *
*                      Unité de gestion d'ecran                       *
*                      Par Laurent Desechalliers                      *
*                                                                     *
***********************************************************************}

Unit Ecran;

INTERFACE

USES DOS,Mouse,Variable,Pointeur;

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
                              Page                : Type_pointeur_Ecran;
                              Souris              : Obj_Mouse;
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
Procedure Put_Color         (Page         : Byte ;
                             Color        : Byte );
Procedure Put_BackGround    (Page         : Byte ;
                             BackGround   : Byte );
Procedure Put_SurIntensite  (Page         : Byte ;
                             SurIntensite : Boolean );
Procedure Put_Clignotement  (Page         : Byte ;
                             Clignotement : Boolean );

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
Procedure Carre             (Page         : Byte ;
                             Color        : Byte ;
                             Depart_X     : Byte ;
                             Depart_Y     : Byte ;
                             Longueur_X   : Byte ;
                             Longueur_Y   : Byte );

Procedure Cls               (Page         : Byte ;
                             Color        : Byte );
{*****************  Les sauvegardes et restaurations d'ecran ************}
Procedure Sauve_Ecran       (VAR  Sauvegarde   : SAUVEGARDE_ECRAN;
                                  Page         : Byte ;
                                  Depart_X     : Byte ;
                                  Depart_Y     : Byte ;
                                  Longueur_X   : Byte ;
                                  Longueur_Y   : Byte );

IMPLEMENTATION

{************************************************************************}
Procedure Put_Page       (Page       : Byte );
BEGIN;  Ecr[PAGE_ACTIVE].Visible:=False ; {l'ancienne page n'est plus active}
        PAGE_ACTIVE:=Page               ; {donne le numéro de la new page active}
        Ecr[PAGE_ACTIVE].Visible:=True  ; {la nouvelle page est active}

        REG.AH:=$05                 ; {Pointe sur la nouvelle Page}
        REG.AL:=Page                ;
        Intr($10,registers(reg))    ;

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
Procedure Put_Color    (Page       : Byte ;
                        Color      : Byte );
BEGIN;    Put_Attribut  (Page,
                         Color,
                         Ecr[Page].BackGround,
                         Ecr[Page].SurIntensite,
                         Ecr[Page].Clignotement);
END;
{************************************************************************}
Procedure Put_BackGround (Page       : Byte ;
                          BackGround : Byte );
BEGIN;    Put_Attribut  (Page,
                         Ecr[Page].Color,
                         BackGround,
                         Ecr[Page].SurIntensite,
                         Ecr[Page].Clignotement);
END;
{************************************************************************}
Procedure Put_SurIntensite  (Page         : Byte ;
                             SurIntensite : Boolean );
BEGIN;    Put_Attribut  (Page,
                         Ecr[Page].Color,
                         Ecr[Page].BackGround,
                         SurIntensite,
                         Ecr[Page].Clignotement);
END;
{************************************************************************}
Procedure Put_Clignotement  (Page         : Byte ;
                             Clignotement : Boolean );
BEGIN;    Put_Attribut  (Page,
                         Ecr[Page].Color,
                         Ecr[Page].BackGround,
                         Ecr[Page].SurIntensite,
                         Clignotement);
END;
{************************************************************************}
Procedure Carte_Compatible   (Carte : Boolean);
BEGIN;    If Carte Then Ofset_Vram:=OFS_Compatible
                   else Ofset_Vram:=OFS_Pas_Compatible;
          Ecr[0].Page:=Ptr(Ofset_Vram,0);
          Ecr[1].Page:=Ptr(Ofset_Vram,4096);
          Ecr[2].Page:=Ptr(Ofset_Vram,4096*2);
          Ecr[3].Page:=Ptr(Ofset_Vram,4096*3);
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
ATTRIBUT_ECRIT:=Color+BackGround*16
                 +Byte(SurIntensite)*8+Byte(Clignotement)*128;
For COMPTEUR1:=1 To Length(Message) Do
                            Begin;
                            Ecr[Page].Page^[Y,X-1+Compteur1,Caractere]
                                           :=ORD ( Message[Compteur1] );
                            Ecr[Page].Page^[Y,X-1+Compteur1,Attr]
                                           :=ATTRIBUT_ECRIT;
                            End;
END;
{************************************************************************}
Procedure Carre             (Page         : Byte ;
                             Color        : Byte ;
                             Depart_X     : Byte ;
                             Depart_Y     : Byte ;
                             Longueur_X   : Byte ;
                             Longueur_Y   : Byte );
VAR ATTRIBUT_CARRE : BYTE;
VAR COMPTEUR1      : BYTE;
VAR COMPTEUR2      : BYTE;
BEGIN;
ATTRIBUT_CARRE:=Color*16;
For COMPTEUR1:=Depart_X To Depart_X+Longueur_X-1 Do
For COMPTEUR2:=Depart_Y To Depart_Y+Longueur_Y-1 Do BEGIN;
                             Ecr[Page].Page^[Compteur2,Compteur1,Caractere]
                                           :=32;
                             Ecr[Page].Page^[Compteur2,Compteur1,Attr]
                                           :=ATTRIBUT_CARRE;
                            End;

END;

{************************************************************************}

Procedure Cls               (Page         : Byte ;
                             Color        : Byte );
VAR ATTRIBUT_CLS : BYTE;
VAR COMPTEUR1      : BYTE;
VAR COMPTEUR2      : BYTE;
BEGIN;
ATTRIBUT_CLS:=Color*16;
For COMPTEUR1:=1 To MAX_X Do
For COMPTEUR2:=1 To MAX_Y Do BEGIN;
                             Ecr[Page].Page^[Compteur2,Compteur1,Caractere]
                                           :=32;
                             Ecr[Page].Page^[Compteur2,Compteur1,Attr]
                                           :=ATTRIBUT_CLS;
                            End;

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



BEGIN;{Carte video compatible ou non}
      Carte_Compatible (True);
      {Pamametres par défaut}
      Put_Page(Page_0); {La page active est la page zero}

      {Parametre par défaut des 4 pages ecran}
      Put_Attribut (Page_0,Blanc,Noir,SurIntensite,PasClignotement);
      Put_Attribut (Page_1,Blanc,Noir,SurIntensite,PasClignotement);
      Put_Attribut (Page_2,Blanc,Noir,SurIntensite,PasClignotement);
      Put_Attribut (Page_3,Blanc,Noir,SurIntensite,PasClignotement);

END.

{procedure ecrire | faire une ligne | un carre
sauver un bout de l'ecran | le restaurer
avec une liste chainé déja déclarer ou on donne un nom
à l'ecran sauvegardez}
{efacer une partie de l'ecran}
{choisir une fenetre active}