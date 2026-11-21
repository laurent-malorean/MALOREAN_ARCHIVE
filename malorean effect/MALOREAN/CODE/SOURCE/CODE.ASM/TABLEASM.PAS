Uses Dos;
Type Rec          = Record
                    S    : Array[0..255] Of Integer;
                    C    : Array[0..255] Of Integer;
                    End;
Var
R                       : Rec;
Fr                      : File Of Rec;

Procedure init;
Var
Ft  : 	Integer;
Begin;   {1.0}
For Ft:=0 to 255 do Begin; {1.1}
                    R.S [Ft]:=Round(32*sin(pi/128*Ft));
                    R.C [Ft]:=Round(32*cos(pi/128*Ft));
                    End;   {1.1}
End; {1.0}

Procedure sauve;
Begin;
Assign (Fr,'table.tbl');
Rewrite(Fr);
Write (fr,r);
Close (fr);
End;



Begin;
Init;
sauve;
End.
