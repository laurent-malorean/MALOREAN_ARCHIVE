USES GESt_GRAPH,Shoot;

VAR X,Y,Code : Integer;
Var Nom      : String;


BEGIN; Nom:=Paramstr(1)            ;
       Val(ParamStr(2) , X , Code) ;
       Val(ParamStr(3) , Y , Code) ;
       GraphMode;
       LoadShoot(nom+'.bit');


END.