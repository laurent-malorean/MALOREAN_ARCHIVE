USES TroisD,CGraph,Crt;

VAR   VGA    : TGraphVga;
      Cube1  : OObj1;
      Cube2  : Oobj1;
      Cube3  : OObj1;
      F      : Word;


Procedure fond;
Var
    VGaECran    : ^Screen;
    Merde       :  Byte;
    Fichier     :  FILE;
    Vga         :  TGraphVga;
    Pal         :  T2_Palette;
    F           :  Word;
    g           :  byte;

Procedure Charge_ME (nom : string);
Begin;
  Assign(Fichier,nom);
  Reset(Fichier, 1);
  BlockRead(Fichier,Merde,SizeOf(Merde));
  BlockRead(Fichier,VgaEcran^.Palette,SizeOf(VgaEcran^.Palette));
  BlockRead(Fichier,VGaEcran^.ECran,SizeOf(VGaEcran^.Ecran));
  Close(Fichier);
  Vga_Ecran:=VGaECran^.Ecran;
  VGA.SetDAc (0,255,VGaECran^.Palette);
  Buf1^:=VgaEcran^.Ecran;
end;

BEGIN;
NEW (VGaECran);
Charge_me ('c:\tp\intro.bit');
end;


BEGIN;
VGA.GraphMode;
New(Buf1);
Buf1^:=Vga_Ecran;
fond;
Cube1.Init_Angle_Obj;
Cube1.Config_Obj (0,0,1);
Cube1.Init_Centre (160,100);
Cube1.Init_Angle_Centre;

Cube2.Init_Angle_Obj;
Cube2.Config_Obj (0,0,1);
Cube2.Init_Centre (160,100);
Cube2.Init_Angle_Centre;

Cube3.Init_Angle_Obj;
Cube3.Config_Obj (0,0,1);
Cube3.Init_Centre (160,100);
Cube3.Init_Angle_Centre;


For f:=1 to 20 do Begin;
                   Cube1.Inc_Angle_Obj (10,5,-12);
                   Cube1.Matrice(50-2*f);
                   Buf2^:=buf1^;
                   Cube1.Ligne;
                   Move (Buf2^,Vga_Ecran,64000);

                   end;


For f:=1 to 50000 do Begin;
                   Cube1.Inc_Angle_Centre((f mod 5)+3,(f and 9)+5,(-f mod 10)-4);
                   Cube1.Rot_Centre (160,100,70,2);

                   Cube1.Inc_Angle_Obj (10,5,-12);
                   Cube1.Matrice(10);

                   Cube2.Inc_Angle_Centre((f mod 15)+3,(f and 19)+5,(-f mod 20)-4);
                   Cube2.Rot_Centre (180,100,60,2);

                   Cube2.Inc_Angle_Obj (1,-5,6);
                   Cube2.Matrice(8);

                   Cube3.Inc_Angle_Centre((f and 10)+5,2,5);
                   Cube3.Rot_Centre (160,100,80,2);

                   Cube3.Inc_Angle_Obj (1,-5,6);
                   Cube3.Matrice(8);

                   Buf2^:=buf1^;
                   Cube1.Ligne;
                   Cube2.Ligne;
                   Cube3.Ligne;

                   Move (Buf2^,Vga_Ecran,64000);


{                   delay(250);}
                   end;



VGA.TextMode;

END.