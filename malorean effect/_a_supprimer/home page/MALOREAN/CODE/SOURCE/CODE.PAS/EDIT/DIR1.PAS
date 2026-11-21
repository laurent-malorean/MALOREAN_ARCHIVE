USES Crt,Dos;

VAR
Nb_File              : Integer;
Nb_rep,nb_fichier    : INteger;
DirFile              : Array [-1..200] Of String;
DirInfo              : SearchRec;
Chemin               : String;

Procedure Win_P_Dir ;
Var
di,n : integer;
F        : Byte;

Begin;
Nb_File:=0;
FindFirst(Chemin+'*.',Directory, DirInfo);

WHILE DosError = 0 DO
        BEGIN
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


End;


BEGIN
clrscr;
Win_p_Dir ;
END.

