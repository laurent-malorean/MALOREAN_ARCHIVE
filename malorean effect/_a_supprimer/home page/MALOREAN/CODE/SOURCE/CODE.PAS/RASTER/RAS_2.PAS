USES GEST_GRAPH,GEST_DAC,VARIABLE,CRT;

VAR     VGA      : T_VGA  ABSOLUTE $A000:16000;

PROCEDURE A;
VAR   ETAT_VBL  : BYTE;
VAR   Compteur  : Word;
VAR   F         : BYTE;
VAR   BufPulse  : Word;
BEGIN
COmpteur:=0;
F:=45;
GraphMode;
PUT_DAC(GEST_DAC.PAL4);
REPEAT  Inc(compteur);
        ASM;       MOV  DX      , 03DAh
             @VBL: IN   AL      , DX
                   MOV  ETAT_VBL, AL
        End;
        VGA[Compteur]:=Pulse + Etat_VBL;
        If compteur>36000 then compteur:=0
Until F=100

END;


BEGIN
A;


END.