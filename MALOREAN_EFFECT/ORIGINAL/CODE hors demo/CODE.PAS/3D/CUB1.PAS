USES TroisD,CGraph,Crt;

VAR   VGA    : TGraphVga;
      Cube1  : OObj1;
      F,ff      : Word;
      a : char;

BEGIN;
VGA.GraphMode;
New(Buf1);
Charge_Shoot('Intro.bit');
Buf1^:=Vga_Ecran;
Cube1.Init_Angle_Obj;
Cube1.Config_Obj (0,0,1);
Cube1.Init_Centre (160,100);
cube1.Cx:=120;
Cube1.Cy:=100;
For f:=1 to 1000 do Begin;
                   Cube1.Inc_Angle_Obj (1,2,3);

                   Cube1.Matrice(50);

                   asm;
                   MOV ES,S;
                   MOV DI,O;
                   MOV AX,0;
                   @DebutFor: ;
                   CMP DI,64000;
                   JA  @Fin
                   MOV es:[Di],AX;
                   ADD Di,2;
                   JMP @DebutFor;
                   @Fin:
                   end;
                  Cube1.Ligne;
 {                  Inc(Cube1.Cx,9);}

                   ASM;                {VGA_Ecran:=Buf1^}
                   PUSH DS
                   PUSH SI

                   MOV ES,S;
                   MOV DI,O;
                   MOV AX,0A000h ;
                   MOV DS,AX;
                   MOV SI,0;
                   @DebutFor:;
                   CMP DI,64000;
                   JA @Fin;
                   MOV AX,ES:[Di];
                   MOV DS:[Si],AX;
                   ADD DI,2;
                   ADD Si,2;
                   JMP @DebutFor;
                   @Fin: ;

                   POP SI
                   POP DS
                   end;
{                   a:=readkey;
                   delay(100);}
                   end;
END.