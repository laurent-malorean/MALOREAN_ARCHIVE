{r-}   {$n-}
Program plan_anime_en_trois_d;

Uses Crt,Graph;

Var
Carte,Mode     : INteger;
A              : Integer;
N,P            : Integer;

{-----------------------------------------------}
Procedure boly;
Begin;
a:=0;
Repeat;
Line (Round( Cos(pi/180*a)  *200+300   ),Round( Sin(pi/180*a)  *100+100)
     ,Round( Cos(pi/180*N*A)*200+300   ),Round( Sin(pi/180*N*A)*100+100) );
A:=A+p;
Until A>360;





End;



Begin;
carte:=detect;
mode:=0;
InitGraph (carte,mode,'c:\turbo');
n:=2;
p:=2;
Boly;
Delay(3000);
Clearviewport;
N:=3;
Boly;
Delay(3000);
Clearviewport;



closegraph;
End.
