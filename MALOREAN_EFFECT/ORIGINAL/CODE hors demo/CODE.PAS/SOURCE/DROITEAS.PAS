Uses CGraph;


VAR
VGA : TGraphVga;


Procedure Line     (X1,Y1,X2,Y2,C : Word);
VAR Deltax,Deltay     : WORD;
    Dx2,Dy2           : WORD;
    S1,S2             : ShortInt;
    X,Y               : WORD;
    Erreur            : Integer;
    Temp              : WORD;
    InterChange       : WORD;
    F                 : WORD;
    VGA               : TGraphVga;

BEGIN;
ASM;
   PUSH AX;
   PUSH BX;

   MOV S1,0;
   MOV S2,0;
   MOV DeltaY,0;

   MOV AX,X1;       {x:=x1}
   MOV X,AX;
   MOV AX,Y1;       {y:=y1}
   MOV Y,AX;

   MOV AX,X2;       {compare X2 a X1}
   MOV BX,X1;

   CMP BX,AX;
   JA  @ElseDeltaX;
   SUB AX,BX;        {Si X2>X1 Deltax=AX}
   MOV DeltaX,Ax;    {DeltaX:=Ax}
   MOV DX2,AX;       {deltaX:=Dx2}
   MOV S1,1;         {S1:=1}
   JMP @PartieDeltaY;
   @ElseDeltaX: ;
   SUB BX,AX;        {Si X2<X1 Deltax=BX}
   MOV DeltaX,BX;    {DeltaX:=BX}
   MOV DX2,BX;       {DeltaX:=DX2}
   MOV S1,-1;        {S1=-1}

   @PartieDeltaY:  ;
   MOV AX,Y2;        {compare Y2 a Y1}
   MOV BX,Y1;

   CMP BX,AX;
   JA  @ElseDeltaY;
   SUB AX,BX;        {Si Y2>Y1 DeltaY=AX}
   MOV DeltaY,Ax;    {DeltaY:=Ax}
   MOV DY2,AX;       {DY2:=DeltaX}
   MOV S2,1;         {S2:=1}
   JMP @FinPartie1;
   @ElseDeltaY: ;
   SUB BX,AX;        {Si X2<X1 DeltaY=BX}
   MOV DeltaY,BX;    {DeltaY:=BX}
   MOV DY2,BX;       {DX2:=DeltaX}
   MOV S2,-1;        {s2:=-1}

   @FinPartie1: ;

   MOV AX,DeltaX;
   MOV BX,DeltaY;
   CMP BX,AX;
   JA @ElseCompareDelta;
   MOV InterChange,0;
   JMP @FinPartie2;
   @ElseCompareDelta: ;
   MOV CX,AX; {CX:=DeltaX}
   MOV DX,BX; {DX:=DeltaY}
   MOV AX,DX; {DeltaX;=DeltaY a present}
   MOV BX,CX; {DeltaY:=DeltaX a present}
   MOV InterChange,1; {Interchange:=1}
   @FinPArtie2:;


   POP BX;
   POP AX;

end;

If Deltay>Deltax Then Begin;
                      ASM;
                         MOV AX,DeltaX;
                         MOV BX,DeltaY;
                         MOV CX,AX; {CX:=DeltaX}
                         MOV DX,BX; {DX:=DeltaY}
                         MOV AX,DX; {DeltaX;=DeltaY a present}
                         MOV BX,CX; {DeltaY:=DeltaX a present}
                         MOV InterChange,1; {Interchange:=1}
   end;
              End
              Else ASM;
                      MOV InterChange,0;
                      end;

ASM;

    SHL DX2,1;
    SHL DY2,1;

END;
Dy2:=DeltaY Shl 1;

Erreur:=Dy2 -Deltax;

For F:=1 To Deltax Do Begin;
                  VGA.Putpixel (vga_ecran,x,y,c);
                  While Erreur>=0 Do Begin;
                                     If InterChange=1 Then Inc(X,S1)
                                                      Else Inc(Y,S2);
                                     dec(Erreur,Dx2);
                                     End;
                  If InterChange=1 Then Inc(Y,S2)
                                   Else Inc(X,S1);
                  Inc(Erreur,Dy2);
                  End;

END;

Begin;
VGA.GraphMode;
Line(10,10,100,150,7);
Line(10,10,100,10,3);
LINE(10,10,10,100,2);
end.