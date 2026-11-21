UNIT GEST_CHAINE;

INTERFACE
USES GESt_VIDEO;

CONST     Line_SPACE=('                                                          ');

PROCEDURE ECRIT_HOT_KEY(VAR TOUCHE1     : CHAR   ;
                        VAR TOUCHE2     : CHAR   ;
                            TEXTE       : STRING ;
                            COLOR_TEXTE : BYTE   ;
                            COLOR_KEY   : BYTE   ;
                            X,Y         : BYTE  );
{ecrit dans une case ou un bouton le texte ex:'~LOAD'
 et renvois les 2 touches d'appel ex: L et l}

IMPLEMENTATION
USES CRT;
{------------------------------------------------------------------------}
PROCEDURE ECRIT_HOT_KEY;
VAR       F   : BYTE;
VAR      X_TEXT : BYTE;
BEGIN;
TEXTCOLOR(COLOR_TEXTE);
GOTOXY(X,Y);
X_TEXt:=X;

For F:=1 To LENGTH(TEXTE) DO BEGIN;
                             IF TEXTE[f] ='~' THEN BEGIN;
                                                   INC(f);
                                                   TEXTCOLOR(COLOR_key);
                                                   ECRIT(TEXTE[F],X_TEXT,Y);
                                                   TOUCHE1:=(TEXTE[F]);
                                                   TEXTCOLOR(COLOR_TEXTE);
                                                   END
                                              ELSE ECRIT(TEXTE[F],X_TEXT,Y);
                             INC   (X_TEXT);
                             GOTOXY(X_TEXT,Y);
                             END;
       {recupere majuscule ou minuscule corespondant a touche1}
       IF ORD(TOUCHE1)>96 THEN TOUCHE2:=CHR( ORD(TOUCHE1)-32 ) ;
       IF ORD(TOUCHE1)<91 THEN TOUCHE2:=CHR( ORD(TOUCHE1)+32 ) ;

END;
{------------------------------------------------------------------------}

{------------------------------------------------------------------------}
BEGIN;
END.