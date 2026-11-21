UNIT GEST_DIRECTORY;


INTERFACE

USES CRT,DOS,GEST_ASSENCEUR,GEST_BOUTTON,GEST_CLAVIER;

TYPE STRING12 = STRING[12];

TYPE T_DIR     = OBJECT
                  {VAR}
                  NbFile       : Integer;
                  CHEMIN       : STRING;
                  Fichier      : TASSENCEUR_TEXT ;
                  {OBJECT}
                  ASSENCEUR    : TASSENCEUR;
                  OK           : TBUTTON;
                  CANCEL       : TBUTTON;
                  BAK          : TBUTTON;

                  CONSTRUCTOR INIT                         ;
                  DESTRUCTOR  DONE                         ; VIRTUAL;
                  PROCEDURE   OPEN                         ; VIRTUAL;
                  FUNCTION    STATE : STRING               ; VIRTUAL;
                  END;

TYPE T_DIR_FILE= OBJECT (T_DIR)
                  PROCEDURE  NEW (BUF_Chemin   : String;
                                  MASK         : STRING );
                  END;

TYPE T_DIR_DIRECTORY = OBJECT (T_DIR)
                  PROCEDURE  NEW (BUF_Chemin   : String);  VIRTUAL;
                  PROCEDURE  OPEN                  ;       VIRTUAL;
                  END;

TYPE T_DIR_DISK = OBJECT (T_DIR)
                  PROCEDURE  NEW                   ;       VIRTUAL;
                  END;




IMPLEMENTATION

CONSTRUCTOR T_DIR.INIT;
BEGIN;
END;
{-----------------------------------------------------------------------}
DESTRUCTOR T_DIR.DONE;
BEGIN;
END;
{-----------------------------------------------------------------------}
PROCEDURE T_DIR.OPEN;
BEGIN;
ASSENCEUR.OPEN;
OK       .OPEN;
CANCEL   .OPEN;
END;
{-----------------------------------------------------------------------}
FUNCTION T_DIR.STATE;
VAR BOL_OK     : BOOLEAN;
VAR BOL_CANCEL : BOOLEAN;
VAR COMPTEUR1  : INTEGER;
VAR BUF_CHEMIN : STRING;
BEGIN;   REPEAT; GADGET_TOUCHE_ETAT;
                 ASSENCEUR.STATE;
                 BOL_OK    :=OK    .STATE;
                 BOL_CANCEL:=CANCEL.STATE;
                 If BAK.STATE THEN BEGIN;
                                   {CREE LE CHEMIN DE CD..}
                                   COMPTEUR1 :=LENGTH(CHEMIN);
                                   {Si ex  e:\ ALORS PAS ..}
                                   IF COMPTEUR1>2 THEN BEGIN;
                                                       DEC(COMPTEUR1);
                                                       REPEAT;
                                                       CHEMIN[COMPTEUR1]:=#0;
                                                       DEC(COMPTEUR1);
                                                       UNTIL CHEMIN[COMPTEUR1]='\';
{                  NEW(CHEMIN);}
                                          {NEW(ADRESS);}
                                                       END;
                                   END;
                 UNTIL BOL_OK OR BOL_CANCEL;

         IF BOL_OK THEN STATE:=CHEMIN+Fichier[ASSENCEUR.ASSEN.NO_OBJ_ACTIF]
                   ELSE STATE:='CANCEL';

END;
{**************************************************************************}
{**************************************************************************}
PROCEDURE T_DIR_FILE.NEW;
VAR       DirInfo      : SearchRec;
VAR       STRING_NB_FILE : STRING;
VAR       BUF_FICHIER  : STRING[12];
VAR       COMPTEUR1    : BYTE;
VAR       COMPTEUR2    : BYTE;

BEGIN;    CHEMIN:=BUF_CHEMIN+'\';
          NbFile:=0;
          FindFirst(Chemin+MASK,$20,DirInfo);
          NbFile:=0;
          WHILE DosError=0 DO BEGIN; BUF_Fichier:=DirInFo.Name;
                                     Fichier[NbFile+1]:=BUF_FICHIER;
                                     FindNext(DirInfo);
                                     Inc(NbFile);
                                     END;
          If NBFILE>100 THEN NBFILE:=100;
          STR (NbFile,STRING_NB_FILE);
          ASSENCEUR.INIT(10,5,15,15,MASK,NbFile,FICHIER,STRING_NB_FILE+' FICHIERS');
          OK    .INIT (30,07,'~OK');
          CANCEL.INIT (30,09,'~CANCEL');
END;
{**************************************************************************}
{**************************************************************************}
PROCEDURE T_DIR_DIRECTORY.NEW;
VAR       DirInfo      : SearchRec;
VAR       STRING_NB_FILE : STRING;
VAR       BUF_FICHIER  : STRING[12];
VAR       COMPTEUR1    : BYTE;
VAR       COMPTEUR2    : BYTE;

BEGIN;    CHEMIN:=BUF_CHEMIN+'\';
          FindFirst(Chemin+'*.',$10,DirInfo);
          NbFile:=0;
          FindNext(DirInfo); {VIRE . et ..}
          FindNext(DirInfo);
          WHILE DosError=0 DO BEGIN; BUF_Fichier:=DirInFo.Name;
                                     Fichier[NbFile+1]:=BUF_FICHIER;
                                     FindNext(DirInfo);
                                     Inc(NbFile);
                                     END;
          If NBFILE>100 THEN NBFILE:=100;
          STR (NbFile,STRING_NB_FILE);
          ASSENCEUR.INIT(10,5,15,15,CHEMIN,NbFile,FICHIER,STRING_NB_FILE+' DIRECTORY');
          OK    .INIT (30,07,'~OK');
          CANCEL.INIT (30,09,'~CANCEL');
          BAK   .INIT (30,11,'~BAK');

END;
{-----------------------------------------------------------------------}
PROCEDURE T_DIR_DIRECTORY.OPEN;
BEGIN;    T_DIR. OPEN;
          BAK.OPEN; {PAR ROPPORT AU FICHIER ET DISQUE RAJOUTE BOUTON BAK(..)}
          END;
{**************************************************************************}
{**************************************************************************}
PROCEDURE T_DIR_DISK.NEW;
VAR       STRING_NB_FILE : STRING;
VAR       REG            : REGISTERS;
VAR       F              : BYTE;
CONST    DISK            : ARRAY [1..26] Of STRING[18]=
         ('FLOPY DSIQUE A','FLOPY DISQUE B',
         'DISQUE DUR C','DISQUE DUR D','DISQUE DUR E','DISQUE DUR F',
         'DISQUE DUR G','DISQUE DUR H','DISQUE DUR I','DISQUE DUR J',
         'DISQUE DUR K','DISQUE DUR L','DISQUE DUR M','DISQUE DUR N',
         'DISQUE DUR O','DISQUE DUR P','DISQUE DUR Q','DISQUE DUR R',
         'DISQUE DUR S','DISQUE DUR T','DISQUE DUR T','DISQUE DUR T',
         'DISQUE DUR T','DISQUE DUR T','DISQUE DUR T','DISQUE DUR T');

BEGIN;    REG.AH:=$0E;
          REG.DL:=2;
          INTR($21,REG);
          NbFile:=REG.AL;
          FOR F:=1 TO NbFILE DO Fichier[F]:=DISK[F];

          STR (NbFile,STRING_NB_FILE);
          ASSENCEUR.INIT(10,5,20,15,'UNITES DISQUE',NbFile,FICHIER,'  '+STRING_NB_FILE+' UNITEES');
          OK    .INIT (32,07,'~OK');
          CANCEL.INIT (32,09,'~CANCEL');
END;
{-----------------------------------------------------------------------}
END.