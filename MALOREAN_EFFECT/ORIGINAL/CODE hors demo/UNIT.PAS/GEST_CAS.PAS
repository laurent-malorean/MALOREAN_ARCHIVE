{                UNIT DE GESTION DE CASE A COCHER [√]
              (C) LAURENT DESECHALLIERS allias VOLPONE
                DEBUT                AOUT 1993
                DERNIERE MISE A JOUR AOUT 1993       }

UNIT GEST_CAS;

INTERFACE

USES CRT,DOS,GEST_SOURIS,GEST_CLAVIER;

CONST   C_CAS    = 7;
        B_CAS    = 1;
        C_touche = 2;

TYPE STRING25    =  STRING[25];

TYPE    TCASE   = OBJECT
                  X          : BYTE;
                  Y          : BYTE;
                  MESSAGE    : STRING25;
                  PRE_SCREEN : BYTE;
                  VIEW       : BOOLEAN;
                  ETAT       : BOOLEAN;
                  TOUCHE1    : CHAR;
                  TOUCHE2    : CHAR;
                  LONGUEUR   : BYTE;


                  PROCEDURE    INIT  (CAS_X,CAS_Y  : BYTE       ;
                                      CAS_MESSAGE  : STRING25   ;
                                      CAS_ETAT     : BOOLEAN    ;
                                      CAS_LONGUEUR : BYTE         ) ;
                  PROCEDURE    OPEN   ;
                  PROCEDURE    CLOSE  ;
                  FUNCTION     STATE  : BOOLEAN ;
                  FUNCTION     HERE   : BOOLEAN ;

                  END;

IMPLEMENTATION
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}

PROCEDURE    TCASE.INIT  ;
VAR          REG         : REGISTERS;

BEGIN;      {INITIALISE LES VARIABLES PRIVES DE L'OBJET}
             X         := CAS_X ;
             Y         := CAS_Y  ;
             MESSAGE   := CAS_MESSAGE;
             VIEW      := FALSE;
             ETAT      := CAS_ETAT;
             LONGUEUR  := CAS_LONGUEUR;

             {SAUVEGARDE L'attribut de la ZONE ECRAN DE L'OBJ}
             GOTOXY(X,Y);
             REG.AH:=08;
             REG.BH:=0;
             INTR($10,REGISTERS(REG));
             PRE_SCREEN:=REG.AH;
END;

{---------------------------------------------------------------------------}

PROCEDURE    TCASE.OPEN   ;
VAR          F       : BYTE;
VAR          X_TEXT  : BYTE;
CONST        LINE    = ('                                                ');

BEGIN;       VIEW  := TRUE;
       {AFFICHE ( )  blablabla      }
       TEXTBACKGROUND(B_CAS);
       TEXTCOLOR     (C_CAS);
       GOTOXY(X,Y);
       WRITE(COPY((' [ ]'+LINE),1,LONGUEUR));

       GOTOXY(X+5,Y);
       X_TEXt:=X+5;
       For F:=1 To LENGTH(MESSAGE) DO BEGIN;
                                      IF MESSAGE[f]
                                        ='^' THEN BEGIN; INC(f);
                                                       TEXTCOLOR(C_TOUCHE);
                                                       WRITE(MESSAGE[F]);
                                                       TOUCHE1:=(MESSAGE[F]);
                                                       TEXTCOLOR(C_CAS);
                                                       END
                                                ELSE   WRITE(MESSAGE[F]);
                                      INC   (X_TEXT);
                                      GOTOXY(X_TEXT,Y);
                                      END;
       {met √ ou pas}
       IF ETAT=TRUE THEN BEGIN;
                         GOTOXY(X+2,Y);
                         WRITE('√')
                         END;



       {recupere majuscule ou minuscule corespondant a touche1};
       IF ORD(TOUCHE1)>96 THEN TOUCHE2:=CHR( ORD(TOUCHE1)-32 ) ;
       IF ORD(TOUCHE1)<91 THEN TOUCHE2:=CHR( ORD(TOUCHE1)+32 ) ;

END;

{---------------------------------------------------------------------------}

PROCEDURE TCASE.CLOSE   ;
CONST     LINE=('                                                          ');
BEGIN;    VIEW:=FALSE;
          TEXTATTR:=PRE_SCREEN;
          GOTOXY(X,Y);
          WRITE(COPY(LINE,1,LONGUEUR));
END;
{---------------------------------------------------------------------------}

FUNCTION TCASE.HERE;
BEGIN;   HERE:=VIEW;
END;

{---------------------------------------------------------------------------}
FUNCTION TCASE.STATE;
VAR      CARAC    : CHAR;
VAR       BOL1    : BOOLEAN;

VAR       MOUSE   : TSOURIS;
VAR       SO1,SO2 : BOOLEAN;
VAR       XSo,YSo : INTEGER;

BEGIN;
IF VIEW=TRUE THEN BEGIN;
   IF GADGET_ETAT THEN BEGIN;{KEYPRESSED}
                      CARAC:=GADGET_TOUCHE ;
                      IF (CARAC=TOUCHE1)
                      OR (CARAC=TOUCHE2) THEN BEGIN;
                                         IF ETAT=TRUE THEN BEGIN;
                                                           ETAT:=FALSE;
                                                           STATE:=FALSE;
                                                           END
                                                      ELSE BEGIN;
                                                           ETAT :=TRUE;
                                                           STATE:=TRUE;
                                                           END;

                                         WHILE KEYPRESSED DO CARAC:=READKEY;
                                         DELAY(100);
                                         GOTOXY(X+2,Y);
                                         TEXTBACKGROUND(B_CAS);
                                         TEXTCOLOR     (C_CAS);
                                         IF ETAT=TRUE THEN WRITE('√')
                                                      ELSE WRITE(' ');

                                               END;
                          END; {KEYPRESSED}

   MOUSE.ETAT (So1,So2,So2,XSo,YSo);
   BOL1:=MOUSE.CLIP (XSo,YSo,X,Y,LONGUEUR,0);
   IF (So1=TRUE) AND (BOL1=TRUE) THEN BEGIN; {So1=TRUE}
                                      WHILE SO1=TRUE DO MOUSE.ETAT (So1,So2,So2,XSo,YSo);

                                         IF ETAT=TRUE THEN BEGIN;
                                                           ETAT:=FALSE;
                                                           STATE:=FALSE;
                                                           END
                                                      ELSE BEGIN;
                                                           ETAT :=TRUE;
                                                           STATE:=TRUE;
                                                           END;

                                         WHILE KEYPRESSED DO CARAC:=READKEY;
                                         GOTOXY(X+2,Y);
                                         TEXTBACKGROUND(B_CAS);
                                         TEXTCOLOR     (C_CAS);
                                         IF ETAT=TRUE THEN WRITE('√')
                                                      ELSE WRITE(' ');
                                        END  ; {So1=TRUE}



                          END; {VIEW=TRUE}

STATE:=ETAT;
END;


{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
END.