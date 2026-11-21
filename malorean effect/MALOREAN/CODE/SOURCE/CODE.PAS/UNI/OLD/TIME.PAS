Unit Time;

Interface
Uses Printer,Dos,Cscreen,Crt;

Const
CJour :Array[1..7] Of String [10]= ('Dimanche ','lundi ','mardi ','Mercredi ','Jeudi ',
           'Vendredi ','Samedi ');
CMoi  :Array[1..12] Of String [10]= (' Janvier ',' Février ',' Mars ',' Avril ',' Mai ',' Juin ',' Juillet ',
           ' Aout ',' Septembre ',' Octobre ',' Novembre ',' Decembre ');

Type

Choix_vue  = (Ecr,Imprimante);


Dateheure   = OBJECT
             Heure,Minute,Seconde,S100            : Byte;
             annee                 : word;
             mois,jour,joursemaine : Byte;

             Procedure ReadDate;
             Procedure ReadTime;
             Procedure THeure (Var text : String);
             Procedure Delay(Temps : Word);
             End;

ObjChrono  = OBJECT (DateHeure)
             Debut_J,Debut_H,Debut_M,Debut_S,Debut_S100 : Byte;
             Fin_j,Fin_H,Fin_M,Fin_S,Fin_S100: Byte;
             Duree_j,Duree_H,Duree_M,Duree_S,Duree_S100 : Byte;
             Durre  : LongInt;

             Procedure Start;
             Procedure Stop;
{             Procedure Rego;}
             Procedure Show (Choix : Choix_vue);
             End;

Var  Pulse : Byte ABSOLUTE $0040:$006C;

Procedure Pulse_Init;
Procedure Pulse_Wait;


IMPLEMENTATION

{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
PROCEDURE Pulse_Init;
BEGIN;
          ASM
          MOV Pulse,0;
          END;
END;

PROCEDURE Pulse_Wait;
BEGIN;
          Repeat;
          Until Pulse>=9;
END;

{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}

Procedure ObjChrono.Start;
Begin;
ReadTime;
ReadDate;
Debut_J    :=Jour;
Debut_H    :=Heure;
Debut_M    :=Minute;
Debut_S    :=Seconde;
Debut_S100 :=S100;

Duree_J    :=0;
Duree_H    :=0;
Duree_M    :=0;
Duree_S    :=0;
Duree_S100 :=0;

End;
{----------------------------------------------------------------------}
Procedure ObjChrono.Stop;
Var
Av24h   : LongInt;
Begin;
ReadTime;
ReadDate;
Fin_J    :=Jour;
Fin_H    :=Heure;
Fin_M    :=Minute;
Fin_S    :=Seconde;
Fin_S100 :=S100;
If Debut_J=Fin_J Then Begin;
                      Duree_J     :=0;
                      Duree_H     :=Fin_H    - Debut_H ;
                      Duree_M     :=Fin_M    - Debut_M ;
                      Duree_S     :=Fin_S    - Debut_S ;
                      Duree_S100  :=Fin_S100 - Debut_S100 ;
                      End
                      Else
                      Begin
{                      Duree_J     :=Fin_J    - Debut_J -2 ;
Av24h:=8640000-Debut_H*360000-Debut_M*6000-Debut_S*100-Debut_S100;
                      Duree_H     :=Fin_h    + Av24h Div 360000;
                      Av24h:=av24h- 360000*Av24h Div 360000;
                      Duree_M     :=Fin_M    + Av24 ;
                      Duree_S     :=Fin_S    - Debut_S ;
                      Duree_S100  :=Fin_S100 - Debut_S100 ;}
                      End;
End;
{----------------------------------------------------------------------}
Procedure ObjChrono.Show;
Var     Buf1 : Type_Text_Ecran;
        Buf2 : Type_Text_Ecran;
        Text : TText;
Begin;
Buf1:=CScreen.Ecran;
If Choix=Imprimante Then Begin;
                         Text.Fond_Ecran (Buf2,Blanc,Bleu);
                         Text.Write (Buf2,25,9 ,Blanc,Bleu,'╔══════════════════════════╗');
                         Text.Write (Buf2,25,10,Blanc,Bleu,'║                          ║');
                         Text.Write (Buf2,25,11,Blanc,Bleu,'║       IMPRESSION         ║');
                         Text.Write (Buf2,25,12,Blanc,Bleu,'║                          ║');
                         Text.Write (Buf2,25,13,Blanc,Bleu,'║       DES DONNEES        ║');
                         Text.Write (Buf2,25,14,Blanc,Bleu,'║                          ║');
                         Text.Write (Buf2,25,15,Blanc,Bleu,'║      DU CHRONOMETRE      ║');
                         Text.Write (Buf2,25,16,Blanc,Bleu,'║                          ║');
                         Text.Write (Buf2,25,17,Blanc,Bleu,'╚══════════════════════════╝');
                         CScreen.Ecran:=Buf2;
                         Delay(500);
                         CScreen.Ecran:=Buf1;
                         End;
End;


{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
Procedure DateHeure.ReadTime;
Var       Reg        : Registers;

Begin;    Reg.ah:=$2c;
          Intr($21,registers(reg));
          Heure:=reg.ch;
          Minute:=reg.cl;
          Seconde:=reg.dh;
          S100:=reg.dl;
End;
{-------------------------------------------------------------------}
Procedure DateHeure.ReadDate;
Var       Reg        : Registers;

Begin;    Reg.ah:=$2a;
          Intr($21,registers(reg));
          annee:=reg.cx;
          mois:=reg.dh;
          jour:=reg.dl;
          joursemaine:=reg.al;
End;
{-------------------------------------------------------------------}
Procedure DateHeure.Delay;
Var       Reg        : Registers;

Begin;    Reg.ah:=$86;
          Reg.Cx:=Temps -Temps Shr 8;
          REg.dx:=Temps Shr 8;
          Intr($21,registers(reg));
End;


Procedure DateHeure.THeure;
Var       Inter : String;
Begin;
Readtime;
Str(Heure,Inter);
Text:=Inter+':';
Str(Minute,Inter);
Text:=Text+Inter+':';
Str(Seconde,Inter);
Text:=Text+Inter;
End;

{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}
end.
