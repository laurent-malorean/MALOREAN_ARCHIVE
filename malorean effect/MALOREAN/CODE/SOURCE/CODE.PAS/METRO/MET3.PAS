{PARTIE TEXTE DE METRONOME}

USES CRT,DOS,GEST_VIDEO,GEST_WINDOWS;


VAR DROITE     : BOOLEAN     ;
VAR ATTENTE    : WORD        ;
VAR F          : BYTE        ;
VAR d_ATTENTE  : WORD        ;

VAR B_MOUSE    : WORD        ;

Const Line_Space=('                                                       ');

PROCEDURE  SHOW_INTERFACE;
VAR PRINCIPALE : TWINDOW;
BEGIN;
CLS(BLANC);
ATTRIBUT(BLANC,BLEU,TRUE,FALSE);
LINE_TEXTE (0,'(7/1 To +/- 1 To Delay) (8/2 To +/- 10 To Delay) (9/3 To +/- 100 To Delay)',TEXTATTR);
ATTRIBUT(BLANC,BLEU,TRUE,FALSE);
LINE_TEXTE (16,'CREDIT  ',TEXTATTR);
LINE_TEXTE (17,'VOLPONE: CODE               MOMOL: IDEA  ',TEXTATTR);

LINE_TEXTE (19,'Volpone say hello to his Pc\Amiga\Instrumental Musicians\ friends:',TEXTATTR);
LINE_TEXTE (20,'Sally,Toto,Fbi,Silk,Weg,TmB,42 Crew,Sun,RedLight,Locked,Mc2,MD,Mickey,Fafa',TEXTATTR);
LINE_TEXTE (21,'Les Castros Juniors,Olivier.S(Picon Bière),Cyrille.L,Xavier.S,Assim.B',TEXTATTR);
LINE_TEXTE (22,'Benoit.T,Philou,David.N,Fabien.D,Manu(Tome pouce)',TEXTATTR);

LINE_TEXTE (24,'Non !!!! Pitié , pas Richard Clayderman .. ARG ....',TEXTATTR);


PRINCIPALE.INIT(10,3,60,12,'METRONOME Version1 by Malorean Effect');
PRINCIPALE.OPEN;
ATTRIBUT(BLANC,6,TRUE,FALSE);
ECRIT('DELAY : ',30,5);
ATTRIBUT(BLANC,BLEU,TRUE,FALSE);
For f:=7 to 13 Do ECRIT(COPY(LINE_SPACE,1,50),15,f);

DROITE:=FALSE;
ATTENTE:=500;

END;

PROCEDURE CHANGE_TEMPO;
VAR D_PRE : WORD;
VAR TOUCHE     : CHAR        ;
BEGIN;

IF KEYPRESSED THEN TOUCHE:=READKEY else touche:=#0;
While Keypressed Do ReadKey;

If (Touche=#55) AND (ATTENTE<3000) Then Inc(Attente,1  );
If (Touche=#49) AND (ATTENTE>5)    Then Dec(Attente,1  );
If (Touche=#56) AND (ATTENTE<3000) Then Inc(Attente,10 );
If (Touche=#50) AND (ATTENTE>11)   Then Dec(Attente,10 );
If (Touche=#57) AND (ATTENTE<3000) Then Inc(Attente,100);
If (Touche=#51) AND (ATTENTE>110)  Then Dec(Attente,100);

If Touche=#27   Then Begin;
                     Nosound;
                     Attribut(Blanc,Noir,False,False);
                     Cls(Noir);
                     Curseur(TRUE);
                     ClrScr;
                     ATTRIBUT(BLANC,BLEU,TRUE,FALSE);
                     LINE_TEXTE (0,'For the future: METRONOME Version2 with SB Support',TEXTATTR);
                     LINE_TEXTE (1,'For the future: A rhythm generator for rhythm guitar works',TEXTATTR);
                     GotoXY(1,3);
                     Halt(1);
                     End;
D_PRE:=D_attente;
D_attente:=ATTENTE DIV 47;

IF D_PRE<>D_ATTENTE THEN BEGIN;
                         ATTRIBUT(BLANC,6,TRUE,FALSE);
                         GOTOXY(40,5);
                         WRITE('      ');
                         GOTOXY(40,5);
                         WRITE(ATTENTE);
                         END;
END;



PROCEDURE SCROOL;
BEGIN;

REPEAT;



ATTRIBUT(BLANC,6,TRUE,FALSE);
GOTOXY(40,5); WRITE('      '); GOTOXY(40,5); WRITE(ATTENTE);

IF DROITE THEN BEGIN;
               FOR F:=15 TO 62 DO BEGIN;
                                  Change_Tempo;
                                  ATTRIBUT(BLANC,BLEU,TRUE,FALSE);
                                  ECRIT(' ',80-F-1,07);
                                  ECRIT(' ',80-F-1,08);
                                  ECRIT(' ',80-F-1,09);
                                  ECRIT(' ',80-F-1,10);
                                  ECRIT(' ',80-F-1,11);
                                  ECRIT(' ',80-F-1,12);
                                  ECRIT(' ',80-F-1,13);
                                  CHANGE_TEMPO;
                                  ATTRIBUT(BLANC,NOIR,TRUE,FALSE);
                                  ECRIT(' ',80-F-2,07);
                                  ECRIT(' ',80-F-2,08);
                                  ECRIT(' ',80-F-2,09);
                                  ECRIT(' ',80-F-2,10);
                                  ECRIT(' ',80-F-2,11);
                                  ECRIT(' ',80-F-2,12);
                                  ECRIT(' ',80-F-2,13);
                                  DELAY(D_attente);
                                  END;

               DROITE:=FALSE;
               sound(400);
               delay(100);
               NOSOUND;
               END


          ELSE BEGIN;
               FOR F:=15 TO 62 DO BEGIN;
                                  Change_Tempo;
                                  ATTRIBUT(BLANC,BLEU,TRUE,FALSE);
                                  ECRIT(' ',F,07);
                                  ECRIT(' ',F,08);
                                  ECRIT(' ',F,09);
                                  ECRIT(' ',F,10);
                                  ECRIT(' ',F,11);
                                  ECRIT(' ',F,12);
                                  ECRIT(' ',F,13);

                                  ATTRIBUT(BLANC,NOIR,TRUE,FALSE);
                                  ECRIT(' ',F+1,07);
                                  ECRIT(' ',F+1,08);
                                  ECRIT(' ',F+1,09);
                                  ECRIT(' ',F+1,10);
                                  ECRIT(' ',F+1,11);
                                  ECRIT(' ',F+1,12);
                                  ECRIT(' ',F+1,13);

                                  DELAY(D_attente);
                                  END;
               DROITE:=TRUE;
               sound(400);
               delay(100);
               NOSOUND;
               END;
UNTIL f=200;
END;



BEGIN;
CURSEUR(FALSE);
SHOW_INTERFACE;
SCROOL;
CURSEUR(TRUE);

END.