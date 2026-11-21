Program Mandel;

Uses CGraph,crt;




Var Cga         : tGraphVga;


Procedure Courbe;
Var

Xe,Ye                  : LongInt;
X,Xp,Y                 : LongInt;
Amin,Bmin,Amax,Bmax    : LongInt;
pasX,pasY              : Real;
module                 : LongInt;
NbIter                 : LongInt;


Px                     : Array [0..319] Of LongInt;
Py                     : Array [0..199] Of LongInt;
F : Integer;
couleur : byte;


Begin;

Amin:= Round( -2.2*2048    );
Amax:= Round(  0.7*2048  );
Bmin:= Round( -1.5*2048  );
Bmax:= Round(  1.5*2048  );

pasX:=(Amax-Amin)/320;
pasY:=( (Bmax-Bmin)/200);


For xe:=0 to 319 do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to 199 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));



For Ye:=0 to 100 Do begin;
For Xe:=0 to 320 do Begin;
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<35)
                            and (Module<16777216) Do Begin
                                 Xp:=( (x*x-y*y)  div (2048) )     +Px[Xe];
                                 Y:=( ((X*Y     ) DIV 1024  ))  +  Py[Ye];
                                 X:=Xp;
                                 Inc(NbIter,1);
                                 module:=SQR(x)-( sqr(y) Shl 4);
                                 End;

If module>16777216 then couleur:=Nbiter And 255 ;
If (module<16777216) and (y<>0) then couleur:=x Mod y;

Vga_Ecran[t[ye]+xe]:=couleur;
Vga_Ecran[t[199-ye]+xe]:=Couleur;


                                        End;
end;
End;



BEGIN;
Cga.GraphMode;
loadpal ('e:\tp\pal\Volcano.pal');
Courbe;
END.





