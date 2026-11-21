USES GEST_GRAPH,GEST_DAC,CRT;

VAR   Xe,Ye,Ze : Word;
      Dx,Dy    : ARRAY [0..319] Of Integer;
      Delta    : Integer;
      Cou      : Byte;




BEGIN
GraphMode;
PUT_DAC(GEST_DAC.BLUE);

Delta:=1;

For Ze:=1 to 500 Do Begin;

Delta:=Delta+5;
For Xe:=1 to 319 Do Dx[Xe]:=((Xe+Delta)*(Xe+Delta) +(Xe+Xe+Delta) ) ;

Asm;
           MOV  DX,03DAh
     @VBL: IN   AL,DX
           TEST AL,8
           JZ   @VBL;
end;

For Xe:=0 to 199 Do
For Ye:=0 to 199 Do Begin;
                    Cou:=(Xe+Ze)*(Xe+Ze)+(Ye-Ze)*(Ye-Ze);
                    Vga[Mul320[Ye]+Xe]:=Cou;

                    end;

END; {for ze}

END.