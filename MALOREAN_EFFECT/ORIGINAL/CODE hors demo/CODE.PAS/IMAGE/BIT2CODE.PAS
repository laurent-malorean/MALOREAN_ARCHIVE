USES CRT,DOS,GEST_GRAPH;
TYPE    TPAL    = ARRAY[1..5000] OF BYTE ;

VAR     PAL     : TPAL ;
        TEXTE   : ARRAY[0..3160] OF BYTE; {CONTIENT LE CODE DE LA PALETTE}
        DEPLA : WORD;
        CodImg : ARRAY[0..50000] Of Byte;
VAR    F : LongInt;
VAR    D100,D10 : BYTE;
VAR    N10      : BYTE; {LE NB - les 100ene   ex 486->86}
VAR   LIGNE     : BYTE; {SI LINGE =15 ->retour chariot}
VAR   DepGra    : WORD;
      Fichier     :  FILE;


PROCEDURE  LoadShoot (NOM : STRING);
Var        Merde       :  Byte;
           Fichier     :  FILE;

BEGIN;     Assign(Fichier,nom);
           Reset(Fichier, 1);
           BlockRead(Fichier,Merde,1);
           BlockRead(Fichier,Pal,768);
           BlockRead(Fichier,VGA_ECRAN,64000);
           Close(Fichier);
END;


PROCEDURE CONVERT_PAL;
VAR    F : WORD;
VAR    D100,D10 : BYTE;
VAR    N10      : BYTE; {LE NB - les 100ene   ex 486->86}
VAR   LIGNE     : BYTE; {SI LINGE =15 ->retour chariot}
BEGIN;


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

PROCEDURE SAVE_PAL (NAME : STRING);
VAR        Fichier     : File;
BEGIN;
Assign(FICHIER,name);
Rewrite (FICHIER,1);
BlockWRITE(Fichier,TEXTE,SizeOf(TEXTE));
Close(Fichier);
END;

PROCEDURE AIDE;
BEGIN;
                   D100:=VGA_ECRAN[F] DIV 100;
                   D10 :=VGA_ECRAN[F] DIV 10;
                   N10:=(VGA_ECRAN[F]-100*D100);
                   CodImg[DEPLA]  :=48+(D100);
                   CodImg[DEPLA+1]:=48+(N10 DIV 10);
                   CodImg[DEPLA+2]:=48+(N10 -10*(N10 DIV 10));
                   CodImg[DEPLA+3]:=ORD(',');
                   INC(DEPLA,4);
                   INC(LIGNE);
                   IF LIGNE=18 THEN BEGIN; INC(DEPLA);
                                           CodImg[DEPLA]:=ORD(10);
                                           INC(DEPLA);
                                           CodImg[DEPLA]:=ORD(13);
                                           LIGNE:=0;
                                           END;
END;


PROCEDURE CONVERT_IMG;
BEGIN;
Assign(Fichier,Paramstr(1)+'.co2');
Rewrite(Fichier,1);

DEPLA:=0; LIGNE :=0; FOR F:=0 TO 12000 DO AIDE;
INC(DEPLA); CodImg[DEPLA]:=ORD(10); INC(DEPLA); CodImg[DEPLA]:=ORD(13);
BlockWrite(Fichier,CodImg,DEPLA);
DEPLA:=0; LIGNE :=0; FOR F:=12001 TO 24000 DO AIDE;
INC(DEPLA); CodImg[DEPLA]:=ORD(10); INC(DEPLA); CodImg[DEPLA]:=ORD(13);
BlockWrite(Fichier,CodImg,DEPLA);
DEPLA:=0; LIGNE :=0; FOR F:=24001 TO 36000 DO AIDE;
INC(DEPLA); CodImg[DEPLA]:=ORD(10); INC(DEPLA); CodImg[DEPLA]:=ORD(13);
BlockWrite(Fichier,CodImg,DEPLA);
DEPLA:=0; LIGNE :=0; FOR F:=36001 TO 48000 DO AIDE;
INC(DEPLA); CodImg[DEPLA]:=ORD(10); INC(DEPLA); CodImg[DEPLA]:=ORD(13);
BlockWrite(Fichier,CodImg,DEPLA);
DEPLA:=0; LIGNE :=0; FOR F:=48001 TO 60000 DO AIDE;
INC(DEPLA); CodImg[DEPLA]:=ORD(10); INC(DEPLA); CodImg[DEPLA]:=ORD(13);
BlockWrite(Fichier,CodImg,DEPLA);
DEPLA:=0; LIGNE :=0; FOR F:=60001 TO 63999 DO AIDE;
INC(DEPLA); CodImg[DEPLA]:=ORD(10); INC(DEPLA); CodImg[DEPLA]:=ORD(13);
BlockWrite(Fichier,CodImg,DEPLA);

Close(Fichier);
END;


BEGIN;
GraphMode;
LOADSHOOT(PARAMSTR(1)+'.BIT');
CONVERT_PAL;
SAVE_PAL (PARAMSTR(1)+'.co1');
ConVERT_IMG;
TextMode;
END.