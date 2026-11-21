{---------- Unit‚ Gestion Clavier en objet (C) C‚dric Pulrulczyk ----------}
Unit Gest_clavier;

{$F+}
{$O+}


Interface
{------------------------------------------------------------------------}
Uses Gest_Ecran;
Const {Code caract‚re}
      kbEnd='F';  kbHome='O';   kbPageUp='U';   kbPageDown='W';  kbESC='E';
      kbHaut='H'; kbBas='B';    kbDroite='D';   kbGauche='G'; kbReturn=' ';

      kbF1='F1';   kbF2='F2';     kbF3='F3';       kbF4='F4';        kbF5='F5';
      kbF6='F6';   kbF7='F7';     kbF8='F8';       kbF9='F9';        kbF10='F10';

      kbShiftF1='Shift+F1'; kbShiftF2='Shift+F2'; kbShiftF3='Shift+F3';
      kbShiftF4='Shift+F4';

      kbAltX='ALT+X';

      {Code des types pour Saisie et ScrollSaisie}
      cmTout='S';       cmNumerique='N';      cmMajuscule='M';
      cmAlphaNumerique='A'; cmValeur='V';     cmTime='T';
      cmDate='D';      cmControl='C';

      {Code avec centrage automatique}
      cmToutCentre='s';            cmNumeriqueCentre='n';   cmMajusculeCentre='m';
      cmAlphaNumeriqueCentre='a';  cmValeurCentre='v';
      cmTimeCentre='t';            cmDateCentre='d';

{VOLOPONE VAR PART}
VAR  GADGET_TOUCHE : CHAR;
     GADGET_ETAT   : BOOLEAN;





{VOLPONE CODE PART}
PROCEDURE GADGET_TOUCHE_ETAT;

{------------------------------------------------------------------------}

Implementation
Uses Crt,Dos;

{-------------------------------------------------------------------------}
{---------------   VOLPONE CODE PART     ---------------------------------}
PROCEDURE GADGET_TOUCHE_ETAT;
BEGIN;
IF KEYPRESSED THEN BEGIN;
                   GADGET_TOUCHE := READKEY ;
                   GADGET_ETAT   := TRUE;
                   END
              ELSE GADGET_ETAT   := FALSE;


END;
{-------------------------------------------------------------------------}
End.
