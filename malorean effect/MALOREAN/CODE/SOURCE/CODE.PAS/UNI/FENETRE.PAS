UNIT FENETRE;

INTERFACE

USES ECRAN;

CONST OMBRE     = TRUE ;
      PAS_OMBRE = FALSE;

CONST COULEUR_ECRITURE_BANDE = BLANC;
      COULEUR_FOND_BANDE     = BLEU;
      COULEUR_FOND_FENETRE   = BLANC;



TYPE OBJET_FENETRE = OBJECT
                     X,Y     : Byte; {position du coin supérieur gauche}
                     L_X,L_Y : Byte; {longueur de la fenetre}
                     OMBRE   : Boolean; {true si la win a une ombre }
                     Texte   : String;  {letexte en haut}
                     SHOW    : BOOLEAN; {TRUE SI affiche}
                     PAGE    : BYTE   ; {la page ou il est affiche}
                     {variable de sauvegarde de partie d'ecran precedent}
                     PROCEDURE INIT(nX,nY,nL_X,nL_Y : BYTE;
                                    nOMBRE          : BOOLEAN;
                                    nTEXTE          : STRING);
                     PROCEDURE OPEN (nPAGE           : BYTE );
                     PROCEDURE CLOSE;
                     END;

OBJET_POINTEUR_FENETRE = ^OBJET_FENETRE;


IMPLEMENTATION

{**************************************************************************}

PROCEDURE  OBJET_FENETRE.INIT(nX,nY,nL_X,nL_Y : BYTE;
                              nOMBRE          : BOOLEAN;
                              nTEXTE          : STRING);
BEGIN; X     := nX;      {initialise les memoires}
       Y     := nY;
       L_X   := nL_X;
       L_Y   := nL_Y;
       OMBRE := nOMBRE;
       TEXTE := nTEXTE;
       SHOW  := FALSE; {la fenetre n'est pas visible}
END;

{**************************************************************************}

PROCEDURE  OBJET_FENETRE.OPEN;
BEGIN;     SHOW := TRUE;  {la fenetre est visible}
           PAGE := nPAGE; {memorise la page d'affchage}
           Carre (PAGE,RIEN,COULEUR_FOND_FENETRE,X,Y,L_X,L_Y,BORDURE);
           Ligne_Plus_Texte (PAGE,COULEUR_ECRITURE_BANDE,COULEUR_FOND_BANDE,
                           SurIntensite,PasClignotement,X,Y,L_X,CENTRE,TEXTE);

END;

{**************************************************************************}

PROCEDURE  OBJET_FENETRE.CLOSE;
BEGIN;     SHOW:=FALSE;
           {restaure l'ecran precedent}
END;

{**************************************************************************}
{**************************************************************************}
{**************************************************************************}


BEGIN;
END.