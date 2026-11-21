Program Mandel;

Uses CGraph;



Var Cga                    : TGraphVga;


Procedure Courbe;
Var
Xe,Ye                  : Integer;
X,Xp,Y                 : LongInt;
Amin,Bmin,Amax,Bmax    : LongInt;
pasX,pasY              : LongInt;
module                 : LongInt;
NbIter                 : Byte;

Px                     : Array [0..319] Of LongInt;
Py                     : Array [0..199] Of LongInt;

Begin; {1}

Amin:= Round( -2*512  );
Amax:= Round(  1*512  );
Bmin:= Round( -1.2*512);
Bmax:= Round(  1.2*512);
pasX:=Round( 512*(Amax-Amin)/320);
pasY:=Round( 512*(Bmax-Bmin)/200);
For xe:=0 to 319 do Px [xe]:=Round  ( (amin+pasx*(xe+1)) *512);
For ye:=0 to 199 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)) *512);




For Xe:=0 to 320 Do
For Ye:=0 to 200 do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<50)
                            and (Module<4) Do Begin {1.1.1.1}
                                              Xp:=(SQR(x)-SQR(Y)+Px[xe]) DIV 512;
                                              Y:=(2*X*Y   +Py[ye]) DIV 512;
                                              X:=Xp;
                                              NbIter:=NbIter+1;
                                              module:=SQR(x)+SQR(y);
                                              End;   {1.1.1.1}

CGA.putpixel(Vga_Ecran,xe,ye,NbIter AND 10);



                                        End;    {1.1.1}

End; {1}


BEGIN;
Cga.GraphMode;
Courbe;
END.





