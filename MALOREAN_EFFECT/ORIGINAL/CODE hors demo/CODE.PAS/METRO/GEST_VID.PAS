UNIT GEST_VIDEO;

INTERFACE

USES  CRT,
      DOS;

Const Noir    =0;
      Bleu    =1;
      Vert    =2;
      Cyan    =3;
      Rouge   =4;
      Magenta =5;
      Brun    =6;
      Blanc   =7;

TYPE  T1        = (caractere,couleur);
      T_Ecran   = ARRAY [1..25,1..80,Caractere..couleur] OF Byte;
      T_Ecran_Word   = ARRAY [1..25,1..80] OF WORD;
      T_4_ECRAN = ARRAY [1..4] OF T_ECRAN;
      T_LINE    = ARRAY [0..80] OF WORD;

VAR   PC_COMPATIBLE        : BOOLEAN;
VAR   SEG_VRAM             : WORD;


VAR   COMPATIBLE1          : T_Ecran      ABSOLUTE $B800:$0000;
VAR   PAS_COMPATIBLE1      : T_Ecran      ABSOLUTE $B000:$0000;
VAR   COMPATIBLE1_WORD     : T_Ecran_WORD ABSOLUTE $B800:$0000;
VAR   PAS_COMPATIBLE1_WORD : T_Ecran_WORD ABSOLUTE $B000:$0000;


VAR   TAB_COMPATIBLE       : T_4_Ecran ABSOLUTE $B800:$0000;
VAR   TAB_PAS_COMPATIBLE   : T_4_Ecran ABSOLUTE $B000:$0000;


PROCEDURE COMPATIBLE (BUF          : BOOLEAN);
{Mettre TRUE Si le PC est compatible ET la carte Apprtient a (CGA,EGA,VGA)
{Mettre FLASE Si le PC n'est pas compatible OU si la carte Apprtient}
{ a (Mda,Hercule}

PROCEDURE ATTRIBUT   (Couleur      : BYTE      ;
                      Fond         : BYTE      ;
                      Intensite    : BOOLEAN   ;
                      Clignotement : BOOLEAN ) ;
{Fixe l'ttribut dans TextAttr : est untilise par Procedure ECRIT}

PROCEDURE ECRIT      (MESSAGE      : String;
                      X,Y          : WORD);
{Ecrit : Procedure 4 fois plus rapide que la write de TP7
et je pense pouvoir encore l'optimiser }

FUNCTION CARTE                      : BOOLEAN;
{RENVOIS TRUE  SI LA CARTE EST COULEUR
         FALSE ''''''''''''''' MONOCROME}

PROCEDURE COPY_VRAM_TO_VRAM (Dest     : Byte      ;
                             Sour     : Byte       );
{Copy la page texte N° DEST vers la page texte N° SOUR}
{La VRAM a 4 Pages Ecran}
{La page N°1 est la page afiché à l'écran}



PROCEDURE CURSEUR    (BOL_            : BOOLEAN);
{BOL_ = TRUE   -> CURSEUR AFFFICHE
 BOL_ = FALSE  -> CURSEUR EFFACE  }

PROCEDURE CLS        (COULEUR         : BYTE   );
{EFFFACE L'ECRAN Avec la couleur }

PROCEDURE CLR        (COULEUR         : BYTE   );
{EFFFACE la fenetre active Avec la couleur }

PROCEDURE LINE       (X,Y             : WORD   ;
                      LONGUEUR        : WORD   ;
                      COULEUR         : BYTE    );
{TRACE UNE LIGNE PARTANT DE (X,Y) DE LONGUEUR "LONGUEUR"
 DE COULEUR "COULEUR" }

PROCEDURE LINE_TEXTE (Y               : WORD   ;
                      TEXTE           : STRING ;
                      ATTRIBUT        : BYTE   );
{TRACE UNE LIGNE A L'ABSCICE Y AVEC LE TEXTE "TEXTE" ET L'ATTRIBUT
"ATRIBUT" }

TYPE TCOPY  = OBJECT
              BUFFER : T_LINE;
              X,Y    : BYTE  ;
              LONG   : BYTE  ;
              PROCEDURE SAVE  (X_,Y_   : BYTE ;
                               LONG_   : BYTE );
              PROCEDURE LOAD;
              END;



{************************************************************************}
{************************************************************************}
{************************************************************************}
{************************************************************************}

IMPLEMENTATION

PROCEDURE ECRIT;
VAR       L_MESSAGE  :  WORD;
VAR       MSEG,MOFS  :  WORD;
VAR       ATTRIBUT   :  BYTE;
BEGIN;    L_MESSAGE  := LENGTH(MESSAGE)-1 ;
          MSEG       := SEG(MESSAGE[1])   ;
          MOFS       := OFS(MESSAGE[1])   ;
          ATTRIBUT   := TEXTATTR          ;
ASM;
          PUSH  DS
          {Calcul ES:DI de la Vram}
          MOV  AX,SEG_VRAM
          MOV  ES,AX
          MOV  DI,Y
          MOV  BX,DI
          SHL  DI,6
          SHL  BX,4
          ADD  DI,BX
          ADD  DI,X
          SHL  DI,1
          SUB  DI,162
          {Calcul DS:SI de message}
          MOV  AX,MSEG;
          MOV  DS,AX
          MOV  SI,MOFS;
          {EFFECTUE LE MOV De la chaine de caractere vers la Vram}
          MOV  BX,0
          MOV  AH,ATTRIBUT
@ECRIT1:  CMP  BX,L_MESSAGE
          JA   @FIN
          MOV  AL,DS:[SI]
          MOV  ES:[DI],AX
          ADD  BX,1
          ADD  DI,2
          INC  SI
          JMP  @ECRIT1
@FIN  :   POP  DS
END;
END;
{-------------------------------------------------------------------------}
PROCEDURE COMPATIBLE;
BEGIN;    PC_COMPATIBLE        := BUF   ;
          IF BUF THEN SEG_VRAM := $B800
                 ELSE SEG_VRAM := $B000 ;
END;
{--------------------------------------------------------------------------}
FUNCTION CARTE;
VAR      REG     : REGISTERS;
BEGIN;   Intr($11,Reg);
         If (Reg.al and 48)=32 Then CARTE:=TRUE
                               Else CARTE:=FALSE;
END;
{------------------------------------------------------------------------}
{--------------------------------------------------------------------------}
PROCEDURE COPY_VRAM_TO_VRAM;
BEGIN;
IF PC_Compatible THEN TAB_COMPATIBLE    [Sour] :=  TAB_COMPATIBLE    [Dest]
                 ELSE TAB_PAS_COMPATIBLE[Sour] :=  TAB_PAS_COMPATIBLE[Dest];
END;
{--------------------------------------------------------------------------}
PROCEDURE TCOPY.SAVE;
VAR F : BYTE ;
BEGIN;
X:=X_;
Y:=Y_;
LONG:=LONG_;
IF PC_COMPATIBLE
THEN FOR F:=X TO X+LONG DO BUFFER[F-X]:=    COMPATIBLE1_WORD[Y,F]
ELSE FOR F:=X TO X+LONG DO BUFFER[F-X]:=PAS_COMPATIBLE1_WORD[Y,F]
END;
{--------------------------------------------------------------------------}
PROCEDURE TCOPY.LOAD;
VAR F : BYTE ;
BEGIN;
IF PC_COMPATIBLE
THEN FOR F:=X TO X+LONG DO COMPATIBLE1_WORD[Y,F]:=BUFFER[F-X]
ELSE FOR F:=X TO X+LONG DO PAS_COMPATIBLE1_WORD[Y,F]:=BUFFER[F-X]
END;
{--------------------------------------------------------------------------}
PROCEDURE Curseur;
VAR       REG : REGISTERS;
BEGIN;    IF BOL_ THEN BEGIN;
                       Reg.AH:=$01;
                       Reg.CH:=6;
                       Reg.CL:=7;
                       Intr ($10,Registers(reg));
                       END
                  ELSE BEGIN;
                       Reg.ah:=$01;
                       Reg.ch:=$20;
                       Intr($10,registers(reg));
                       END;
END;
{--------------------------------------------------------------------------}
PROCEDURE CLS; ASSEMBLER;
ASM;      {Calcul ES:DI de la Vram}
          MOV  AX,SEG_VRAM
          MOV  ES,AX
          MOV  DI,0
          {EFFACE L'ECRAN}
          MOV  AH,COULEUR
          SHL  AH,4
          MOV  AL,32
@ECRIT1:  CMP  DI,4000
          JA   @FIN
          MOV  ES:[DI],AX
          ADD  DI,2
          JMP  @ECRIT1
@FIN  :
END;
{--------------------------------------------------------------------------}
PROCEDURE CLR;
VAR Xmin,Xmax,Ymin,Ymax : WORD
;
BEGIN;
Xmin:=LO(WindMin);
Ymin:=HI(WindMin);
Xmax:=LO(WindMax);
Ymax:=HI(WindMax);

ASM;      {Calcul ES:DI de la Vram}
          MOV  AX,SEG_VRAM
          MOV  ES,AX
          MOV  DI,0
          {EFFACE L'ECRAN}
          MOV  AH,COULEUR
          SHL  AH,4
          MOV  AL,32
@ECRIT1:  CMP  DI,4000
          JA   @FIN
          MOV  ES:[DI],AX
          ADD  DI,2
          JMP  @ECRIT1
@FIN  :
END;
END;
{--------------------------------------------------------------------------}

PROCEDURE LINE;
VAR       ATTRIBUT   :  BYTE     ;
BEGIN;    ATTRIBUT   := TEXTATTR ;
          ASM;
          {Calcul ES:DI de la Vram}
                   MOV  AX,SEG_VRAM
                   MOV  ES,AX
                   MOV  DI,Y
                   MOV  BX,DI
                   SHL  DI,6
                   SHL  BX,4
                   ADD  DI,BX
                   ADD  DI,X
                   SHL  DI,1
                   SUB  DI,162
                   {TRACE LA LIGNE}
                   MOV  BX,0
                   MOV  AH,COULEUR
                   SHL  AH,4
                   MOV  AL,32
          @ECRIT1: CMP  BX,LONGUEUR
                   JAE  @FIN
                   MOV  ES:[DI],AX
                   ADD  BX,1
                   ADD  DI,2
                   JMP  @ECRIT1
          @FIN  :
          END;
END;
{--------------------------------------------------------------------------}
PROCEDURE LINE_TEXTE (Y               : WORD   ;
                      TEXTE           : STRING ;
                      ATTRIBUT        : BYTE   );
VAR L_MESSAGE : WORD;
VAR MSEG,MOFS : WORD;
BEGIN;
L_MESSAGE  := LENGTH(TEXTE)   ;
MSEG       := SEG(TEXTE[1])   ;
MOFS       := OFS(TEXTE[1])   ;
ASM;
           PUSH  DS
           {Calcul ES:DI de la Vram}
           MOV  AX,SEG_VRAM
           MOV  ES,AX
           MOV  DI,Y
           MOV  BX,DI
           SHL  DI,7
           SHL  BX,5
           ADD  DI,BX
           {Calcul DS:SI de message}
           MOV  AX,MSEG;
           MOV  DS,AX
           MOV  SI,MOFS;
           {CALCULE L_VIDE=AX}
           MOV CX,80
           MOV BX,L_MESSAGE
           SUB CX,BX
           SHR CX,1
           {EFFECTUE LE '              ' vers la Vram}
           MOV  BX,0
           MOV  AH,ATTRIBUT
           MOV  AL,32
@L_TEXTE1: CMP  BX,CX
           JA   @L_TEXTE2
           MOV  ES:[DI],AX
           ADD  BX,1
           ADD  DI,2
           JMP  @L_TEXTE1
@L_TEXTE2: {EFFECTUE LE MOV De la chaine de caractere vers la Vram}
           ADD  CX,L_MESSAGE
@L_TEXTE3: CMP  BX,CX
           JA   @L_TEXTE4
           MOV  AL,DS:[SI]
           MOV  ES:[DI],AX
           ADD  BX,1
           ADD  DI,2
           INC  SI
           JMP  @L_TEXTE3
@L_TEXTE4:{EFFECTUE LE '              ' vers la Vram}
           MOV  CX,80
           MOV  AL,32
           CMP  BX,CX
           JAE  @L_TEXTE5
           MOV  ES:[DI],AX
           ADD  BX,1
           ADD  DI,2
           JMP  @L_TEXTE4
@L_TEXTE5: POP  DS
END;

END;
{--------------------------------------------------------------------------}
{--------------------------------------------------------------------------}
{--------------------------------------------------------------------------}
{--------------------------------------------------------------------------}
BEGIN
COMPATIBLE(CARTE);
END.