 Uses Gest_Graph,Gest_DAc;


const max=5000;
const arete=100;

var  f : word;

Var Tabl1 : Array [0..max] of Integer;
Var Tabl2 : Array [0..max] of Integer;
Var Tabl3 : Array [0..max] of Integer;
Var F1,F2,F3 : Word;
Var color : integer;
Var oldcolor : integer;



procedure demo;
begin;
For f3:=500 to 1500 do  begin;
for f1:=0 to arete do
for f2:=f1 to arete do begin;
     color :=( (f1*f1+f2*f2)*f3 div (f1+f2+f3)    );
     vga_Centre[ mul320[f2]+f1]:=color ;
     vga_Centre[ mul320[f2]-f1]:=color ;
     vga_Centre[-mul320[f2]-f1]:=color ;
     vga_Centre[-mul320[f2]+f1]:=color ;
     vga_Centre[ mul320[f1]+f2]:=color ;
     vga_Centre[ mul320[f1]-f2]:=color ;
     vga_Centre[-mul320[f1]-f2]:=color ;
     vga_Centre[-mul320[f1]+f2]:=color ;

                        end;
                        end;{f3}
                        end;
{-----------------------------------------------------------------------}


Begin;

GraphMode;
Put_DAc(Blue);
For f1:=1 to max do tabl1[f1]:=round(30*cos(f1/40*3.14));
For f2:=1 to max do tabl2[f2]:=round(50*sin(f2/60*3.14));
For f3:=1 to max do If tabl2[f3 div 10]<>0 then tabl3[f3]:= round(50*tabl1[f3]/tabl2[f3 div 10]);

demo;



End.
