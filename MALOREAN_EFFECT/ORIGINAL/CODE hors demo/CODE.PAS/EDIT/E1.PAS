Uses CScreen,Crt;

VAR       EcranVir   : Array [1..500,1..80] Of Byte;
          Index      : Word;
          F,g        : Word;
          XCurseur   : Byte;
          YCurseur   : Byte;
          YCurseur_Pre : Byte;
          XCurseur_Pre : Byte;
          Colone     : Byte;
          OBJ :TTExt;
          Mouse      : ObjMOuse;
          f1,f2,f3   : Byte;

Procedure  SORTIE;
VAR        WIN     : ObjWin;
           BUTTON1 : ObjButton;
           BUTTON2 : ObjButton;
           State1  : TState;
           State2  : TState;

BEGIN;
Mouse.erase;
MovEcran(INTERNE2,Ecran);
MovEcran(INTERNE1,Ecran);
Win.WIn4 (INTERNE1,'Do you want exit',20,10,60,15,Vert,Blanc,Magenta);
Button1.Init(INTERNE1,25,13,Brun,Blanc,'Yes');
Button2.Init(INTERNE1,45,13,Brun,Blanc,'No');
Button1.Show (INTERNE1);
Button2.Show (INTERNE1);
MovEcran(Ecran,INTERNE1);
Mouse.Show;
Repeat;
State1:=Button1.State;
State2:=Button2.State
until (State1=Alume) or (State2=Alume);
If State1=Alume then Begin;
                     TextBackground(0);
                     TextColor(Blanc+8);
                     Clrscr;
                     GotoXY(1,1);
                     TextColor(Blanc+8);
                     TextBackGround(Bleu);
     Write('                Malorean Effect Editor for TASM Coding by Carle                 ');
                     GotoXY(1,2);
                     halt(1);
                     end;
If State2=Alume then MovEcran(Ecran,INTERNE2);

END;



Procedure GotoCurseur ;
Begin;
OBJ.InvNoCli (XCurseur_Pre,YCurseur_Pre);
OBJ.InvCli (XCurseur,YCurseur);
end;

Procedure KickWrite ( X,Y           : Byte;
                       Message       : String);
Var  F : Integer;
Attribut : Byte;
Begin;
message:=message+('Æ');
f:=0;
Repeat;
Ecran [Y,X+F,caractere]:=ord(message[f+1]);
Inc(f);
Until message [f+1]=('Æ') ;
End;



Procedure Init;
VAR       ECR      : ObjWin;

BEGIN;
Ecr.Clear_Buffer (INTERNE1,Bleu);
Ecr.Ligne        (INTERNE1,1,Blanc);
Ecr.Ligne        (INTERNE1,25,Blanc);
Ecr.Write(INTERNE1,10,1,Bleu,Blanc,'Malorean Effect Editor For TASM coding by Carle');
ECR.Write(INTERNE1,5,25,Noir,Blanc,':');

MovECran (Ecran,INTERNE1);
for f:=2 to 24 do for g:=1 to 80 do Ecran[f,g,couleur]:=7+bleu*16+8;

Mouse.Init;
Mouse.Show;
END;

Procedure Edit;
Var F,G : Word;
    ObjECR   : TText;

BEGIN;
For F:=Index to Index+22 Do for g:=1 to 80 do
Ecran[f+2-index,g,caractere]:=EcranVir[F,G];
 END;

Procedure LigneColone;
BEGIN;
Textcolor(7);
gotoxy(1,25);write('         ');
Textcolor(0);
TextBackground(7);
gotoxy(1,25);write(index+Ycurseur-2);
gotoxy(6,25);write(XCurseur);

END;


Procedure Gestion;
VAR      Touche : Char;
         Btouche : Boolean;

PROCEDURE FLECHE_DROITE;
BEGIN;
If XCurseur<80 Then begin;
                    XCurseur_Pre:=XCurseur;
                    YCurseur_Pre:=YCurseur;
                    INC(XCurseur);
                    GotoCurseur;
                    LigneColone;
                    end;

END;




BEGIN;
Repeat;

Touche:=Readkey;
gotoxy(20,25);
textcolor(0);
textbackground(7);
WRITE(Ord(touche));



Case Touche  Of #27      : Sortie;



                #30..#64 : BEGIN;
                           ECRAN   [YCurseur,XCurseur,Caractere]:=Ord(Touche);
                           EcranVir[YCurseur+Index-2,XCurseur]:=Ord(Touche);
                           Fleche_Droite;
                           end;
                #95..#127 : BEGIN;
                           ECRAN[YCurseur,XCurseur,Caractere]:=Ord(Touche);
                           EcranVir[YCurseur+Index-2,XCurseur]:=Ord(Touche);

                           Fleche_Droite;
                           end;

               #80 : If index<400 Then
                                  IF YCurseur=24 Then Begin;
                                                      Inc(Index);
                                                      Edit;
                                                      LigneColone;
                                                      end
                                                 Else Begin;
                                                      XCurseur_Pre:=XCurseur;
                                                      YCurseur_Pre:=YCurseur;
                                                      INC(YCurseur);
                                                      GotoCurseur;
                                                      LigneColone;
                                                      end;


               #72 :
                     If (YCurseur>2)   Then Begin;
                                          XCurseur_Pre:=XCurseur;
                                        YCurseur_Pre:=YCurseur;
                                        Dec(YCurseur);
                                        LigneColone;
                                        GotoCurseur;
                                        end
                                   Else If Index>1 then Begin;
                                        Dec(Index);
                                        Edit;
                                        LigneColone;

                                        end;

               #77 : Fleche_Droite;
               #75 : If XCurseur>1 Then  begin;
                                         XCurseur_Pre:=XCurseur;
                                         YCurseur_Pre:=YCurseur;
                                         DEC(XCurseur);
                                         GotoCurseur;
                                         LigneColone;
                                         end;
               #71 :   begin;
                       XCurseur_Pre:=XCurseur;
                       YCurseur_Pre:=YCurseur;
                       XCurseur:=1;
                       GotoCurseur;
                       LigneColone;
                       end;

               #79 :   begin;
                       XCurseur_Pre:=XCurseur;
                       YCurseur_Pre:=YCurseur;
                       XCurseur:=80;
                       GotoCurseur;
                       LigneColone;
                       end;

               #81 : If index<400 Then
                                  IF YCurseur>14 Then Begin;
                                                      Inc(Index,20);
                                                      Edit;
                                                      LigneColone;
                                                      end
                                                 Else Begin;
                                                      XCurseur_Pre:=XCurseur;
                                                      YCurseur_Pre:=YCurseur;
                                                      INC(YCurseur,20);
                                                      If YCurseur>24 then YCurseur:=29;
                                                      GotoCurseur;
                                                      LigneColone;
                                                      end;
               #73 : If index>20 Then
                                  IF YCurseur>20 Then Begin;
                                                      Dec(Index,20);
                                                      Edit;
                                                      LigneColone;
                                                      end
                                                 Else Begin;
                                                      XCurseur_Pre:=XCurseur;
                                                      YCurseur_Pre:=YCurseur;
                                                      Dec(YCurseur,20);
                                                      If YCurseur<20 then YCurseur:=1;
                                                      GotoCurseur;
                                                      LigneColone;
                                                      end;


             end;


until f=125;

END;


BEGIN;
OBJ.SHow_Curseur;
Init;
For f:=1 to 500 do for g:=1 to 80 do EcranVir[f,g]:=f*g mod 200;
index:=1;
colone:=1;
XCurseur:=1;
YCurseur:=2;
Gotocurseur;


Edit;
Gestion;
END.