{r-}   {$n-}
Program plan_anime_en_trois_d;

Uses Crt,Graph,Graphic,save,mouse,Printer,Math;



Type

objet         = Array [1..4,1..3] of Shortint;

Link      = Array [1..4,1..2] Of Byte;

polygone = Array [1..20,1..5,1..3] of Shortint;

Const

cube :objet   = ( (-50,-50,0),(50,-50,0),(0,50,0),(-50,-50,0));





Var
{variable du polygone tournant}
poly  : polygone;


{--------------------}

P_vide        : TBuffer;
Image         : Record
                contenu : Array [1..32000] of byte;
                End;

{Variable pour la matrice}

Rx,Ry,Rz                     : Real;
Cx,Cy,Cz                     : Integer;
A,B,Cc                       : Integer; {les 3 angles}
m1,m2,m3,m4,m5,m6,m7,m8,m9   : Real;


{Variables de la projection a l'ecran}

Cent_x,Cent_y               : Integer;
Dist_obj                    : Real;

f,ff,fff                    : Integer;
 tr  : real;
{Varaiable propres … l'objet}
Xe,Ye      : Array [1..8] of Integer;
Xr,Yr,Zr   : Array [1..8] of real; {New variables apres la rotation}
X,Y,Z      : Array [1..8] of Real;
Pt         : Array [1..40,1..2] of ShortInt;

{variables propres a la transformation}
dx,dy      : Array [5..8] of real;

Procedure info;
Begin;
cent_x:=300; cent_y:=100;
a:=0;b:=0;cc:=0;dist_obj:=25;
Cx:=0;Cy:=0;cz:=0;
End;


Procedure cor_poly;
Begin;
For f:=1 to 3 do Begin;
                 Poly [1,f,1]:=Cube[f,1];
                 Poly [1,f,2]:=Cube[f,2];
                 End;
                 Poly [1,4,1]:=Cube [1,1];
                 Poly [1,4,2]:=Cube [1,2];


For f:=2 to 20 do Begin;
                  For ff:=1 to 3 do Begin;
Poly[f,ff,1]:=Round((Poly[f-1,ff+1,1]-Poly[f-1,ff,1])/7+Poly[f-1,ff,1]);
Poly[f,ff,2]:=Round((Poly[f-1,ff+1,2]-Poly[f-1,ff,2])/7+Poly[f-1,ff,2]);
                                     End;
                  For ff:=1 to 4 do  Poly[f,ff,3]:=0;
Poly [f,4,1]:=Poly[f,1,1];
Poly [f,4,2]:=Poly[f,1,2];

                   End;
For f:=1 to 20 do for ff:=1 to 3 do
line (200+2*poly[f,ff,1],100+poly[f,ff,2],200+2*poly[f,ff+1,1],100+poly[f,ff+1,2]);

End;




Procedure obj_1;
Var f: Integer;
x1,y1,z2 : Array [1..8] of real;

Begin;

For f:=1 to 8 do begin;
                 If a>360   then a:= a-360;
                 if a<-360  then a:= a+360;
                 if b>360   then b:= b-360;
                 if b<-360  then b:= b+360;
                 If cc>360  then cc:=cc-360;
                 if cc<-360 then cc:=cc+360;
Putimage(100,0,image,0);

For f:=1 to 20 do for ff:=1 to 5 do Begin;
	                            x1[ff]:=C(a)*poly[f,ff,1]-S(a)*poly[f,ff,2];
	  	                    y1[ff]:=S(a)*poly[f,ff,1]+C(a)*poly[f,ff,2];
			            xr[ff]:=C(b)*x1[ff]-S(b)*poly[f,ff,3];
		                    z2[ff]:=S(b)*  x1[ff]  +C(b)*poly[f,ff,3];
		                    zr[ff]:=C(cc)*  z2[ff]  - C(cc)*y1[ff];
			            Yr[ff]:=S(cc)*  z2[ff]  + C(cc)*y1[ff];

                 Xe[ff]:=Round (Xr[ff]/dist_obj)+Cent_x;
                 Ye[ff]:=Round(Yr[ff]/(2*Dist_obj) )+Cent_y;

                 End;
For ff:=1 to 5 do line (Xe[f],Ye[f],Xe[f+1],Ye[f+1]);

                End;




End;

Procedure affiche_motif;
Begin;
a:=0;
For  fff :=1 to 50 do begin;

a:=a+1;
obj_1;
end;

End;


{-----------------------------------------------}
Begin;
init_trigo;
sound(400);delay(50);nosound;
Affiche_souris;
Sauve (p_vide);
InitGr ('c:\turbo');
info;
getimage(100,0,500,200,image);
Cor_poly;
Delay (2500);
{affiche_motif;}

Leavegr;
Charge (p_vide);
affiche_souris;
End.

