USES GEST_GRAPH,GEST_DAC,VARIABLE,CRT;


PROCEDURE A;
VAR   ETAT_VBL  : BYTE;
VAR   Compteur  : Word;
VAR   F         : BYTE;
VAR   BufPulse  : Word;
BEGIN
COmpteur:=0;
F:=45;
GraphMode;
PUT_DAC(GEST_DAC.BLUE);
REPEAT  Inc(compteur);
if compteur=0 then begin; asm;     @VBL1: IN   AL,DX
           TEST AL,8
           JZ   @VBL1;        end;end;


        ASM;       MOV  DX      , 03DAh
             @VBL: IN   AL      , DX
                   MOV  ETAT_VBL, AL

        End;
        VGA[Compteur]:=Pulse or etat_vbl ;
Until F=100

END;


BEGIN
A;


END.