{                UNIT DE GESTION DE BOUTON RATIO (*)
              (C) LAURENT DESECHALLIERS allias VOLPONE
                DEBUT                AOUT 1993
                DERNIERE MISE A JOUR AOUT 1993       }

UNIT GEST_RATIO;

INTERFACE

USES CRT,DOS,GEST_SOURIS,GEST_CLAVIER;


CONST   C_RATIO    = 7;
        B_RATIO    = 1;
        C_RATIO_t  = 2;

TYPE STRING25    =  STRING[25];

TYPE    T1RATIO  = OBJECT
                  X          : BYTE;
                  Y          : BYTE;
                  MESSAGE    : STRING25;
                  PRE_SCREEN : BYTE;
                  VIEW       : BOOLEAN;
                  TOUCHE1    : CHAR;
                  TOUCHE2    : CHAR;
                  LONGUEUR   : BYTE;
                  ETAT       : BOOLEAN;

                  PROCEDURE    VIRE_MUL ;
                  PROCEDURE    INIT  (RAT_X,RAT_Y  : BYTE       ;
                                      RAT_MESSAGE  : STRING25   ;
                                      RAT_ETAT     : BOOLEAN    ;
                                      RAT_LONGUEUR : BYTE         ) ;
                  PROCEDURE    OPEN   ;
                  PROCEDURE    CLOSE  ;
                  FUNCTION     STATE  : BOOLEAN ;
                  FUNCTION     HERE   : BOOLEAN ;

                  END;
TYPE    TRATIO   = OBJECT
                  VAR_RATIO : ARRAY [1..9] OF T1RATIO;
                  NO        : BYTE;
                  VIEW       : BOOLEAN;
                  NB         : BYTE;

                  PROCEDURE    INIT  (RAT_X,RAT_Y  : BYTE       ;
                                      RAT_MESSAGE1 : STRING25   ;
                                      RAT_MESSAGE2 : STRING25   ;
                                      RAT_MESSAGE3 : STRING25   ;
                                      RAT_MESSAGE4 : STRING25   ;
                                      RAT_MESSAGE5 : STRING25   ;
                                      RAT_MESSAGE6 : STRING25   ;
                                      RAT_MESSAGE7 : STRING25   ;
                                      RAT_MESSAGE8 : STRING25   ;
                                      RAT_MESSAGE9 : STRING25   ;
                                      RAT_NB       : BYTE       ; {NB DE RATIO}
                                      RAT_NO       : BYTE       ; {No du ratio choisi}
                                      RAT_LONGUEUR : BYTE         ) ;

                  PROCEDURE    OPEN              ;
{                 PROCEDURE    CLOSE             ;}
                  FUNCTION     STATE  : BYTE     ;
                  FUNCTION     HERE   : BOOLEAN  ;


                   END;

IMPLEMENTATION
{安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安}

PROCEDURE    T1RATIO.INIT  ;
VAR          REG         : REGISTERS;

BEGIN;      {INITIALISE LES VARIABLES PRIVES DE L'OBJET}
             X          := RAT_X ;
             Y          := RAT_Y  ;
             MESSAGE    := RAT_MESSAGE;

             VIEW       := FALSE;
             LONGUEUR   := RAT_LONGUEUR;
             ETAT       := RAT_ETAT;

             {SAUVEGARDE L'attribut de la ZONE ECRAN DE L'OBJ}
             GOTOXY(X,Y);
             REG.AH:=08;
             REG.BH:=0;
             INTR($10,REGISTERS(REG));
             PRE_SCREEN:=REG.AH;
END;

{---------------------------------------------------------------------------}

PROCEDURE    T1RATIO.OPEN   ;
VAR          F          : BYTE;
             INDEX_MES  : BYTE;
VAR          X_TEXT     : BYTE;
CONST        LINE    = ('                                                ');

BEGIN;       VIEW  := TRUE;
       {AFFICHE ( )  blablabla      }
       TEXTBACKGROUND(B_RATIO);
       TEXTCOLOR     (C_RATIO);
       GOTOXY(X,Y);
       WRITE(COPY((' ( )'+LINE),1,LONGUEUR));

       GOTOXY(X+5,Y);
       X_TEXt:=X+5;
       For F:=1 To LENGTH(MESSAGE) DO BEGIN;
                                      IF MESSAGE[f]
                                        ='^' THEN BEGIN; INC(f);
                                                       TEXTCOLOR(C_RATIO_T);
                                                       WRITE(MESSAGE[F]);
                                                       TOUCHE1:=(MESSAGE[F]);
                                                       TEXTCOLOR(C_RATIO);
                                                       END
                                                ELSE   WRITE(MESSAGE[F]);
                                      INC   (X_TEXT);
                                      GOTOXY(X_TEXT,Y);
                                      END;

       {Si true met *}
       IF ETAT=TRUE THEN BEGIN;
                         GOTOXY(X+2,Y);
                         WRITE('*');
                         END;


       {recupere majuscule ou minuscule corespondant a touche1};
       IF ORD(TOUCHE1)>96 THEN TOUCHE2:=CHR( ORD(TOUCHE1)-32 ) ;
       IF ORD(TOUCHE1)<91 THEN TOUCHE2:=CHR( ORD(TOUCHE1)+32 ) ;

END;

{---------------------------------------------------------------------------}

PROCEDURE T1RATIO.CLOSE   ;
CONST     LINE=('                                                          ');
BEGIN;    VIEW:=FALSE;
          TEXTATTR:=PRE_SCREEN;
          GOTOXY(X,Y);
          WRITE(COPY(LINE,1,LONGUEUR));
END;
{---------------------------------------------------------------------------}

FUNCTION T1RATIO.HERE;
BEGIN;   HERE:=VIEW;
END;

{---------------------------------------------------------------------------}
FUNCTION T1RATIO.STATE;
VAR       CARAC    : CHAR;
VAR       BOL1    : BOOLEAN;

VAR       MOUSE   : TSOURIS;
VAR       SO1,SO2 : BOOLEAN;
VAR       XSo,YSo : INTEGER;

BEGIN;
ETAT:=FALSE;
STATE:=FALSE;
IF VIEW=TRUE THEN BEGIN;
   IF GADGET_ETAT=TRUE THEN BEGIN;{KEYPRESSED}
                      CARAC:=GADGET_TOUCHE;

                  IF (CARAC=TOUCHE1)
                      OR (CARAC=TOUCHE2) THEN BEGIN;
                         WHILE KEYPRESSED DO CARAC:=READKEY;
                                              ETAT :=TRUE;
                                              STATE:=TRUE;
                                              GOTOXY(X+2,Y);
                                              TEXTBACKGROUND(B_RATIO);
                                              TEXTCOLOR     (C_RATIO);
                                              WRITE('*')
                                               END;
                          END; {KEYPRESSED}

   MOUSE.ETAT (So1,So2,So2,XSo,YSo);
   BOL1:=MOUSE.CLIP (XSo,YSo,X,Y,LONGUEUR,0);
   IF (So1=TRUE) AND (BOL1=TRUE) THEN BEGIN; {So1=TRUE}
                                      WHILE SO1=TRUE DO MOUSE.ETAT (So1,So2,So2,XSo,YSo);
                                      ETAT :=TRUE;
                                      STATE:=TRUE;

{                                         WHILE KEYPRESSED DO CARAC:=READKEY;}
                                         GOTOXY(X+2,Y);
                                         TEXTBACKGROUND(B_RATIO);
                                         TEXTCOLOR     (C_RATIO);
                                         WRITE('*')
                                        END  ; {So1=TRUE}
                           END; {VIEW=TRUE}
END;
{---------------------------------------------------------------------------}
PROCEDURE T1RATIO.VIRE_MUL;
BEGIN;   GOTOXY(X+2,Y);
         TEXTBACKGROUND(B_RATIO);
         TEXTCOLOR     (C_RATIO);
         WRITE(' ');
         ETAT:=FALSE;
END;

{安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安}
PROCEDURE TRATIO.INIT;
BEGIN;
NO := RAT_NO;
NB := RAt_NB;
VAR_RATIO[1].INIT(RAt_X , RAT_Y   , RAT_MESSAGE1 , FALSE , RAT_LONGUEUR);
VAR_RATIO[2].INIT(RAt_X , RAT_Y+1 , RAT_MESSAGE2 , FALSE , RAT_LONGUEUR);
VAR_RATIO[3].INIT(RAt_X , RAT_Y+2 , RAT_MESSAGE3 , FALSE , RAT_LONGUEUR);
VAR_RATIO[4].INIT(RAt_X , RAT_Y+3 , RAT_MESSAGE4 , FALSE , RAT_LONGUEUR);
VAR_RATIO[5].INIT(RAt_X , RAT_Y+4 , RAT_MESSAGE5 , FALSE , RAT_LONGUEUR);
VAR_RATIO[6].INIT(RAt_X , RAT_Y+5 , RAT_MESSAGE6 , FALSE , RAT_LONGUEUR);
VAR_RATIO[7].INIT(RAt_X , RAT_Y+6 , RAT_MESSAGE7 , FALSE , RAT_LONGUEUR);
VAR_RATIO[8].INIT(RAt_X , RAT_Y+7 , RAT_MESSAGE8 , FALSE , RAT_LONGUEUR);
VAR_RATIO[9].INIT(RAt_X , RAT_Y+8 , RAT_MESSAGE9 , FALSE , RAT_LONGUEUR);
VAR_RATIO[NO].ETAT:=TRUE;
END;

{---------------------------------------------------------------------------}

PROCEDURE TRATIO.OPEN;
VAR       F  : BYTE;
BEGIN; VIEW:=TRUE;
       FOR F:=1 TO NB  DO VAR_RATIO[F].OPEN;

END;
{---------------------------------------------------------------------------}
FUNCTION TRATIO.HERE;
BEGIN;   HERE:=VIEW;
END;
{---------------------------------------------------------------------------}
FUNCTION TRATIO.STATE;
VAR      F   : BYTE;
VAR      BOL1   :  BOOLEAN;
BEGIN;
FOR F:=1 TO NB DO BEGIN;
                  IF f<>NO THEN BEGIN;
                                BOL1:=VAR_RATIO[F].STATE;
                                IF (BOL1=TRUE) THEN BEGIN;
                                                    VAR_RATIO[NO].VIRE_MUL;
                                                    NO:=F;
                                                    end;
                                                    END;
                                END;
STATE:=NO;
END;

{安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安}
END.