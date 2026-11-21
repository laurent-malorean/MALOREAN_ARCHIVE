Uses gest_graph,Dac_code,dac_frac,crt;
Var    X,Y,Z    : word;
       cou      : Byte;
       Carre    : Array[0..400] Of Word;
       Cst1     : Word;
       Ofset    : Word;

procedure standVbl; assembler;
asm;
mov  dx,03DAh
@StandVBL1:  IN   al,dx
	     test al,8
	     jz   @StandVBL1
end;


Begin;
GraphMode;
Put_Dac(dac_frac.Pal4);
for Z:=1 to 350 do Carre[Z]:=Z*Z;

for Z:=1 to 600 do Begin
                   z:=z+3;
asm;
mov  dx,03DAh
@StandVBL1:  IN   al,dx
	     test al,8
	     jz   @StandVBL1
end;

for Y:=1 to 150 do Begin
                   Cst1:=Carre[z]+Carre[y]-y;
                   Ofset:=Mul320[Y];
for X:=1 to 150 do Begin
                  Vga[Ofset+X]:=(Cst1+Carre[x]+x) div (x+y+1);
                  end;
                  end;
                  end;
delay(2000);
END.