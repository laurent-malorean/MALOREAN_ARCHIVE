UNIT GEST_WINDOWS;

INTERFACE

USES CRT,DOS,GEST_VIDEO,GEST_CHAINE;

CONST C_LANGUE        =7+8;
      C_TOUCHE_LANGUE =2;
      B_LANGUE        =1;
      B_WIN           =6;


TYPE TWINDOW  =   OBJECT
                      X                : BYTE;
                      Y                : BYTE;
                      LONGUEUR_X       : BYTE;
                      LONGUEUR_Y       : BYTE;
                      MESSAGE          : STRING;
                      PROCEDURE INIT (BUF_X              : BYTE;
                                      BUF_Y              : BYTE;
                                      BUF_LONGUEUR_X     : BYTE;
                                      BUF_LONGUEUR_Y     : BYTE;
                                      BUF_MESSAGE        : STRING );
                      PROCEDURE OPEN ;

                      END;

IMPLEMENTATION
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
PROCEDURE TWINDOW.INIT;
BEGIN;    X                 :=  BUF_X                           ;
          Y                 :=  BUF_Y                           ;
          LONGUEUR_X        :=  BUF_LONGUEUR_X                  ;
          LONGUEUR_Y        :=  BUF_LONGUEUR_Y                  ;
          MESSAGE           :=  COPY(BUF_MESSAGE,1,LONGUEUR_X-2);
END;
{-------------------------------------------------------------------------}
PROCEDURE TWINDOW.OPEN;
VAR       F         : BYTE;
VAR       X_TEXT    : BYTE;
VAR       TOUCHE1   : CHAR;
BEGIN;    {AFFICHE LA LANGUE}
          LINE           (X,Y,LONGUEUR_X,B_LANGUE  );
          {AFFCIHE LE MESSAGE}
          ATTRIBUT       (C_LANGUE,B_LANGUE,FALSE,FALSE);
          X_TEXT       :=(2*X+LONGUEUR_X-LENGTH(MESSAGE) )  DIV 2;
          ECRIT_HOT_KEY  (TOUCHE1,TOUCHE1,MESSAGE,C_LANGUE,C_TOUCHE_LANGUE,
                                                                X_TEXT,Y);
          {AFFCIHE LA FENETRE}
          TEXTBACKGROUND(B_WIN);
          FOR F:=1 TO LONGUEUR_Y DO LINE (X,Y+F,LONGUEUR_X,B_WIN );
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}

END.



























