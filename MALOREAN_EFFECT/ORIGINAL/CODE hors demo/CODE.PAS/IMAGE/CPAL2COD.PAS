USES CRT,DOS; {convertit point pal en point cod pour le C++}
TYPE    TPAL    = ARRAY[1..256*3] OF BYTE ;

VAR     PAL     : TPAL ;
        TEXTE   : ARRAY[0..3160] OF BYTE;
        DEPLA : WORD;

PROCEDURE LOADPAL (NAME : STRING);
VAR        Fichier     : File;
begin;   Assign(Fichier,Name);
         Reset(Fichier, 1);
         BlockRead(Fichier,Pal,SizeOf(Pal));
         Close(Fichier);
         end;


PROCEDURE CONVERT;
VAR    F : WORD;
VAR    D100,D10 : BYTE;
VAR    N10      : BYTE; {LE NB - les 100ene   ex 486->86}
VAR   LIGNE     : BYTE; {SI LINGE =15 ->retour chariot}
BEGIN;
DEPLA :=1;
LIGNE :=0;
FOR F:=1 TO 768 DO BEGIN;
                   D100:=PAL[F] DIV 100;
                   D10 :=PAL[F] DIV 10;
                   N10:=(PAL[F]-100*D100);
                   TEXTE[DEPLA]  :=48+(D100);
                   TEXTE[DEPLA+1]:=48+(N10 DIV 10);
                   TEXTE[DEPLA+2]:=48+(N10 -10*(N10 DIV 10));
                   TEXTE[DEPLA+3]:=ORD(',');
                   INC(DEPLA,4);
                   INC(LIGNE);
                   IF LIGNE=18 THEN BEGIN; INC(DEPLA);
                                           TEXTE[DEPLA]:=ORD(10);
                                           INC(DEPLA);
                                           TEXTE[DEPLA]:=ORD(13);
                                           LIGNE:=0;
                                           END;

                   END;
END;

PROCEDURE SAVE_TEXT (NAME : STRING);
VAR        Fichier     : File;
BEGIN;
Assign(FICHIER,name);
Rewrite (FICHIER,1);
BlockWRITE(Fichier,TEXTE,SizeOf(TEXTE));
Close(Fichier);

END;

BEGIN;
LOADPAL(PARAMSTR(1)+'.PAL');
CONVERT;
SAVE_TEXT (PARAMSTR(1)+'.cod');
END.