USES GRAPH4P,CRT
;

VAR X,y : WORD;


BEGIN;       GRAPH_MODE_4;
             For x:=10 to 100 do for y:=0 to 100 do
             PUTPIXEL_4(x,y,7);
             DELAY(5000);

END.