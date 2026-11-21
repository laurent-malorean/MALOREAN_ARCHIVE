Program Mandel;

Uses CGraph,Crt,gest_dac;



Var Cga                    : TGraphVga;
NbIter                     : Byte;
Xe,Ye                      : Integer;
X,Y                        : Real;
MinC1,MinC2,MinC3,MinC4    : real;
MaxC1,MaxC2,MaxC3,MaxC4    : real;
A1,A2,A3,A4                : real;
Ap1,Ap2,Ap3,Ap4            : real;
Det                        : real;

pasC1,pasC2,PasC3,PasC4    : real;

PC1                        : Array [0..319] Of real;
PC2                        : Array [0..199] Of real;
PC3                        : Array [0..319] Of real;
PC4                        : Array [0..199] Of real;

Procedure Courbe;

Begin; {1}


a1:=-20;
a2:=-0.000000000002;
a3:=-0.0000000000099;
a4:=-2;

MinC1:=0.35;
MaxC1:=0.37;
MinC2:=0.8;
MaxC2:=0.9;
MinC3:=0.01;
MaxC3:=0.011;
MinC4:=0.09;
MaxC4:=0.1;

pasC1:=(MaxC1-MinC1)/320;
pasC2:=(MaxC2-MinC2)/200;
pasC3:=(MaxC3-MinC3)/320;
pasC4:=(MaxC4-MinC4)/200;

For xe:=0 to 319 do PC1[xe]:=MinC1 +pasC1 *(xe+1);
For ye:=0 to 199 do PC2[ye]:=MinC2 +pasC2 *(ye+1);
For xe:=0 to 319 do PC3[xe]:=MinC3 +pasC3 *(xe+1);
For ye:=0 to 199 do PC4[ye]:=MinC4 +pasC4 *(ye+1);




For Xe:=0 to 319 Do
For Ye:=0 to 199 do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     NbIter:=1;
                     Det:=0;
                     While      (nbiter<50) and (abs(det)<0.01)
                             Do Begin {1.1.1.1}
                            Ap1:=A1;
                            Ap2:=A2;
                            Ap3:=A3;
                            Ap4:=A4;
                            A1:=Ln(abs(Ap1*Ap1+Ap2*Ap3)+1)+PC1[Xe];
                            A2:=Ln(abs(Ap2*(Ap1+Ap4))+1)+Pc2[Ye];
                            A3:=Ln(abs(Ap3*(Ap1+Ap4))+1)+PC3[Xe];
                            A4:=Ln(abs(Ap4*Ap4+Ap2*Ap3)+1)+PC4[Ye];

                            NbIter:=NbIter+1;

                            DET:=(A1*A4)-(A2*A3);
                                              End;   {1.1.1.1}

CGA.putpixel(Vga_Ecran,xe,ye,Round(det*500));



                                        End;    {1.1.1}

End; {1}


BEGIN;
Cga.GraphMode;
put_dac(Volcano);
Courbe;
repeat;
until keypressed;
END.





