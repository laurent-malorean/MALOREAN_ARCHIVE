{--------- Unit‚ Gestion Ecran en objet dynamique (C) 1993 ------------}
{                    programmed by C‚dric Pulrulczyk                     }
{                                                                        }
{ Version : Date (dd.mm.yy) : Comment                                    }
{    1.00   27.09.93        : First version                              }
{------------------------------------------------------------------------}
Unit gest_ecran;

{$F+}
{$O+}

INTERFACE
{-------------------------------------------------------------------------}
(* D‚compose l'‚cran en 3 Zones pour l'affichage *)
Type TFond=Object
     Constructor Init;
     Procedure Milieu; Virtual;
     Procedure Haut; Virtual;
     Procedure Bas; Virtual;
     Procedure Tout; Virtual;
     Destructor Done;
End;
{-------------------------------------------------------------------------}
(* Gestion des chaine de caract‚res *)
Type TChaine=Object
     Constructor Init;
     (* A une chaine S ajoute le Caract‚re C ,Len fois … gauche *)
     Function Remplissage_gauche(S:String;C:Char;Len:Byte):String; Virtual;
     (* A une chaine S ajoute le Caract‚re C ,Len fois … droite *)
     Function Remplissage_droite(S:String;C:Char;Len:Byte):String; Virtual;
     Destructor Done;
End;
{-------------------------------------------------------------------------}
Type TEcran=Object
     Constructor Init;
     (* D‚finie si c'est un ‚cran couleur TRUE ou N&B False *)
     Function Ecran:Boolean; Virtual;
     (* Affiche une barre de pourcentage d'une certaine valeur *)
     Procedure Pourcentage(Valeur:Real); Virtual;
     (* Dessine un cadre d'un type 1,2,3 ou 4 avec Write *)
     procedure cadre(xsup,ysup,xinf,yinf,type_cadre:integer); Virtual;
     (* Ecrit un texte et l'encadre *)
     procedure encadrement(ch:string;x,y:integer); Virtual;
     (* Efface une partie d'‚cran *)
     procedure effacement_ecran(xsup,ysup,xinf,yinf:integer); Virtual;
     Destructor Done;
End;
{-------------------------------------------------------------------------}
implementation
uses crt,dos,Gest_Couleurs;
{-------------------------------------------------------------------------}
Constructor TFond.Init;
Begin
End;
{-------------------------------------------------------------------------}
Destructor TFond.Done;
Begin
End;
{-------------------------------------------------------------------------}
Constructor TChaine.Init;
Begin
End;
{-------------------------------------------------------------------------}
Destructor TChaine.Done;
Begin
End;
{-------------------------------------------------------------------------}
Constructor TEcran.Init;
Begin
End;
{-------------------------------------------------------------------------}
Destructor TEcran.Done;
Begin
End;
{-------------------------------------------------------------------------}
Function TEcran.Ecran:Boolean;
Var Regs:Registers;
Begin
 Intr($11,Regs);
 case Regs.al and 48 of
  0:Ecran:=False;
 16:Ecran:=True;
 32:Ecran:=True;
 48:Ecran:=False;
 end;
End;
{-------------------------------------------------------------------------}
Procedure TEcran.Pourcentage;
Var Boucle:Integer;
Begin
     If Valeur=0 Then
     Begin
          For Boucle:=1 To 40 do
          Begin
               Gotoxy(Boucle+20,17);
               Write(#176);
          End;
          Gotoxy(21,18);
          Write('0%');
          Gotoxy(40,18);
          Write('50%');
          Gotoxy(57,18);
          Write('100%');
     End
     Else
     If Valeur=100 Then
     Begin
          For Boucle:=1 To 40 do
          Begin
               Gotoxy(Boucle+20,17);
               Write(#178);
          End;
     End
     Else
     Begin
          For Boucle:=1 To Trunc(Round(Valeur*40/100)) do
          Begin
               Gotoxy(Boucle+20,17);
               Write(#178);
          End;
     End;

End;
{-------------------------------------------------------------------------}
procedure TEcran.cadre;

  const
  trait:array [1..4,1..6] of char=
  ((#218,#191,#192,#217,#196,#179),(#201,#187,#200,#188,#205,#186),
   (#214,#183,#211,#189,#196,#186),(#213,#184,#212,#190,#205,#186));
  var boucle:integer;
begin
  gotoxy(xsup,ysup);
  write(trait[type_cadre,1]);
  gotoxy(xinf,ysup);
  write(trait[type_cadre,2]);
  gotoxy(xsup,yinf);
  write(trait[type_cadre,3]);
  gotoxy(xinf,yinf);
  write(trait[type_cadre,4]);
   for boucle:=xsup+1 to xinf-1 do
     begin
       gotoxy(boucle,ysup);
       write(trait[type_cadre,5]);
       gotoxy(boucle,yinf);
       write(trait[type_cadre,5]);
     end;
   for boucle:=ysup+1 to yinf-1 do
      begin
        gotoxy(xsup,boucle);
        write(trait[type_cadre,6]);
        gotoxy(xinf,boucle);
        write(trait[type_cadre,6]);
      end;
end;
{-------------------------------------------------------------------------}
procedure TEcran.encadrement(ch:string;x,y:integer);
var longueur:integer;
begin
    longueur:=length(ch);
    gotoxy(x,y);
    write(ch);
    cadre(x-1,y-1,x+longueur,y+1,1);
end;
{-------------------------------------------------------------------------}
procedure TEcran.effacement_ecran(xsup,ysup,xinf,yinf:integer);
var i,j:integer;
begin
   for i:=ysup to yinf do
      begin
      for j:=xsup to xinf do
       begin
         gotoxy(j,i);
         write(' ');
       end;
     end;
end;
{-------------------------------------------------------------------------}
Function TChaine.Remplissage_Droite(S:String;C:Char;Len:Byte):String;
Begin
     If length(S)<Len Then
       FillChar(S[succ(length(S))],Len-Length(S),C);
       S[0]:=Char(Len);
       Remplissage_Droite:=S;
End;
{-------------------------------------------------------------------------}
Function TChaine.Remplissage_Gauche(S:String;C:Char;Len:Byte):String;
Begin
      If Length(S)<Len Then
        Begin
             Move(S[1],S[Succ(Len-Length(S))],Length(S));
             FillChar(S[1],len-length(S),C);
        End;
      S[0]:=Char(Len);
      Remplissage_Gauche:=S;
End;
{-------------------------------------------------------------------------}
Procedure TFond.Bas;
Var Blanc:String;
    Couleur:TCouleur;
        WMin,WMax:Word;
Begin
     WMin:=WindMin;
     WMax:=WindMax;
     Window(1,1,80,25);
     FillChar(Blanc[1],80,' ');
     Blanc[0]:=Char(80);
     Couleur.Choix(1);
     Gotoxy(1,25);
     Write(Blanc);
     Window(Lo(WMin)+1,Hi(WMin)+1,Lo(Wmax)+1,Hi(WMax)+1);
End;
{-------------------------------------------------------------------------}
Procedure TFond.Haut;
Var Blanc:String;
    Couleur:TCouleur;
    WMin,WMax:Word;
Begin
     WMin:=WindMin;
     WMax:=WindMax;
     Window(1,1,80,25);
     FillChar(Blanc[1],80,' ');
     Blanc[0]:=Char(80);
     Couleur.Choix(1);
     Gotoxy(1,1);
     Write(Blanc);
     Window(Lo(WMin)+1,Hi(WMin)+1,Lo(Wmax)+1,Hi(WMax)+1);
End;
{-------------------------------------------------------------------------}
Procedure TFond.Milieu;
Var Ad:Word;
    Regs:Registers;
    x,y:Integer;
    Couleur:TCouleur;
Begin
      Window(1,2,80,24);
      Couleur.Choix(1);
      Clrscr;
      Window(1,1,80,25);
      Intr($11,Regs);
      If (Regs.al and 48)=32 Then Ad:=$B800 Else Ad:=$B000;
      For x:=1 to 80 do
          For y:=2 to 24 do
            Begin
            mem[ad:(x-1)*2+160*(y-1)]:=176;
            End;
End;
{-------------------------------------------------------------------------}
Procedure TFond.Tout;
Begin
Bas;
Haut;
Milieu;
End;
{-------------------------------------------------------------------------}
End.
