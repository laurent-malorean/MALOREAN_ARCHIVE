program boprog;
uses graph;
type tab=array[0..255] of integer;
var pilote,mode:integer;
    i,k:byte;
    xt,yt,j:integer;
    x,y,xx,yy:tab;
begin
for i:=0 to 255 do
 begin
  x[i]:=round(random*600)+20;
  y[i]:=round(random*200)+100;
 { repeat                          }
 {  xx[i]:=round((random-0.5)*8);  }
 {  yy[i]:=round((random-0.5)*8);  }
 { until (xx[i]<>0) or (yy[i]<>0); }
 xx[i]:=round((random-0.5)*8);
 yy[i]:=0;
 end;
pilote:=detect;
initgraph(pilote,mode,'f:\tp\bgi');
for k:=1 to 5 do
 begin
for j:=1 to 400 do
 begin
 for i:=0 to 255 do
 begin
   yy[i]:=yy[i]+round(random);
   xt:=x[i];
   x[i]:=x[i]+xx[i];
   if (x[i]<0) or (x[i]>639) then
     begin
       xx[i]:=-xx[i];
       x[i]:=x[i]+2*xx[i];
     end;
   yt:=y[i];
   y[i]:=y[i]+yy[i];
   if (y[i]>479) then
     begin
       yy[i]:=-yy[i];
       y[i]:=y[i]+2*yy[i];
     end;
    if (y[i]<0)  then
     begin
       y[i]:=0;
       yy[i]:=0;
     end;
   putpixel(x[i],y[i],(i mod 15)+1);
   putpixel(xt,yt,0);
  end;
end;
for i:=0 to 255 do
 begin
  if (xx[i]>8) then
    begin
     xx[i]:=6;
    end
    else
    begin
      if (xx[i]<-8) then
        begin
          xx[i]:=-6
        end;
    end;
  if (yy[i]>8) then
    begin
     yy[i]:=6;
    end
    else
    begin
      if (yy[i]<-8) then
        begin
          yy[i]:=-6
        end;
    end;
end;
for j:=1 to 400 do
 begin
 for i:=0 to 255 do
 begin
   xt:=x[i];
   x[i]:=x[i]+xx[i];
   if (x[i]<0) or (x[i]>639) then
     begin
       xx[i]:=-xx[i];
       x[i]:=x[i]+2*xx[i];
     end;
   yt:=y[i];
   y[i]:=y[i]+yy[i];
   if (y[i]<0) or (y[i]>479) then
     begin
       yy[i]:=-yy[i];
       y[i]:=y[i]+2*yy[i];
     end;
   putpixel(x[i],y[i],(i mod 15)+1);
   putpixel(xt,yt,0);
  end;
end;
end;
closegraph;
end
.