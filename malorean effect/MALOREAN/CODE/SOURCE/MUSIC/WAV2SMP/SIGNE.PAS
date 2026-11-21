{USES ECRAN,FENETRE,POINTEUR,DOS;}
USES DOS,DISK,ECRAN,FENETRE,CRT,CURSEUR;

TYPE   TYPE_FICHIER_WAV = ARRAY[0..65534] of Byte;
TYPE   TYPE_FICHIER_SMP = ARRAY[0..65534] of Byte;

VAR    Win1 : OBJET_FENETRE;

VAR    Compteur_Fichier  : Word;

{***************************************************************************}

PROCEDURE CONVERTIR_WAV_EN_SMP  (Fichier     : String);
VAR       WAV : ^TYPE_FICHIER_WAV;  {variable pour charger et sauver}
VAR       SMP : ^TYPE_FICHIER_SMP;  {les deux fichiers}

VAR       FILE_WAV    :  FILE;
VAR       FILE_SMP    :  FILE;

VAR       SIZE_WAV    : WORD ;

VAR       COMPTEUR    : WORD ;

BEGIN;    NEW(WAV);          {initialise les pointeurs}
          NEW(SMP);

          SIZE_WAV  :=SizeOffile(FICHIER+'.smp');

          Assign    (FILE_WAV,FICHIER+'.smp');   {ouvre le fichier WAV}
          Reset     (FILE_WAV,1);
          BlockRead (FILE_WAV,WAV^,SIZE_WAV);
          Close     (FILE_WAV);

          FOR COMPTEUR:=0 to SIZE_WAV Do SMP^[COMPTEUR]:=WAV^[COMPTEUR]+126;

          Assign     (FILE_SMP,FICHIER+'.smp');  {sauve le fichier smp}
          Rewrite    (FILE_SMP,1);
          BlockWrite (FILE_SMP,SMP^,SIZE_WAV); {-40 car a virer l'entete}
          Close      (FILE_SMP);


          DISPOSE (WAV);     {Vire les pointeurs}
          DISPOSE (SMP);
END;

{***************************************************************************}

BEGIN; Carte_Compatible  (True);
       CLS(PAGE_0,CYAN);
       WIN1.INIT(05,8,70,16,OMBRE,'WAV2SMP Version 1.0 ');
       WIN1.OPEN(PAGE_0);
       Ecrit (PAGE_0,25,11,NOIR,BLANC,SurIntensite,PasClignotement,
       'Code By VOLPONE of MALOREAN EFFECT');
       Ecrit (PAGE_0,32,12,NOIR,BLANC,SurIntensite,PasClignotement,
       'Release June 1994');

       Ecrit (PAGE_0,10,14,NOIR,BLANC,SurIntensite,PasClignotement,
       'Convert an 16KHert Unsigned WAV file to an unsigned SMP file');
       Ecrit (PAGE_0,13,15,NOIR,BLANC,SurIntensite,PasClignotement,
       'I use this utilities for FastTracker Coded by Mr H ');

       IF ParamCount=0 Then Begin;
                            Ecrit (PAGE_0,17,18,BLANC,NOIR,SurIntensite,
                            PasClignotement,'Syntaxe  WAV2SMP NameFile (no WAV extention)');
                            Delay(4000);
                            End
                       Else Begin;
                            Ecrit (PAGE_0,34,18,BLANC,NOIR,SurIntensite,
                                  PasClignotement,'Convertion');
                            For Compteur_Fichier :=1 To ParamCount Do
                                     Begin;
                                     CONVERTIR_WAV_EN_SMP(ParamStr(Compteur_Fichier));
                                     Ecrit (PAGE_0,28,20,NOIR,BLANC,SurIntensite,
                                     PasClignotement,ParamStr(Compteur_Fichier)+ ' is converted');
                                     Delay(300);
                                     End;
                            End;

       Put_Page (PAGE_0);

Delay(500);
Restaure;
END.













