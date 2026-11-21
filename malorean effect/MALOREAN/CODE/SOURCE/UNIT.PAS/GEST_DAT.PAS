{------- Unité de configuration date en objet (C) Cédric Pulrulczyk -------}
Unit Gest_dates;

{$F+}
{$O+}

Interface

{-----------------------------------------------------------------------}
Type TDate = Object
     Separateur_date:String[1];
     Separateur_time:String[1];
     Avant_midi     :String[3];
     Apres_Midi     :String[3];
     Format_date    :1..3;
     Format_time    :1..3;
     Procedure Init;
     Function Time:String;
     Function Date:String;
     Procedure Date_jour(Jour,Mois,Annee:Integer;Var Nombre:Integer);
     Procedure Jour_date(Nombre,Annee:Integer;Var Jour,Mois:Integer);
     Procedure Semaine(Jour,Mois,Annee:Integer;Var LeJour:Integer);
     Function Fetes(Jour,Mois,Annee:Integer):Boolean;
End;
{-----------------------------------------------------------------------}
Implementation
Uses dos,crt;

Procedure TDate.Init;
Begin
   Format_date:=1;
   Format_time:=1;
   Separateur_Time:=':';
   Separateur_Date:='/';
   Avant_midi:='AM';
   Apres_midi:='PM';
End;

Procedure TDate.Date_jour(Jour,Mois,Annee:Integer;Var Nombre:Integer);
Var Nombre2:Integer;
Begin
   Nombre2:=0;
   If Mois>1 Then Nombre2:=31;
   If ((Mois>2) And (Annee mod 4=0)) Then Inc(Nombre2,29) Else
   If ((Mois>2) And (Annee mod 4<>0)) Then Inc(Nombre2,28);
   If Mois>3 Then Inc(Nombre2,31);
   If Mois>4 Then Inc(Nombre2,30);
   If Mois>5 Then Inc(Nombre2,31);
   If Mois>6 Then Inc(Nombre2,30);
   If Mois>7 Then Inc(Nombre2,31);
   If Mois>8 Then Inc(Nombre2,30);
   If Mois>9 Then Inc(Nombre2,31);
   If Mois>10 Then Inc(Nombre2,30);
   If Mois>11 Then Inc(Nombre2,31);
   Inc(Nombre2,Jour);
   Nombre:=Nombre2;
End;

Procedure TDate.Jour_date(Nombre,Annee:Integer;Var Jour,Mois:Integer);
Var Nombre2:Integer;
Begin
   Nombre2:=Nombre;
   Mois:=0;
   If (Nombre2<=31) Then
   Begin
        Mois:=1;
        Jour:=Nombre2;
   End;
   Dec(Nombre2,31);
   If ((Nombre2<=29) And (Annee mod 4=0) And (Mois=0)) Then
   Begin
        Mois:=2;
        Jour:=Nombre2;

   End;
   If Annee mod 4=0 Then Dec(Nombre2,29);
   If ((Nombre2<=28) And (Annee mod 4<>0) And (Mois=0)) Then
   Begin
        Mois:=2;
        Jour:=Nombre2;
   End;
   If Annee mod 4<>0 Then Dec(Nombre2,28);
   If ((Nombre2<=31) And (Mois=0)) Then
   Begin
        Mois:=3;
        Jour:=Nombre2;
   End;
   Dec(Nombre2,31);
   If ((Nombre2<=30) And (Mois=0)) Then
   Begin
        Mois:=4;
        Jour:=Nombre2;
   End;
   Dec(Nombre2,30);
   If ((Nombre2<=31) And (Mois=0)) Then
   Begin
        Mois:=5;
        Jour:=Nombre2;
   End;
   Dec(Nombre2,31);
   If ((Nombre2<=30) And (Mois=0)) Then
   Begin
        Mois:=6;
        Jour:=Nombre2;
   End;
   Dec(Nombre2,30);
   If ((Nombre2<=31) And (Mois=0)) Then
   Begin
        Mois:=7;
        Jour:=Nombre2;
   End;
   Dec(Nombre2,31);
   If ((Nombre2<=30) And (Mois=0)) Then
   Begin
        Mois:=8;
        Jour:=Nombre2;
   End;
   Dec(Nombre2,30);
   If ((Nombre2<=31) And (Mois=0)) Then
   Begin
        Mois:=9;
        Jour:=Nombre2;
   End;
   Dec(Nombre2,31);
   If ((Nombre2<=30) And (Mois=0)) Then
   Begin
        Mois:=10;
        Jour:=Nombre2;
   End;
   Dec(Nombre2,30);
   If ((Nombre2<=31) And (Mois=0)) Then
   Begin
        Mois:=11;
        Jour:=Nombre2;
   End;
   Dec(Nombre2,31);
   If ((Nombre<=30) And (Mois=0)) Then
   Begin
        Mois:=12;
        Jour:=Nombre2;
   End;
End;

Procedure TDate.Semaine(Jour,Mois,Annee:Integer;Var LeJour:Integer);
Var nn:Real;
Begin
nn:=jour+2*mois+int(0.6*(mois+1))+annee+int(annee/4)-int(annee/100);
nn:=nn+int(annee/400)+2;
nn:=int((nn/7-int(nn/7))*7+0.5);
LeJour:=Trunc(nn);
{If nn=0 Then Write('Samedi')
Else If nn=1 Then Write('Dimanche')
Else If nn=2 Then Write('Lundi')
Else If nn=3 Then Write('Mardi')
Else If nn=4 Then Write('Mercredi')
Else If nn=5 Then Write('Jeudi')
Else Write('Vendredi');}
End;

Procedure Paques(Annee:Integer;Var Jour,Mois:Integer);
Var a,b,c,d,e:Integer;

Begin
A:=Annee mod 19;
B:=Annee mod 4;
C:=Annee mod 7;
D:=A*19+24;
D:=D mod 30;
E:=((2*B)+(4*C)+(6*D)+5);
E:=E mod 7;
If (D+E)<=9 Then
Begin
     Jour:=22+D+E;
     Mois:=3;
End
Else
Begin
     Jour:=(D+E)-9;
     Mois:=4;
End;
If Annee=1981 Then
Begin
      Jour:=19;
      Mois:=4;
End;
If Annee=2049 Then
Begin
     Jour:=18;
     Mois:=4;
End;
If Annee=2076 Then
Begin
     Jour:=19;
     Mois:=4;
End;
End;

Function TDate.Fetes(Jour,Mois,Annee:Integer):Boolean;
Var Jour_paques,Mois_paques,Jour2,Mois2,Annee2:Integer;
    Essai:Boolean;
    Nombre:Integer;
Begin
{*--------------------Fêtes par rapport à pâques-------------------------*}
{*Pâques*}
        Essai:=False;
        Paques(Annee,Jour_paques,Mois_paques);
        If ((Jour_paques=Jour) And (Mois_paques=Mois)) Then Essai:=True;
{*Le lundi de pâques*}
        Date_jour(Jour_paques,Mois_paques,Annee,Nombre);
        Inc(Nombre,1);
        Jour_date(Nombre,Annee,Jour2,Mois2);
        If ((Jour2=Jour) And (Mois2=Mois)) Then Essai:=True;
{*Mercredi de Cendres*}
        Date_jour(Jour_paques,Mois_paques,Annee,Nombre);
        Dec(Nombre,46);
        Jour_date(Nombre,Annee,Jour2,Mois2);
        Semaine(Jour2,Mois2,Annee,Nombre);
        If ((Jour2=Jour) And (Mois2=Mois)) Then Essai:=False;
{*Le début du carême*}
        Date_jour(Jour_paques,Mois_paques,Annee,Nombre);
        Dec(Nombre,42);
        Jour_date(Nombre,Annee,Jour2,Mois2);
        If ((Jour2=Jour) And (Mois2=Mois)) Then Essai:=False;
{*Les rameaux*}
        Date_jour(Jour_paques,Mois_paques,Annee,Nombre);
        Dec(Nombre,7);
        Jour_date(Nombre,Annee,Jour2,Mois2);
        If ((Jour2=Jour) And (Mois2=Mois)) Then Essai:=False;
{*Jeudi saint*}
        Date_jour(Jour_paques,Mois_paques,Annee,Nombre);
        Dec(Nombre,3);
        Jour_date(Nombre,Annee,Jour2,Mois2);
        If ((Jour2=Jour) And (Mois2=Mois)) Then Essai:=False;
{*Vendredi saint*}
        Date_jour(Jour_paques,Mois_paques,Annee,Nombre);
        Dec(Nombre,2);
        Jour_date(Nombre,Annee,Jour2,Mois2);
        If ((Jour2=Jour) And (Mois2=Mois)) Then Essai:=False;
{*Samedi saint*}
        Date_jour(Jour_paques,Mois_paques,Annee,Nombre);
        Dec(Nombre,1);
        Jour_date(Nombre,Annee,Jour2,Mois2);
        If ((Jour2=Jour) And (Mois2=Mois)) Then Essai:=False;
{*Jeudi de l'ascension*}
        Date_jour(Jour_paques,Mois_paques,Annee,Nombre);
        Inc(Nombre,39);
        Jour_date(Nombre,Annee,Jour2,Mois2);
        Semaine(Jour2,Mois2,Annee,Nombre);
        If ((Jour2=Jour) And (Mois2=Mois)) Then Essai:=True;
{*Pentecôte*}
        Date_jour(Jour_paques,Mois_paques,Annee,Nombre);
        Inc(Nombre,49);
        Jour_date(Nombre,Annee,Jour2,Mois2);
        Semaine(Jour2,Mois2,Annee,Nombre);
        If ((Jour2=Jour) And (Mois2=Mois)) Then Essai:=True;
{*Le lundi de pentecôte*}
        Date_jour(Jour_paques,Mois_paques,Annee,Nombre);
        Inc(Nombre,50);
        Jour_date(Nombre,Annee,Jour2,Mois2);
        Semaine(Jour2,Mois2,Annee,Nombre);
        If ((Jour2=Jour) And (Mois2=Mois)) Then Essai:=True;
{*La trinité*}
        Date_jour(Jour_paques,Mois_paques,Annee,Nombre);
        Inc(Nombre,56);
        Jour_date(Nombre,Annee,Jour2,Mois2);
        Semaine(Jour2,Mois2,Annee,Nombre);
        If ((Jour2=Jour) And (Mois2=Mois)) Then Essai:=False;
{*Fête-Dieu*}
        Date_jour(Jour_paques,Mois_paques,Annee,Nombre);
        Inc(Nombre,63);
        Jour_date(Nombre,Annee,Jour2,Mois2);
        Semaine(Jour2,Mois2,Annee,Nombre);
        If ((Jour2=Jour) And (Mois2=Mois)) Then Essai:=False;
{*Sacré-Coeur*}
        Date_jour(Jour_paques,Mois_paques,Annee,Nombre);
        Inc(Nombre,68);
        Jour_date(Nombre,Annee,Jour2,Mois2);
        Semaine(Jour2,Mois2,Annee,Nombre);
        If ((Jour2=Jour) And (Mois2=Mois)) Then Essai:=False;
{*Toussaint*}
        If ((Jour=1) And (Mois=11)) Then Essai:=True;
{*Assomption*}
        If ((Jour=15) And (Mois=8)) Then Essai:=True;
{*---------------------------Fêtes politiques---------------------------*}
{*Jour de l'an*}
        If ((Jour=1) And (Mois=1)) Then Essai:=True;
{*1er mai*}
        If ((Jour=1) And (Mois=5)) Then Essai:=True;
{*8 mai*}
        If ((Jour=8) And (Mois=5)) Then Essai:=True;
{*14 juillet*}
        If ((Jour=14) And (Mois=7)) Then Essai:=True;
{*11 novembre*}
        If ((Jour=11) And (Mois=11)) Then Essai:=True;
{*Noël*}
        If ((Jour=25) And (Mois=12)) Then Essai:=True;
{*--------------------------Repos quotidien------------------------------*}
{*Dimanche*}
        Semaine(Jour,Mois,Annee,Nombre);
        If Nombre=1 Then Essai:=True;
Fetes:=Essai;
End;


{---------------------------------------------------------------------}


Function TDate.Time:String;
var Heure,Minute,Seconde,Sec100:word;
    temps:String[30];
    _heure,_Minute:String[2];
Begin
GetTime(Heure,Minute,seconde,Sec100);
temps:='';
Str(Heure,_Heure);
If ((Format_time=1) and (Heure>12)) then Begin
                                         Dec(Heure,12);
                                         Temps:=Apres_midi;
                                         End
                                         Else
                                         If Format_time=1 then Temps:=Avant_midi;
If Heure<10 then _heure:='0'+_heure;
Str(Minute,_Minute);
If Minute<0 then _Minute:='0'+_Minute;
If Format_time=1 then temps:=_heure+Separateur_time+_minute+temps;
If Format_time=2 then temps:=_heure+Separateur_time+_minute;
Time:=temps;
End;

Function TDate.Date:String;
Var Jour,Mois,Annee,Sem:Word;
    _Jour,_mois,_Annee:String[2];
    dates:String;

Begin
GetDate(Annee,Mois,Jour,Sem);
Dates:='';
If Annee>2000 then Dec(Annee,2000) Else Dec(Annee,1900);
Str(Jour,_Jour);
Str(Mois,_mois);
Str(Annee,_Annee);
If jour<10 then _Jour:='0'+_Jour;
If mois<10 then _mois:='0'+_mois;
If Annee<10 then _Annee:='0'+_Annee;
If Format_date=1 then dates:=_Mois+Separateur_date+_Jour+Separateur_date+_Annee;
If Format_date=2 then dates:=_Jour+Separateur_date+_mois+Separateur_date+_Annee;
If Format_date=3 then dates:=_Annee+Separateur_date+_mois+Separateur_date+_jour;
Date:=Dates;
End;

End.