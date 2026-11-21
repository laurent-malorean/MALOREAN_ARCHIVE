USES Crt,Dos;



VAR
F : Byte;
Nb_File  : Integer;
Nb_rep,nb_fichier : INteger;
DirFile : Array [-1..200] Of String;
DirInfo  : SearchRec;
Xmin,Xmax,Ymin,Ymax : Byte;
Chemin : String;
Procedure Win_p;
Const
Lv=('                                                                             ');
Var
Li : String;
F  : Byte;
Begin;

Li:=Copy(Lv,1,75);

Textbackground (Blue);
Gotoxy(Xmin,Ymin);
Write (Li);
TextBackground(7);
For f:=Ymin+1 to Ymax Do Begin;
                           GotoXY(Xmin,f);
                           Write (Li);
                           End;

End;


Procedure affiche_file ;
const
xfile :Array [1..5] of Byte=(2,17,32,46,61);
Var
F,ff : Byte;
no_col : Byte;
Nofile : byte;
Begin;
Textcolor(7);
Textbackground(blue);
Gotoxy(Xmin+3,ymin);
Write (chemin);
textcolor(0);
textbackground(7);
gotoxy(Xmin+2,Ymax);
Write(nb_rep);
Write(' Répertoires   ');
Write(nb_fichier);
Write(' Fichiers  ');
Write (Round(Diskfree(0)/1024));
Write (' KO Libres  ');
Write('Capacité ');
Write (Round(DiskSize(0)/1024));
Write (' KO ');
no_col:=2+Xmin;
Nofile:=1;

For ff:=1 to 5 do Begin;
                  no_col:=Xmin+xfile[ff];
                  f:=0;
                  Repeat;
                  If nofile<nb_file+1 Then begin;
                                           GotoXY(no_col,Ymin+1+f);
                                           Writeln(Copy (DirFile[nofile]+'            ',1,12));
                                           end;
                                           f:=f+1;
                                           nofile:=nofile+1;
                  Until (F=Ymax-Ymin-1) Or (nofile=nb_file+1);
                  end;
End;


Procedure Win_P_Dir ;
Var
di,n : integer;
F        : Byte;


Begin;
Xmin:=2;
Xmax:=77;
Ymin:=2;


{Creation de la fenetre}
Nb_File:=0;
FindFirst(Chemin+'*.',Directory, DirInfo);
WHILE DosError = 0 DO   BEGIN
                        DirFile[Nb_File+1]:=Copy (DirInFo.Name+'      ',1,8)+' [r]';
                        FindNext(DirInfo);
                        Nb_File:=Nb_File+1;
                        END;
Nb_rep:=nb_file;
FindFirst(Chemin+'*.*',$20, DirInfo);
WHILE DosError = 0 DO   BEGIN
                        DirFile[Nb_File+1]:=DirInFo.Name;
                        FindNext(DirInfo);
                        Nb_File:=Nb_File+1;
                        END;
Nb_fichier:=nb_file-nb_rep;


di:=nb_file;
n:=0;
while di>5 do Begin;
              di:=di-5;
              n:=n+1;
              end;
Ymax:=ymin+n+2;
Win_P ;

Affiche_File;
End;


BEGIN
If paramcount=0
Then Begin;
     GetDir(0,chemin);
If copy (Chemin,Length(Chemin),1)='\' Then  Else Chemin:=Chemin+'\';

     End
Else If copy (Paramstr(1),Length(Paramstr(1)),1)='\' Then Chemin:=Paramstr(1)
                                                     Else Chemin:=Paramstr(1)+'\';

clrscr;
Win_p_Dir ;
Gotoxy(1,Ymax+1);
END.

