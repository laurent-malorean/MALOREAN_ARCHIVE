Uses Dos;
Type Rec          = Record
                    S    : Array[0..255] Of INTEGER;
                    C    : Array[0..255] Of INTEGER;
                    End;
Var
R                       : Rec;
Fr                      : File Of Rec;

Procedure init;
Var
Ft  : 	Integer;
Begin;   {1.0}
For Ft:=0 to 255 do Begin; {1.1}
                    R.S [Ft]:=Round(25*sin(pi/128*Ft));
                    R.C [Ft]:=Round(25*cos(pi/128*Ft));
                    End;   {1.1}
R.S[0]  :=0;
R.S[128]:=0;
R.S[255]:=0;
R.S[64] :=25;
R.S[192]:=-25;

R.C[64] :=0;
R.C[192]:=0;

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
