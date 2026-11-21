USES CScreen,Crt;

VAR WinFond  : ObjWin;
    ModeText : TypeContenuWinAuto;
    WinText  : ObjWinAuto;
    F        : Word;
    x,y : byte;
    BUTTON1  : ObjButton ;
    STATE1   : TSTATE;
    BUTTON2  : ObjButton ;
    STATE2   : TSTATE;
    MOUSE    : ObjMouse;
    StateWinText : ShortInt;
    InterStateWinText : ShortInt;

    EcrText  : Array[1..8000] Of Word ABSOLUTE $B800:$0000;


PROCEDURE DEPART;
BEGIN;
ASM;
MOV AX,3;
INT 10h;
end;

For f:=1 to 2000 DO EcrText[f]:=0;


f:=0;
ModeText[1]:=('25 LIGNES VGA');
ModeText[2]:=('28 LIGNES VGA');
ModeText[3]:=('50 LIGNES VGA');

WinFond.Fond_Ecran(INTERNE1,BRUN,BLANC);
WinFond.Win4(INTERNE1,'CODING BY VOLPONE FOR MALOREAN EFFECT',
15,8,65,18,BLANC,BLEU,BLANC);
WinText.Init(20,11,3,Blanc,Bleu,VERT,CYAN,'TEXTE MODES',MODETEXT);
WinText.Show (INTERNE1);
Button1.Init (INTERNE1,45,12,BLANC,BLEU,'OK');
Button1.Show (INTERNE1);
Button2.Init (INTERNE1,45,14,BLANC,BLEU,'EXIT');
Button2.Show (INTERNE1);

ECRAN:=INTERNE1;
InterStateWinText:=1;
MOUSE.Show;
REPEAT;

STATE1:=Button1.State;
STATE2:=Button2.State;
InterStateWinText:=WinText.State;
If InterStateWinText>0 then StateWinText:=InterStateWinText;
UNTIL (State1=Alume) or (State2=Alume);


IF State1=Alume then Case StateWinText OF 1 : BEGIN;
                                              ASM;
                                              MOV AH,11h;
                                              MOV AL,14h;
                                              INT 10h;
                                              end;
                                              END;
                                          2 : BEGIN;
                                              ASM;
                                              MOV AH,11h;
                                              MOV AL,11h;
                                              INT 10h;
                                              end;
                                              END;
                                          3 : BEGIN;
                                              ASM;
                                              MOV AH,11h;
                                              MOV AL,12h;
                                              INT 10h;
                                              end;
                                              END;


                          end;


Mouse.erase;
TextColor(7);
GotoXY(1,1);
For x:=1 to 80 Do for y:=1 to 50 do Begin;
                                    Ecran[y,x,Couleur]:=Blanc+Bleu SHL 4 +8;
                                    Ecran[y,x,Caractere]:=32;
                                    End;

END;


BEGIN;
DEPART;
END.