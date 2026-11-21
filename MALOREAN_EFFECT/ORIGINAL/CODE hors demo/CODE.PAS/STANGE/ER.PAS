UNIT CGraph;


INTERFACE


Type      Type_graph_ecran = Array [0..16365] of Byte;


TGraphCga   = OBJECT
Procedure PutPIxel      (Var Buffer : Type_graph_ecran;
                             X,Y     : Word;
                             Couleur : Byte);
Function GetPixel      (Var Buffer : Type_graph_ecran;
                             X,Y     : Word               ) :Byte ;
              Procedure Ligne   ( Var Buffer : Type_graph_ecran;
                                        Xa,Ya,Xb,Yb,C : Word);
              Procedure GraphMode;
              Procedure TextMode;
              END;

VAR   Cga_ecran   : Type_Graph_Ecran  ABSOLUTE $B800:$0000;


{Charge fichier copie de la mem ecran pour CGA}
Procedure Charge_fichier_Cga (     Name   : String;
                              Var  Buffer : TYpe_graph_ecran);

Procedure Sauve_fichier_Cga (     Name   : String);

IMPLEMENTATION

{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}


Procedure Charge_Fichier_Cga;
Var f_mem : File of Type_graph_ecran;

Begin;
Assign(F_mem,name);
Reset (F_mem);
Read (F_mem,buffer);
Close(F_mem);
End;

Procedure sauve_fichier_cga;
Var
f_mem     : File of Type_Graph_ecran;

Begin;
Assign(F_mem,name);
Rewrite (F_mem);
Write(F_mem,Cga_ecran);
Close(F_mem);
end;



{--------------------------------------------------------------------------}
Procedure TGraphCga.GraphMode;
BEGIN;
ASM
   MOV AX,$13;
   INT $10;
   END;
END;
{--------------------------------------------------------------------------}
Procedure TGraphCga.TextMode;
BEGIN;
ASM
    MOV AX,$03;
    INT $10;
END;
END;
{--------------------------------------------------------------------------}
Procedure TGraphCga.Putpixel;
Begin;

ASM
   PUSH DS;
   PUSH AX;
   PUSH BX;
   PUSH CX;
   PUSH DX;


   MOV AX,Y;    { y -> AX }
   MOV BX,AX;   { Y -> BX }

   AND BX,1;    {Y MOD 2  }
   SHL BX,13;   { (Y MOD 2) SHL 13 }

   SHR AX,1;    { Y DIV 2}
   MOV CX,80;
   MUL CX;      { (Y DIV 2)*80 }

   ADD BX,AX;   { [(Y MOD 2) SHL 13] + [(Y DIV 2)*80]  ->BX }

   MOV CX,X;    { X -> CX }
   MOV DX,CX;   { X -> DX }

   SHR CX,2;    { X SHR 2 }

   ADD BX,CX;   { [(Y MOD 2) SHL 13] + [(Y DIV 2)*80] + [X SHR  2] ->BX }
                { OFSET -> BX }


   MOV AX,$0B800;
   MOV DS,AX;           {Segment -> DS}


   AND DX,11b;          {X MOD 4}
   SHL DX,1  ;          { [X MOD 4] SHL 1 }
   MOV CX,6  ;
   SUB CX,DX;           { 6 - [X MOD 4] SHL 1 }
                        { N° BIT -> CL }

   MOV AL,[BX];         { Lit valeur des 4 points à DS:BX -> AL }


                        {   Masque les bites;  }
   MOV DL,11b;
   SHL DL,CL;           { decale 11b de N°BITE }
   NOT DL;              {CAche pret}
   AND AL,DL;           { 2 bites masuès}

   MOV DL,COULEUR;
   SHL DL,CL;            {decale la couleur a N°BITE }
   ADD AL,DL;            {met couleur decale dans quarte de point}

   MOV [BX],Al;

   POP DX;
   POP CX;
   POP BX;
   POP AX;
   POP DS;



END;


End;
{--------------------------------------------------------------------------}
Function TGraphCga.GetPixel;
Begin;

ASM
   PUSH DS;
   PUSH AX;
   PUSH CX;
   PUSH DX;

   MOV AX,Y;    { y -> AX }
   MOV BX,AX;   { Y -> BX }

   AND BX,1;    {Y MOD 2  }
   SHL BX,13;   { (Y MOD 2) SHL 13 }

   SHR AX,1;    { Y DIV 2}
   MOV CX,80;
   MUL CX;      { (Y DIV 2)*80 }

   ADD BX,AX;   { [(Y MOD 2) SHL 13] + [(Y DIV 2)*80]  ->BX }

   MOV CX,X;    { X -> CX }
   MOV DX,CX;   { X -> DX }

   SHR CX,2;    { X SHR 2 }

   ADD BX,CX;   { [(Y MOD 2) SHL 13] + [(Y DIV 2)*80] + [X SHR  2] ->BX }
                { OFSET -> BX }


   MOV AX,$0B800;
   MOV DS,AX;           {Segment -> DS}


   AND DX,11b;          {X MOD 4}
   SHL DX,1  ;          { [X MOD 4] SHL 1 }
   MOV CX,6  ;
   SUB CX,DX;           { 6 - [X MOD 4] SHL 1 }
                        { N° BIT -> CL }

   MOV AL,[BX];         { Lit valeur des 4 points à DS:BX -> AL }


                        {   Masque les bites;  }

   SHR AL,CL;           { decale de Al BITE a gauche}
   AND AL,11b;           { 2 bites 11}



   MOV Byte [TGraphCga.Getpixel],AL;

   POP DX;
   POP CX;
   POP AX;
   POP DS;



END;


End;
{--------------------------------------------------------------------------}Procedure TGraphCga.Ligne   ;
Var   f                         : Integer;
      dx,dy                     : Integer;
      Xmax,Xmin,Ymax,Ymin       : Integer;
      ydepart,Yfin,xdepart,Xfin : Integer;
      X,Y                       : integer;
Begin;
If Xa<Xb Then Begin;
              ASM
                 MOV AX,Xb;
                 MOV XMax,AX;
                 MOV AX,Xa;
                 MOV XMin,AX;
                 MOV AX,Ya;
                 MOV YDepart,AX;
                 MOV AX,Yb;
                 MOV YFin,AX;
              END;
{              Xmax:=Xb;
              Xmin:=Xa;
              Ydepart:=ya;
              yfin:=yb;}
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
If Xa=Xb then For f:=Ymin to Ymax Do Putpixel (Buffer,Xa,F,c)
Else If Ya=Yb Then For f:=Xmin To Xmax Do Putpixel (Buffer,F,YA,c)
Else If dy<dx Then Begin;
If Ydepart<Yfin Then Begin;
                     Y:=1;
                     For X:=1 To Dx+1 Do Begin;
                                       If Y*Dx>X*Dy Then Else Y:=Y+1;
                                       PutPixel(Buffer,Xmin+X-1,Ydepart+Y-1,C);
                                       End;
                     End
                     Else
                     Begin;
                     Y:=1;
                     For X:=1 To Dx+1 Do Begin;
                                       If Y*Dx>X*Dy Then Else Y:=Y+1;
                                       PutPixel(Buffer,Xmin+X-1,Ydepart-Y+1,C);
                                       End;
                     End;
                    End
                    Else
If Xdepart>xfin then Begin;
                     x:=1;
                     For y:=1 to Dy do Begin;
                                       If Y*Dx<X*Dy Then Else x:=x+1;
                                       PutPixel(Buffer,Xdepart-X,Ymin+Y,C);
                                       end;
                      End
                      else
                      begin;
                      X:=1;
                      For y:=1 to Dy do Begin;
                                       If Y*Dx<X*Dy Then Else x:=x+1;
                                       PutPixel(Buffer,Xdepart+X,Ymin+Y,C);
                                       end;
   end;
   end;

{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}

END.




   PUSH AX;
   PUSH BX;
   PUSH CX;
   PUSH DX;


   MOV AX,Y;    { y -> AX }
   MOV BX,AX;   { Y -> BX }

   AND BX,1;    {Y MOD 2  }
   SHL BX,13;   { (Y MOD 2) SHL 13 }

   SHR AX,1;    { Y DIV 2}
   MOV CX,80;
   MUL CX;      { (Y DIV 2)*80 }

   ADD BX,AX;   { [(Y MOD 2) SHL 13] + [(Y DIV 2)*80]  ->BX }

   MOV CX,X;    { X -> CX }
   MOV DX,CX;   { X -> DX }

   SHR CX,2;    { X SHR 2 }

   ADD BX,CX;   { [(Y MOD 2) SHL 13] + [(Y DIV 2)*80] + [X SHR  2] ->BX }
                { OFSET -> BX }


   MOV AX,$0B800;
   MOV DS,AX;           {Segment -> DS}

    { Lit valeur des 4 points à DS:BX }

   AND DX,11b;          {X MOD 4}
   SHL DX,1  ;          { [X MOD 4] SHL 1 }
   MOV CX,6  ;
   SUB CX,DX;           { 6 - [X MOD 4] SHL 1 }
                        { N° BIT -> CL }

   MOV AL,[BX];         { Lit valeur des 4 points à DS:BX -> AL }


                        {   Masque les bites;  }
   MOV DL,11b;
   SHL DL,CL;           { decale 11b de N°BITE }
   NOT DL;              {CAche pret}
   AND AL,DL;           { 2 bites masuès}

   MOV DL,COULEUR;
   SHL DL,CL;            {decale la couleur a N°BITE }
   ADD AL,DL;            {met couleur decale dans quarte de point}

{   MOV [BX],Al;}



END;