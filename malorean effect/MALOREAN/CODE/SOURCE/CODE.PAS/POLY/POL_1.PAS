USES GEST_GRAPH,GEST_DAC,CRT;

VAR   Xe,Ye,Ze : Word;
      Dx,Dy    : ARRAY [0..319] Of Integer;
      Delta    : Integer;
      Carre    : Array [0..5000] of Word;


BEGIN
for Xe:=0 to 5000 do Carre[Xe]:=Xe*Xe;
GraphMode;
PUT_DAC(GEST_DAC.BLUE);

Delta:=1;

For Ze:=1 to 500 Do Begin;

Delta:=Delta+5;

For Xe:=1 to 319 Do Dx[Xe]:=Carre[Xe+Delta] ;

Asm;
           MOV  DX,03DAh
     @VBL: IN   AL,DX
           TEST AL,8
           JZ   @VBL;
end;

For Xe:=0 to 180 Do For Ye:=0 to 180 Do Vga[Mul320[Ye]+Xe]:=Dx[Xe]-Dx[Ye];

END; {for ze}

Repeat; until keypressed;
END.