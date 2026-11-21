{r-}   {$n-}
Program plan_anime_en_trois_d;

Uses Crt,Graph,Graphic,save,mouse,Printer,Math;



Type

objet         = Array [1..5,1..3] of Shortint;

Link      = Array [1..4,1..2] Of Byte;

polygone = Array [1..20,1..5,1..3] of Shortint;

Const

cube :objet   = ( (-50,50,0),(50,50,0),(50,-50,0),(-50,-50,0),(-50,50,0) );
Liaison_Cube :Link  = ((1,2),(2,3),(3,4),(4,5) );

Var
{variable du polygone tournant}
poly  : polygone;


{--------------------}

P_vide        : TBuffer;
Image         : Record
                contenu : Array [1..32000] of byte;
                End;



{Variables de la projection a l'ecran}

Cent_x,Cent_y               : Integer;
Dist_obj                    : Real;

f,ff,fff                    : Integer;
 tr  : real;
{Varaiable propres à l'objet}
Xe,Ye      : Array [1..8] of Integer;
Xr,Yr,Zr   : Array [1..8] of real; {New variables apres la rotation}
X,Y,Z      : Array [1..8] of Real;
Pt         : Array [1..40,1..2] of ShortInt;

{variables propres a la transformation}
dx,dy      : Array [5..8] of real;



Procedure cor_poly;
Begin;
For f:=1 to 4 do Begin;
                 Poly [1,f,1]:=Cube[f,1];
                 Poly [1,f,2]:=Cube[f,2];
                 End;
                 Poly [1,5,1]:=Cube [1,1];
                 Poly [1,5,2]:=Cube [1,2];


For f:=2 to 20 do Begin;
                  For ff:=1 to 4 do Begin;
Poly[f,ff,1]:=Round((Poly[f-1,ff+1,1]-Poly[f-1,ff,1])/7+Poly[f-1,ff,1]);
Poly[f,ff,2]:=Round((Poly[f-1,ff+1,2]-Poly[f-1,ff,2])/7+Poly[f-1,ff,2]);
                                     End;
                  For ff:=1 to 5 do  Poly[f,ff,3]:=0;
Poly [f,5,1]:=Poly[f,1,1];
Poly [f,5,2]:=Poly[f,1,2];

                   End;
For f:=1 to 20 do for ff:=1 to 4 do
line (200+2*poly[f,ff,1],100+poly[f,ff,2],200+2*poly[f,ff+1,1],100+poly[f,ff+1,2]);

End;







Begin;
init_trigo;
sound(400);delay(50);nosound;
Affiche_souris;
Sauve (p_vide);
InitGr ('c:\turbo');
getimage(100,0,500,200,image);
Cor_poly;
Delay (2500);

Leavegr;
Charge (p_vide);
affiche_souris;
End.

