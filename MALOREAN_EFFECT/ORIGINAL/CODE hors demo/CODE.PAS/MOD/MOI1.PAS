PROGRAM tpmod;
USES crt,Cgraph;

{$M $4000,0,0} 			{16k stack, no heap - adjust as needed }
{$L MOD-obj.OBJ} 	        { Link in Object file }
{$F+} 				{ force calls to be 'far'}
procedure modvolume(v1,v2,v3,v4:integer); external ; {Can do while playing}
procedure moddevice(var device:integer); external ;
procedure modsetup(var status:integer;device,mixspeed,pro,loop:integer;var str:string); external ;
procedure modstop; external ;
procedure modinit; external;
{$F-}

var
 dev,mix,stat,pro,loop : integer;
 md : string;
 ch: char;



PROCEDURE CARLE12;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       cou      : Byte;
       carle    : byte;


Begin;
Vga.GraphMode;

loadpal ('e:\tp\pal\blue.pal');
for c:=0 to 65000  do Begin;
                    for f:=0 to 85 do
                    for g:=f to 85 do Begin;
                                            {(f-g)*(g*c)*(c-f) and c ou g ou f}
                                      cou:= (c*f-f*g);{+g*c;}
                                      Vga_Ecran[t[g+100]+f+160]:=Cou;
                                      Vga_Ecran[t[f+100]+g+160]:=cou;
                                      Vga_Ecran[t[100-g]+f+160]:=Cou;
                                      Vga_Ecran[t[100-f]+160+g]:=Cou;
                                      Vga_Ecran[t[100-g]+-f+160]:=Cou;
                                      Vga_Ecran[t[-f+100]-g+160]:=cou;
                                      Vga_Ecran[t[100+g]-f+160]:=Cou;
                                      Vga_Ecran[t[100+f]+160-g]:=Cou;



                                      end;
                    end;
VGA.TextMode;
END;












begin
        modinit;
	moddevice ( dev ); { Returns device number in DEV or 255 if 'no sound' }

        MD:=('e:\tp\mod\C.mod');

        mix := 25000;   {use 10000 normally }
        pro := 0; {Leave at 0}
        loop :=4; {4 means mod will play forever}
        modvolume (255,255,255,255);    { Full volume }
	modsetup ( stat, dev, mix, pro, loop, md );

        delay(5000);
        carle12;
              modstop;

end.
