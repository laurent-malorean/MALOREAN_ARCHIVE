USES CGraph,Crt,GEST_DAC;

Const Max=99;
      Max2=Max div 2;
VAR
     Xe,Ye    : WORD;
     X        : Word;
     F        : WORD;
     P1,P2    : Word;
     Tx,Ty    : ARRAY[0..99] Of BYTE;
     InterX,InterY    : Byte;
     VGA      : TGraphVga;
     cou : word;

BEGIN;
VGA.GraphMode;
Put_DAC(Volcano);
For Xe:=0 to 99 Do Begin;
                   Tx[Xe]:=Xe;
                   Ty[Xe]:=Xe;
                   End;


For x:=1 to 80 DO   Begin
                     InterY:=Ty[99];
                     For Xe:=0 To 98 Do Ty[Xe]:=Ty[Xe+1];
                     Ty[0]:=InterY;
For xe:=0 to 99 Do  Begin;
                     InterX:=Tx[0];
                     For F:=1 To 99 Do Tx[F-1]:=Tx[F];
                     Tx[99]:=InterX;

For Ye:=1 TO Xe DO Begin;
                    cou:=Tx[Xe]+Ty[Ye];
                    Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                    Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                    Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                    Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                    Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                    Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                    Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                    Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;

                   end;
                   end;
                   end;

repeat; until keypressed;
END.