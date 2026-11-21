{**********************************************************************
*                                                                     *
*            Unité de gestion des disques dur et disquettes           *
*                      Par Laurent Desechalliers                      *
*                                                                     *
***********************************************************************}



UNIT DISK;

INTERFACE

USES DOS,POINTEUR;

TYPE ObjDirFile      = OBJECT
                       NbFile       : Integer;
                       Fichier      : Pointeur_Array_String12;
                       DirInfo      : SearchRec;
                       PROCEDURE  DirFile (Chemin   : String);
                       END;

TYPE ObjDirDirectory = OBJECT
                       NbDirectory     : Integer;
                       Directory       : Pointeur_Array_String12;
                       DirInfo         : SearchRec;
                       PROCEDURE  DirDirectory (Chemin   : String);
                       END;

FUNCTION SizeOfFile (Nom : String) : WORD;



IMPLEMENTATION

FUNCTION  SizeOfFile (Nom : String) : WORD;
VAR  DirInfo: SearchRec;
BEGIN; FindFirst(Nom, Archive, DirInfo);
       SizeOfFile:=DirInfo.Size;
END;






PROCEDURE ObjDirFile.DirFile;
BEGIN;    NbFile:=0;
          New(Fichier[-1]);
          New(Fichier[0]);
          FindFirst(Chemin+'*.*',$20, DirInfo);
          WHILE DosError=0 DO BEGIN
                              New(Fichier[NbFile+1]);
                              Fichier[NbFile+1]^:=DirInFo.Name;
                              FindNext(DirInfo);
                              Inc(NbFile);
                              END;
END;

PROCEDURE ObjDirDirectory.DirDirectory;
BEGIN;    NbDirectory:=0;
          New(Directory[-1]);
          New(Directory[0]);
          FindFirst(Chemin+'*.',$10, DirInfo);
          WHILE DosError=0 DO BEGIN
                              New(Directory[NbDirectory+1]);
                              Directory[NbDirectory+1]^:=DirInFo.Name;
                              FindNext(DirInfo);
                              Inc(NbDirectory);
                              END;
END;


BEGIN;
END.