Uses CScreen,Crt;

Var
    x  : Byte;
    y  : Byte;

Begin;

For x:=1 to 80 Do for y:=1 to 50 do Begin;
                                    Ecran[y,x,Couleur]:=Blanc+Bleu SHL 4 +8;
                                    Ecran[y,x,Caractere]:=32;
                                    End;
Gotoxy(1,1);

End.