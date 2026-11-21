Var    x        : word;
       y        : word;
       c        : word ;
       cou      : Byte;
       MUL80    : ARRAY [0..200] Of Word;
       x1,y1 : word;

begin;
graphMode4Plan;
loadpal ('c:\tp\pal\volcano.pal');
for c:=0 to 200  do Begin;
                    for x:=0 to 99 do
                    for y:=x to 99 do Begin;
                                      cou:= (c-x*y)  +y*c;
                                      Vga_Ecran[t[y+100]+x+160]:=Cou;
                                      Vga_Ecran[t[x+100]+y+160]:=cou;
                                      Vga_Ecran[t[100-y]+x+160]:=Cou;
                                      Vga_Ecran[t[100-x]+160+y]:=Cou;
                                      Vga_Ecran[t[100-y]+-x+160]:=Cou;
                                      Vga_Ecran[t[-x+100]-y+160]:=cou;
                                      Vga_Ecran[t[100+y]-x+160]:=Cou;
                                      Vga_Ecran[t[100+x]+160-y]:=Cou;
                                      end;
                    end;
END.