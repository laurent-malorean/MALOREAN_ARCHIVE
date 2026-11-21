Uses CGraph,Crt,Dos;

Var Pal       : ObjPalette;
    Vga       : TGraphVga;
    BufferPal : T2_Palette;
    F         : Word;
    a         : Char;


BEGIN
Vga.GraphMode;
Charge_Shoot (ParamStr(1));
Pal.GetDac(0,255,BufferPal);
Pal.Init(BufferPal);
Repeat;
a:=readkey;


Case a Of #116 :  Pal.Dec1Dac;
          #103 :  Pal.Inc1Dac;
          #97 :   Pal.Inc1R;
          #113 :  Pal.Dec1R;
          #122 :  Pal.Inc1V;
          #115 :  Pal.Dec1V;
          #101 :  Pal.Inc1B;
          #100 :  Pal.Dec1B;
          #114 :  Pal.Inc1RVB;
          #102 :  Pal.Dec1RVB;
          #60  :  Sauve_Shoot(paramStr(2));


          end;
Until a=#27;
VGA.TextMode;
END.