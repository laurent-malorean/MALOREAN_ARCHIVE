Uses CGraph,crt;

Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       cou      : Byte;
       ff       : word;
      ECR1     : ^Type_graph_ecran;
Mul : array [0..5096] Of Word;

Procedure plot;
begin;

         Vga_Ecran[t[g+100]+f+160]:=Cou;
         Vga_Ecran[t[f+100]+g+160]:=cou;
         Vga_Ecran[t[100-g]+f+160]:=Cou;
         Vga_Ecran[t[100-f]+160+g]:=Cou;
         Vga_Ecran[t[100-g]+-f+160]:=Cou;
         Vga_Ecran[t[-f+100]-g+160]:=cou;
         Vga_Ecran[t[100+g]-f+160]:=Cou;
         Vga_Ecran[t[100+f]+160-g]:=Cou;

end;



Begin;
For f:=0 to 64 do for g:=0 to 60 do mul[f*64+g]:=f*g;
New(ecr1);
Vga.GraphMode;
ecr1^:=vga_ecran;

for c:=5 to 50  do Begin;
                    for f:=0 to 90 do
                    for g:=f to 90 do Begin;
                                      cou:=Mul[f shl 6 +g]*c and (c)  ;
                                      plot;
                                      end;
                    end;

for c:=5 to 50  do Begin;
                    for f:=0 to 90 do
                    for g:=f to 90 do Begin;
                                      cou:=Mul[(f shl 6)+g]*c and (-c)  ;
                                      plot;
                                      end;
                    end;

for c:=5 to 50  do Begin;
                    for f:=0 to 60 do
                    for g:=f to 60 do Begin;
                                      cou:=Mul[(f shl 6)+g]*c and (-c+f+g)  ;
                                      plot;
                                      end;
                    end;

for c:=5 to 50  do Begin;
                    for f:=0 to 60 do
                    for g:=f to 60 do Begin;
                                      cou:=mul[(f shl 6)+g]*c and (-c-f+g)  ;
                                      plot;
                                      end;
                    end;

for c:=5 to 50  do Begin;
                    for f:=0 to 60 do
                    for g:=f to 60 do Begin;
                                      cou:=mul[(f shl 6)+g]*c and (-c-f-g)  ;
                                      plot;
                                      end;
                    end;


VGA.TextMode;

END.