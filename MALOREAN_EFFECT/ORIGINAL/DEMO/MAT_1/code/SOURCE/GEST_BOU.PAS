{                   UNIT DE GESTION DE BOUTTONS
              (C) LAURENT DESECHALLIERS allias VOLPONE
                DEBUT                AOUT 1993
                DERNIERE MISE A JOUR AOUT 1993       }

UNIT GEST_BOUTTON;

INTERFACE

USES CRT,DOS,GEST_SOURIS,GEST_CLAVIER;

CONST   C_But    = 7+8;
        B_But    = 1;
        C_touche = 2+8;
        C_Ombre  = 0;

TYPE    STRING7         = STRING[7];

TYPE    TBUTTON = OBJECT
                  X          : BYTE;
                  Y          : BYTE;
                  MESSAGE    : STRING7;
                  PRE_SCREEN : BYTE;
                  VIEW       : BOOLEAN;
                  TOUCHE1    : CHAR;
                  TOUCHE2    : CHAR;


                  PROCEDURE    UTIL  (DEPLACEMENT  : BYTE);
                  {Si deplacement=1->bouton est enfonce}

                  PROCEDURE    INIT  (BUT_X,BUT_Y : BYTE     ;
                                      BUT_MESSAGE  : STRING7 );
                  PROCEDURE    OPEN   ;
                  PROCEDURE    CLOSE  ;
                  FUNCTION     STATE  : BOOLEAN ;
                  FUNCTION     HERE   : BOOLEAN ;

                  END;

IMPLEMENTATION
{°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²}
PROCEDURE    TBUTTON.UTIL (DEPLACEMENT  : BYTE) ;
VAR          F           : BYTE;
VAR          X_TEXT      : BYTE;

BEGIN;
       {RESTAURATION LA ZONE ECRAN DE L'OBJ}
       TEXTATTR:=PRE_SCREEN;
       GOTOXY(X,Y);
       WRITE('           ');
       GOTOXY(X,Y+1);
       WRITE('           ');

      {gere enfoncement du bouton}
       If deplacement=1 Then INC(X);

       {AFFICHE LA LIGNE DU BOUTON}
       TEXTBACKGROUND(B_BUT);
       TEXTCOLOR     (C_BUT);
       GOTOXY(X,Y);
       WRITE('         ');

       {affiche le text du bouton,et touve la touche de fonction}
       X_TEXT:=X+((9-LENGTH(MESSAGE)) SHR 1);
       GOTOXY(X_TEXT,Y);
       For F:=1 To LENGTH(MESSAGE) DO BEGIN;
                                      IF MESSAGE[f]
                                        ='^' THEN BEGIN; INC(f);
                                                       TEXTCOLOR(C_TOUCHE);
                                                       WRITE(MESSAGE[F]);
                                                       TOUCHE1:=(MESSAGE[F]);
                                                       TEXTCOLOR(C_BUT);
                                                       END
                                                ELSE   WRITE(MESSAGE[F]);
                                      INC   (X_TEXT);
                                      GOTOXY(X_TEXT,Y);
                                      END;
       {Si bouton pas enfonce met ombre}
       If DEPLACEMENT=0 THEN BEGIN;
                             TEXTCOLOR      (C_OMBRE);
                             TEXTBACKGROUND (PRE_SCREEN SHR 4);
                             GOTOXY(X+1,Y+1);
                             WRITE('ßßßßßßßßß');
                             GOTOXY(X+9,Y);
                             WRITE('Ü');
                             END;

       {gere enfoncement du bouton}
       If deplacement=1 Then DEC(X);

       {recupere majuscule ou minuscule corespondant a touche1};
       IF ORD(TOUCHE1)>96 THEN TOUCHE2:=CHR( ORD(TOUCHE1)-32 ) ;
       IF ORD(TOUCHE1)<91 THEN TOUCHE2:=CHR( ORD(TOUCHE1)+32 ) ;

END;
{---------------------------------------------------------------------------}
PROCEDURE    TBUTTON.INIT  ;
VAR          OFS         : WORD;
             F1,F2       : BYTE;
             REG         : REGISTERS;

BEGIN;
             {INITIALISE LES VARIABLES PRIVES DE L'OBJET}
             X         := BUT_X ;
             Y         := BUT_Y  ;
             MESSAGE   := BUT_MESSAGE;
             VIEW      := FALSE;

             {SAUVEGARDE L'attribut de la ZONE ECRAN DE L'OBJ}
             GOTOXY(X,Y);
             REG.AH:=08;
             REG.BH:=0;
             INTR($10,REGISTERS(REG));
             PRE_SCREEN:=REG.AH;

END;

{---------------------------------------------------------------------------}

PROCEDURE    TBUTTON.OPEN   ;
BEGIN;       VIEW  := TRUE;
             UTIL     (0);
END;

{---------------------------------------------------------------------------}

PROCEDURE    TBUTTON.CLOSE  ;
BEGIN;       VIEW  := FALSE;
             {RESTAURATION LA ZONE ECRAN DE L'OBJ}
             TEXTATTR:=PRE_SCREEN;
             GOTOXY(X,Y);
             WRITE('           ');
             GOTOXY(X,Y+1);
             WRITE('           ');
END;

{---------------------------------------------------------------------------}

FUNCTION  TBUTTON.STATE  : BOOLEAN ;
VAR       CARAC   : CHAR;
VAR       BOL1    : BOOLEAN;

VAR       MOUSE   : TSOURIS;
VAR       SO1,SO2 : BOOLEAN;
VAR       XSo,YSo : INTEGER;

BEGIN; STATE:=FALSE;
       IF VIEW =TRUE THEN BEGIN; {N'ANIME LE BOUTON QUE SI IL EST A L'ECRAN}
       IF GADGET_ETAT THEN BEGIN;{KEYPRESSED}
                          CARAC:=GADGET_TOUCHE;
                          IF (CARAC=TOUCHE1)
                          OR (CARAC=TOUCHE2) THEN BEGIN;
                                               UTIL(1);
                                               STATE:=TRUE;
                                               WHILE KEYPRESSED DO CARAC:=READKEY;
                                               DELAY(200);
                                               UTIL(0);
                                               END;
                          END; {KEYPRESSED}

        MOUSE.ETAT (So1,So2,So2,XSo,YSo);
        BOL1:=MOUSE.CLIP (XSo,YSo,X,Y,9,0);
        IF (So1=TRUE) AND (BOL1=TRUE) THEN BEGIN; {So1=TRUE}
                                           WHILE SO1=TRUE DO MOUSE.ETAT (So1,So2,So2,XSo,YSo);
                                           MOUSE.CACHER;
                                           UTIL(1);
                                           MOUSE.MONTRER;
                                           STATE:=TRUE;
                                           WHILE KEYPRESSED DO CARAC:=READKEY;
                                           DELAY(200);
                                           MOUSE.CACHER;
                                           UTIL(0);
                                           MOUSE.MONTRER;
                                           END  ; {So1=TRUE}


                          END;{VIEW=TRUE}
END;

{---------------------------------------------------------------------------}

FUNCTION     TBUTTON.HERE   : BOOLEAN ;
BEGIN;       HERE:=VIEW;

END;
{---------------------------------------------------------------------------}

{°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²°²}
END.