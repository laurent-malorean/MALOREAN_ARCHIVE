Uses CGraph,crt;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       cou      : Byte;


Begin;
Vga.GraphMode;


for c:=0 to 100  do Begin;
                    for f:=0 to 50 do
                    for g:=0 to 30 do Begin;

                                      cou:=f*g*c and (c+f+g);
                                      cou:=(c+f+g) and f*g*c;
                                      Vga.Putpixel  (vga_ecran,-f+160,g+100,cou );
                                      Vga.Putpixel  (vga_ecran,f+160,-g+100,cou );
                                      Vga.Putpixel  (vga_ecran,-f+160,-g+100,cou );
                                      Vga.Putpixel  (vga_ecran,f+160,g+100,cou );
                                      end;
                    end;
VGA.TextMode;

END.