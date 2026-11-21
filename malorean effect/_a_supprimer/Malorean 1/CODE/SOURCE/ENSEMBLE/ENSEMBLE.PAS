UNIT ENSEMBLE;

INTERFACE

TYPE TYPE_ELEMENT      = String;

     POINTEUR_ENSEMBLE = ^TYPE_ENSEMBLE;

     TYPE_ENSEMBLE     = RECORD
                         Element : TYPE_ELEMENT;
                         Suivant : POINTEUR_ENSEMBLE;
                         END;

     OBJET_ENSEMBLE =    OBJECT
                         ENSEMBLE : POINTEUR_ENSEMBLE;
                         RACINE   : POINTEUR_ENSEMBLE;
                         VIDE     : BOOLEAN;

                         PROCEDURE INIT;
                         PROCEDURE Ajoute ( NouveauElement : TYPE_ELEMENT);
                         PROCEDURE AFFICHE ;
                         FUNCTION  APPARTIENT ( ElementChercher : TYPE_ELEMENT) : BOOLEAN;


                         PROCEDURE Kill;
                         END;


IMPLEMENTATION

{************************************************************************}
PROCEDURE  OBJET_ENSEMBLE.Init;
BEGIN;      Vide:=TRUE;
END;
{************************************************************************}
PROCEDURE  OBJET_ENSEMBLE.Ajoute;
VAR        Nouveau : POINTEUR_ENSEMBLE;
BEGIN;     If (Vide=True) Then Begin;
                               NEW (Ensemble);
                               Ensemble^.Suivant:=Nil;
                               Ensemble^.Element:=NouveauElement;
                               RAcine:=Ensemble;
                               Vide:=False;
                               End
                          Else Begin;
                               Ensemble:=Racine;
                               While (Ensemble^.Suivant<>Nil)
                                     Do Ensemble:=Ensemble^.Suivant;
                               New(Nouveau);
                               Nouveau^.Suivant :=Nil;
                               Nouveau^.Element :=NouveauElement;
                               Ensemble^.Suivant:=Nouveau;
                               End;
END;
{************************************************************************}
PROCEDURE  OBJET_ENSEMBLE.AFFICHE;
BEGIN;     If (Vide=False) Then Begin;
                                Ensemble:=Racine;
                                Write(Ensemble^.Element,' ');
                                While(Ensemble^.Suivant<>Nil) Do Begin;
                                                                 Ensemble:=Ensemble^.Suivant;
                                                                 Write(Ensemble^.Element,' ');
                                                                 End;
                                End;
END;
{************************************************************************}
FUNCTION   OBJET_ENSEMBLE.Appartient;
VAR        Drapeau : BOOLEAN;
BEGIN;     Drapeau:=False;
If (Vide=False) Then Begin; {1}
                     Ensemble:=Racine;
                     If Ensemble^.Element=ElementChercher
                           Then Drapeau:=True
                           Else While  (Ensemble^.Suivant<>Nil)
                                      Do BEGIN; {1.1}
                                         Ensemble:=Ensemble^.Suivant;
                                         If (Ensemble^.Element=ElementChercher) Then Drapeau:=True;
                                         End; {1.1}
                     end {1}
                     Else Drapeau:=False;

Appartient:=Drapeau;
END;
{************************************************************************}
PROCEDURE  OBJET_ENSEMBLE.Kill;
VAR        Ancien : POINTEUR_ENSEMBLE;
BEGIN;     If (Vide=False) Then Begin;
                                Ensemble:=Racine;
                                While (Ensemble^.Suivant<>Nil) Do BEGIN;
                                                                 Ancien:=Ensemble;
                                                                 Ensemble:=Ensemble^.Suivant;
                                                                 Dispose(Ancien);
                                                                 END;
                                Dispose (Ensemble);
                                Vide:=True;
                                End;

END;
{************************************************************************}
BEGIN;
END.