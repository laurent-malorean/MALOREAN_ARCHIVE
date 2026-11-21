USES GEST_GRAPH,DAC_CODE,DAc_FRAC,CRT;

VAR   Xe,Ye,Ze : Word;
      Dx,Dy    : ARRAY [0..319] Of Integer;
      Delta    : Integer;
      Cou      : Byte;




BEGIN
GraphMode;
PUT_DAC(DAC_FRAc.Blue);


For Ze:=1 to 500 Do Begin;


For Xe:=0 to 320 Do
For Ye:=0 to 199 Do Begin;
                    Delta:=1;
                    Repeat;
                    Inc(Delta);
                    Until ((Xe AND Delta)=Ye ) or
                          ((Ye AND Delta)=Xe) or
                          ((Xe  OR Delta)=Ye) or
                          ((Ye  OR Delta)=Xe) or
                          ((Xe AND Delta)=Ye+Xe  ) or
                          ((Ye AND Delta)=Xe+Ye  ) or


                          (Delta>100);

                    Vga[Mul320[Ye]+Xe]:=Delta ;

                    end;

END; {for ze}

END.