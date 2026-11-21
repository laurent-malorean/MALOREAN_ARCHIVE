Uses CGraph,crt;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       cou      : Byte;
       ff       : word;
      ECR1     : ^Type_graph_ecran;
Mul : array [0..60,0..60] Of Word;

Procedure plot;
begin;   Vga.Putpixel  (ecr1^,+f+160,g+100,cou );
         Vga.Putpixel  (ecr1^,g+160,100+f,cou );

         Vga.Putpixel  (ecr1^,f+160,-g+100,cou );
         Vga.Putpixel  (ecr1^,160+g,100-f,cou );

         Vga.Putpixel  (ecr1^,-f+160,-g+100,cou );
         Vga.Putpixel  (ecr1^,160-g,100-f,cou );

         Vga.Putpixel  (ecr1^,-f+160,g+100,cou );
         Vga.Putpixel  (ecr1^,160-g,100+f,cou );
end;



Begin;
For f:=0 to 60 do for g:=0 to 60 do mul[f,g]:=f*g;
New(ecr1);
Vga.GraphMode;
ecr1^:=vga_ecran;
for c:=5 to 50  do Begin;
                    for f:=0 to 60 do
                    for g:=f to 60 do Begin;
                                      cou:=f*g*c and (c)  ;
                                      plot;
                                      end;
                    move (ecr1^,Vga_ecran,64000);
                    end;

for c:=5 to 50  do Begin;
                    for f:=0 to 60 do
                    for g:=f to 60 do Begin;
                                      cou:=Mul[f,g]*c and (-c)  ;
                                      plot;
                                      end;
                    move (ecr1^,Vga_ecran,64000);
                    end;

for c:=5 to 50  do Begin;
                    for f:=0 to 60 do
                    for g:=f to 60 do Begin;
                                      cou:=Mul[f,g]*c and (-c+f+g)  ;
                                      plot;
                                      end;
                    move (ecr1^,Vga_ecran,64000);
                    end;

for c:=5 to 50  do Begin;
                    for f:=0 to 60 do
                    for g:=f to 60 do Begin;
                                      cou:=mul[f,g]*c and (-c-f+g)  ;
                                      plot;
                                      end;
                    move (ecr1^,Vga_ecran,64000);
                    end;

for c:=5 to 50  do Begin;
                    for f:=0 to 60 do
                    for g:=f to 60 do Begin;
                                      cou:=mul[f,g]*c and (-c-f-g)  ;
                                      plot;
                                      end;
                    move (ecr1^,Vga_ecran,64000);
                    end;


VGA.TextMode;

END.