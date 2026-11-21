UNIT CURSEUR;


INTERFACE

USES VARIABLE,DOS;

TYPE OBJET_CURSEUR = OBJECT
		     SHOW     : BOOLEAN;
	             PROCEDURE OPEN;
		     PROCEDURE CLOSE;
                     END;


IMPLEMENTATION

Procedure OBJET_CURSEUR.CLOSE;
BEGIN;    SHOW:=FALSE;
          Reg.ah:=$01;
          Reg.ch:=$20;
          Intr($10,registers(reg));
END;
{--------------------------------------------------------------------------}
Procedure OBJET_CURSEUR.OPEN;
BEGIN;    SHOW:=TRUE;
	  Reg.AH:=$01;
    	  Reg.CH:=6;
          Reg.CL:=7;
          Intr ($10,Registers(reg));
END;



BEGIN;
END.