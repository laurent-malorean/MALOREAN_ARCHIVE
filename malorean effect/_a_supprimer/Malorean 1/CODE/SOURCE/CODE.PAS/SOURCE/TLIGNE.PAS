Unit Tligne;

Interface
Uses Graph,printer;

Procedure ligne (Xa,Ya,Xb,Yb: INteger);

Implementation

Procedure ligne ;
Var   f                         : Integer;
      dx,dy                     : Integer;
      Xmax,Xmin,Ymax,Ymin       : Integer;
      ydepart,Yfin,xdepart,Xfin : integer;
      X,Y                       : integer;
Begin;
If Xa<Xb Then Begin;
              Xmax:=Xb;
              Xmin:=Xa;
              Ydepart:=ya;
              yfin:=yb;
              End
              Else
              Begin;
              Xmax:=Xa;
              Xmin:=Xb;
              Ydepart:=yb;
              yfin:=ya;
              End;
If Ya<Yb Then Begin;
              Ymax:=Yb;
              Ymin:=Ya;
              Xdepart:=xa;
              xfin:=xb;
              End
              Else
              Begin;
              Ymax:=Ya;
              Ymin:=Yb;
              Xdepart:=xb;
              xfin:=xa;
              End;
Dx:=Xmax-Xmin;
Dy:=Ymax-Ymin;
If Xa=Xb then For f:=Ymin to Ymax Do Putpixel (Xa,F,7)
Else If Ya=Yb Then For f:=Xmin To Xmax Do Putpixel (F,YA,7)
Else If dy<dx Then Begin;
If Ydepart<Yfin Then Begin;
                     Y:=1;
                     For X:=1 To Dx Do Begin;
                                       If Y*Dx>X*Dy Then Else Y:=Y+1;
                                       PutPixel(Xmin+X,Ydepart+Y,Blue);
                                       End;
                     End
                     Else
                     Begin;
                     Y:=1;
                     For X:=1 To Dx Do Begin;
                                       If Y*Dx>X*Dy Then Else Y:=Y+1;
                                       PutPixel(Xmin+X,Ydepart-Y,Blue);
                                       End;
                     End;
                    End
                    Else
If Xdepart>xfin then Begin;
                     x:=1;
                     For y:=1 to Dy do Begin;
                                       If Y*Dx<X*Dy Then Else x:=x+1;
                                       PutPixel(Xdepart-X,Ymin+Y,white);
                                       end;
                      End
                      else
                      begin;
                      X:=1;
                      For y:=1 to Dy do Begin;
                                       If Y*Dx<X*Dy Then Else x:=x+1;
                                       PutPixel(Xdepart+X,Ymin+Y,white);
                                       end;
   end;
   end;
{安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安安}

END.