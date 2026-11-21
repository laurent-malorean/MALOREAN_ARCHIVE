{------------------Unit‚s Gestion Disque (C) C‚dric Pulrulczyk ------------}
Unit Gest_disk;

{$F+}
{$O+}

Interface
{------------------------------------------------------------------------}
Function Erreur_disk:Boolean;
Function Disk_Requester(Chemin,Suffixe:String;acces:char):String;
Function CopyFile(Source,Destination:String):Boolean;
Function Kill(Nom:String):Boolean;
Procedure Cheminprecis;
Procedure Compression(Suf1,Suf2:string);
Procedure Decompression(Suf1,Suf2:string);
{------------------------------------------------------------------------}
Implementation

uses Crt,Dos,
     Declaration,
     Gest_Clavier,
     Gest_Ecran,
     Gest_fenetres,
     Transfert,
     Configuration,
     Gest_Souris;

{------------------------------------------------------------------------}
Procedure Format(Drive:Char;Format:String;Verify:Boolean);

{ Drive=A , B  /  Format 360, 720, 1,22, 1,44  /  Verify=True Or False }

{-- Constantes --------------------------------------------------------}

const NO_DRIVE    = 0;                           { Lecteur introuvable }
      DD_525      = 1;                             { Lecteur: 5,25" DD }
      HD_525      = 2;                             { Lecteur: 5,25" HD }
      DD_35       = 3;                              { Lecteur: 3,5" DD }
      HD_35       = 4;                              { Lecteur: 3,5" HD }
      EssaisMax   = 5;                         { Nombre essais maximal }

{-- D‚clarations de types ---------------------------------------------}

type DdptType = array[ 0..10 ] of byte;          { Structure pour DDPT }
     DdptPtr = ^DdptType;                          { Pointeur sur DDPT }

     PhysDataType = record         { ParamŠtres physiques de formatage }
       Faces,                                { Nombre de faces demand‚ }
       Pistes,                                { Nombre Pistes par Face }
       Secteurs : byte;                    { Nombre Secteurs par Piste }
       DDPT     : DdptPtr; { Ptr sur table paramŠtres du lect. de disk.}
     end;

     LogDataType = record                { ParamŠtres de formatage DOS }
       Media,                                       { Octet de support }
       Cluster,                          { Nombre Secteurs par Cluster }
       FAT,                              { Nombre Secteurs pour la FAT }
       RootSize : byte;            { Entr‚es dans le r‚pertoire racine }
    end;

    PisteBufType = array[ 1..18, 1..512 ] of byte; { Tampon pour piste }

{-- Variables globales initialis‚es -----------------------------------}

const                      {-- Tables pr‚d‚finies pour chaque format --}


  {-- Donn‚es par d‚faut pour secteur BOOT avec programme chargement --}

      Masqueboot  : array[ 1..102 ] of byte =
                   ( $EB, $35,                { 0000   JMP 0037        }
                     $90,                     { 0002   NOP             }
                   {-- Donn‚es des BPB --------------------------------}

                     $50, $43, $49, $4E, $54, $45, $52, $4E,
                     $00, $00, $00, $01, $00, $00, $00, $00,
                     $00, $00, $00, $00, $00, $00, $00, $00,
                     $00, $00, $00, $00, $00, $00, $00, $00,
                     $00, $00, $00, $00, $00, $00, $00, $00,
                     $00, $00, $00, $00, $00, $00, $00, $00,
                     $00, $00, $00, $00,

                     {-- Programme de chargement ----------------------}

                     $FA,                     { 0037   CLI             }
                     $B8, $30, $00,           { 0038   MOV     AX,0030 }
                     $8E, $D0,                { 003B   MOV     SS,AX   }
                     $BC, $FC, $00,           { 003D   MOV     SP,00FC }
                     $FB,                     { 0040   STI             }
                     $0E,                     { 0041   PUSH    CS      }
                     $1F,                     { 0042   POP     DS      }
                     $BE, $66, $7C,           { 0043   MOV     SI,7C66 }
                     $B4, $0E,                { 0046   MOV     AH,0E   }
                     $FC,                     { 0048   CLD             }
                     $AC,                     { 0049   LODSB           }
                     $0A, $C0,                { 004A   OR      AL,AL   }
                     $74, $04,                { 004C   JZ      0052    }
                     $CD, $10,                { 004E   INT     10      }
                     $EB, $F7,                { 0050   JMP     0049    }
                     $B4, $01,                { 0052   MOV     AH,01   }
                     $CD, $16,                { 0054   INT     16      }
                     $74, $06,                { 0056   JZ      005E    }
                     $B4, $00,                { 0058   MOV     AH,00   }
                     $CD, $16,                { 005A   INT     16      }
                     $EB, $F4,                { 005C   JMP     0052    }
                     $B4, $00,                { 005E   MOV     AH,00   }
                     $CD, $16,                { 0060   INT     16      }
                     $33, $D2,                { 0062   XOR     DX,DX   }
                     $CD, $19 );              { 0064   INT     19      }

      BootMes : string =
       #13#10'DFP  -  (C) 1992 by Michael Tischer'+ #13#10 +
       #13#10'Disquette non systŠme ou d‚fectueuse!'#13#10 +
       'Veuillez changer de disquette et taper une touche' +
       #13#10;

{-- Variables globales non initialis‚es -------------------------------}

var AktDrive     : byte;           { Num‚ro du lecteur … formater 0, 1 }
    AktDriveType : byte;       { Type du lecteur de disquettes courant }
    PData        : PhysDataType; { Informations physiques de formatage }
    LData        : LogDataType;   { Informations logiques de formatage }
    AncDDPT      : pointer;                 { Pointeur sur ancien DDPT }
    OK           : boolean;      { Drapeau pour ex‚cution du programme }
    EndCode      : word;          { Valeur retourn‚e au process appel‚ }
    Param        : string;   { pour ‚valuation de la ligne de commande }

{**********************************************************************}
{* GetDriveType : REtourne le type d'un lecteur de disquettes         *}
{* Entr‚e       : DRIVE = Num‚ro de lecteur (0, 1 etc.)               *}
{* Sortie       : Code lecteur comme constante (DD_525, HD_525 etc.)  *}
{**********************************************************************}

function GetDriveType( Drive : byte ) : byte;

var Regs     : Registers;{ Registre processeur pour appel interruption }

begin
  Regs.ah := $08;             { Fonction: retourner le type de lecteur }
  Regs.dl := Drive;                                { Num‚ro de lecteur }
  intr( $13, Regs );                { Appel d'une interruption du BIOS }
  if ( Regs.flags and fcarry = 0 ) then   { Appel termin‚ sans erreur? }
    GetDriveType := Regs.bl                          { Type de lecteur }
  else
    GetDriveType := DD_525;           { Fonction $08 de l'interruption }
end;                            { introuvable  => type ordinateur = XT }

{**********************************************************************}
{* ResetDisk  : Reset disque sur tous les lecteurs                    *}
{* Entr‚e     : aucune                                                *}
{* Sortie     : aucune                                                *}
{* Info       : Le Reset est effectu‚ sur tous les lecteurs ind‚pen-  *}
{*              demment du num‚ro de lecteur charg‚ dans DL           *}
{**********************************************************************}

procedure DiskReset;

var Regs : Registers;    { Registre processeur pour appel interruption }

begin
  with Regs do
    begin
      ah := $00;          { Num‚ro de fonction pour appel interruption }
      dl := 0;                                { Lecteur a: (voir Info) }
    end;
  intr( $13, Regs );                              { appel interruption }
end;

{**********************************************************************}
{* GetFormatParamter: Retourne les paramŠtres physiques et logiques   *}
{*                    requis par le formatage                         *}
{* Entr‚e           : FORMSTRING = Capacit‚ demand‚e sous forme de    *}
{*                    chaŒne "360", "1200", "720", "1440"             *}
{*                    DRIVETYPE  = Code lecteur tel qu'il est         *}
{*                    retourn‚ par GetDriveType                       *}
{*                    PDATA      = Charg‚ avec les donn‚es de base du *}
{*                    format physique                                 *}
{*                    LDATA      = comme PDATA, mais donn‚es DOS      *}
{* Sortie           : TRUE si format possible sinon FALSE             *}
{* Info             : Vous pouvez ajouter de nouveaux formats en      *}
{*                    ‚tendant cette proc‚dure                        *}
{**********************************************************************}

function GetFormatParameter(     FormString : string;
                                 DriveType  : byte;
                             var PData      : PhysDataType;
                             var LData      : LogDataType  ) : boolean;

const DDPT_360  : DdptType = ( $DF, $02, $25, $02, $09, $2A,
                               $FF, $50, $F6, $0F, $08 );
      DDPT_1200 : DdptType = ( $DF, $02, $25, $02, $0F, $1B,
                               $FF, $54, $F6, $0F, $08 );
      DDPT_720  : DdptType = ( $DF, $02, $25, $02, $09, $2A,
                               $FF, $50, $F6, $0F, $08 );
      DDPT_1440 : DdptType = ( $DF, $02, $25, $02, $12, $1B,
                               $FF, $6C, $F6, $0F, $08 );

      LOG_360  : LogDataType = ( Media : $FD; Cluster  : 2;
                                 FAT   : 2;   RootSize : $70 );
      LOG_1200 : LogDataType = ( Media : $F9; Cluster  : 1;
                                 FAT   : 7;   RootSize : $E0 );
      LOG_720  : LogDataType = ( Media : $F9; Cluster  : 2;
                                 FAT   : 3;   RootSize : $70 );
      LOG_1440 : LogDataType = ( Media : $F0; Cluster  : 1;
                                 FAT   : 9;   RootSize : $E0 );

      PHYS_360  : PhysDataType = ( Faces   :  2; Pistes : 40;
                                   Secteurs :  9; DDPT   : @DDPT_360  );
      PHYS_1200 : PhysDataType = ( Faces   :  2; Pistes : 80;
                                   Secteurs : 15; DDPT   : @DDPT_1200 );
      PHYS_1440 : PhysDataType = ( Faces   :  2; Pistes : 80;
                                   Secteurs : 18; DDPT   : @DDPT_1440 );
      PHYS_720  : PhysDataType = ( Faces   :  2; Pistes : 80;
                                   Secteurs :  9; DDPT   : @DDPT_720  );

begin
  if ( FormString = '1200' ) then                 { 1,2 MB sur 5,25" ? }
    if ( DriveType = HD_525 ) then   { Lecteur et format compatibles ? }
      begin                               { Oui, renseigner paramŠtres }
        PData := PHYS_1200;
        LData := LOG_1200;
        GetFormatParameter := true;                  { Fin sans erreur }
      end
    else
      GetFormatParameter := false    { Lecteur et format incompatibles }
  else if ( FormString = '360' ) then                        { 360 Ko? }
    if ( DriveType = HD_525 ) or ( DriveType = DD_525 ) then
      begin     { Lecteur et format compatibles, renseigner paramŠtres }
        PData := PHYS_360;
        LData := LOG_360;
        GetFormatParameter := true;                  { Fin sans erreur }
      end
    else
      GetFormatParameter := false    { Lecteur et format incompatibles }
  else if ( FormString = '1440' ) then             { 1,44 MB auf 3,5"? }
    if ( DriveType = HD_35 ) then     { Lecteur et format compatibles? }
      begin                               { Oui, renseigner paramŠtres }
        PData := PHYS_1440;
        LData := LOG_1440;
        GetFormatParameter := true;                  { Fin sans erreur }
      end
    else
      GetFormatParameter := false    { Lecteur et format incompatibles }
  else if ( FormString = '720' ) then               { 720 Ko sur 3,5"? }
    if ( DriveType = HD_35 ) or ( DriveType = DD_35 ) then
      begin     { Lecteur et format compatibles, renseigner paramŠtres }
        PData := PHYS_720;
        LData := LOG_720;
        GetFormatParameter := true;                  { Fin sans erreur }
      end
    else
      GetFormatParameter := false    { Lecteur et format incompatibles }
  else
    GetFormatParameter := false;      { Le format demand‚ est invalide }
end;

{**********************************************************************}
{* DiskPrepare  : Pr‚parer le lecteur, param‚trer la vitesse de       *}
{*                transfert des donn‚es                               *}
{* Entr‚e       : DRIVE = Num‚ro de lecteur                           *}
{*                PDATA = ParamŠtres physiques                        *}
{* Sortie       : aucune                                              *}
{**********************************************************************}

procedure DiskPrepare( Drive : byte; PData : PhysDataType );

var Regs : Registers;    { Registre processeur pour appel interruption }

begin
  {-- D‚finir le type de support pour appeler formatage ---------------}

  with Regs do
    begin
      ah := $18;          { Num‚ro de fonction pour appel interruption }
      ch := PData.Pistes - 1;                 { Nombre Pistes par Face }
      cl := PData.Secteurs;                { Nombre Secteurs par Piste }
      dl := Drive;                                 { Num‚ro de lecteur }
    end;
  intr( $13, Regs );                              { appel interruption }
end;

{**********************************************************************}
{* FormatTrack  : Formate une piste                                   *}
{* Entr‚e       : voir ci-dessous                                     *}
{* Sortie       : ‚tat d'erreur                                       *}
{**********************************************************************}

function Formattrack( Lecteur,       { Num‚ro du lecteur de disquettes }
                      Face,                        { Num‚ro de la face }
                      Piste,                        { Piste … formater }
                      Nombre   : byte ) : byte;   { Secteurs par Piste }

type FormatTyp = record
                   DPiste, DFace, DCompteur, DLongueur : byte;
                 end;

var Regs      : Registers;{ Registre processeur pour appel interruption}
    Champdonn : array[ 1..18 ] of FormatTyp;     { maximal 18 Secteurs }
    Compteur   : byte;                         { Compteur d'it‚rations }
    essais  : byte;                            { Nombre essais maximal }

begin
  for Compteur := 1 to Nombre do
    with Champdonn[ Compteur ] do
      begin
        DPiste := Piste;                           { Num‚ro de la piste }
        DFace := Face;                           { Face de la disquette }
        DCompteur := Compteur;                      { Num‚ro du secteur }
        DLongueur := 2;               { Nombre octets par Secteur (512) }
      end;
  essais := EssaisMax;             { D‚finir le nombre d'essais maximal }
  repeat
    with Regs do
      begin
        ah := 5;          { Num‚ro de fonction pour appel interruption }
        al := Nombre;                   { Nombre de secteurs par piste }
        es := Seg( Champdonn );          { Adresse du Champ de donn‚es }
        bx := Ofs( Champdonn );             { dans les registres es:bx }
        dh := Face;                                { Num‚ro de la face }
        dl := Lecteur;                             { Num‚ro de lecteur }
        ch := Piste;                                 { Num‚ro de piste }
      end;
    intr( $13, Regs );              { Appel d'une interruption du BIOS }
    if ( Regs.flags and fcarry = 1 ) then                    { Erreur? }
      DiskReset;             { Oui, Reset disquette avant nouvel essai }
    dec( essais );
  until ( Regs.flags and fcarry = 0 ) or ( essais = 0 );
  Formattrack := Regs.ah;                           { Lire ‚tat erreur }
end;

{**********************************************************************}
{* VerifyTrack  : V‚rifier piste                                      *}
{* Entr‚e       : Lecteur, Face, Piste, nombre de secteurs            *}
{* Sortie       : Code erreur (0=OK)                                  *}
{**********************************************************************}

function VerifyTrack( Lecteur, Face, Piste, Secteurs : byte ) : byte;

var essais   : byte;                           { Nombre essais maximal }
    Regs     : Registers;{ Registre processeur pour appel interruption }
    TamponPiste : PisteBufType;               { M‚moire pour une piste }

begin
  essais := EssaisMax;            { D‚finir le Nombre d'essais maximal }
  repeat
    with Regs do
      begin
        ah := $04;        { Num‚ro de fonction pour appel interruption }
        al := Secteurs;                    { Nombre Secteurs par Piste }
        ch := Piste;                                 { Num‚ro de Piste }
        cl := 1;                          { Commencer par le secteur 1 }
        dl := Lecteur;                             { Num‚ro de lecteur }
        dh := Face;                                { Num‚ro de la face }
        es := Seg( TamponPiste );                  { Adresse du tampon }
        bx := Ofs( TamponPiste );
      end;
    intr( $13, Regs );                       { Appel interruption BIOS }
    if ( Regs.flags and fcarry = 1 ) then                    { Erreur? }
      DiskReset;             { Oui, reset disquette avant nouvel essai }
    dec( essais );
  until ( Regs.flags and fcarry = 0 ) or ( essais = 0 );
  VerifyTrack := Regs.ah;
end;

{**********************************************************************}
{* WriteTrack   : Ecrire piste                                        *}
{* Entr‚e       : Lecteur, Face, Piste, Secteur d‚but, Nombre, Donn‚es*}
{* Sortie       : Code erreur (0=OK)                                  *}
{**********************************************************************}

function WriteTrack(     Lecteur, Face, Piste,
                         Start, Nombre           : byte;
                     var Buffer ) : byte;

var essais : byte;                           { Nombre maximal d'essais }
    Regs     : Registers;{ Registre processeur pour appel interruption }

begin
  essais := EssaisMax;               { D‚finir nombre maximal d'essais }
  repeat
    with Regs do
      begin
        ah := $03;        { Num‚ro de fonction pour appel interruption }
        al := Nombre;                      { Nombre Secteurs par Piste }
        ch := Piste;                                 { Num‚ro de Piste }
        cl := Start;                      { Commencer par le secteur 1 }
        dl := Lecteur;                             { Num‚ro de lecteur }
        dh := Face;                                { Num‚ro de la face }
        es := Seg( Buffer );                     { Adresse pour tampon }
        bx := Ofs( Buffer );
      end;
    intr( $13, Regs );              { Appel d'une interruption du BIOS }
    if ( Regs.flags and fcarry = 1 ) then                    { Erreur? }
      DiskReset;             { Oui, reset disquette avant nouvel essai }
    dec( essais );
  until ( Regs.flags and fcarry = 0 ) or ( essais = 0 );
  WriteTrack := Regs.ah;
end;

{**********************************************************************}
{* PhysicalFormat : Formatage physique de la disquette (‚criture des  *}
{*                  pistes et secteurs)                               *}
{* Entr‚e         : DRIVE  = Code lecteurs                            *}
{*                  PDATA  = ParamŠtres physiques                     *}
{*                  VERIFY = TRUE pour demander v‚rification          *}
{* Sortie         : FALSE si erreur, sinon TRUE                       *}
{**********************************************************************}

function PhysicalFormat( Drive  : byte;
                         PData  : PhysDataType;
                         Verify : boolean ) : boolean;

var essais : byte;                           { Nombre d'essais maximal }
    Regs     : Registers;{ Registre processeur pour appel interruption }
    Piste,                                            { Piste courante }
    Face,                                              { Face courante }
    Status   : byte;         { VAleur de retour des fonctions appel‚es }


begin
  {-- Formatage de la disquette piste par piste ------------------------------}

  for Piste := 0 to PData.Pistes - 1 do     { Ecrire toutes les pistes }
    for Face := 0 to PData.Faces - 1 do      { Ecrire toutes les faces }
      begin
        Write( #13'Piste: ', Piste : 2, '  Face: ', Face : 2 );
       {-- 5 essais au maximum pour formater une piste ----------------}

        essais := EssaisMax;         { D‚finir nombre maximal d'essais }
        repeat
          Status := FormatTrack( Drive, Face, Piste, PData.Secteurs );
          if ( Status = 3 ) then  { Disquette prot‚g‚e en l'‚criture ? }
            begin
              PhysicalFormat := false;   { Quitter proc‚dure si erreur }
              WriteLn( #13'Disquette prot‚g‚e contre l''‚criture' );
              exit;                            { Terminer la proc‚dure }
            end;
          if ( Status = 0 ) and Verify then
            Status := VerifyTrack( Drive, Face, Piste, PData.Secteurs );
          dec( essais );
          if ( Status > 0 ) then               { Le formatage a ‚chou‚ }
            DiskReset;
        until ( Status = 0 ) or ( essais = 0 );
        if ( Status > 0 )  then          { Erreur pendant le formatage }
          begin
            PhysicalFormat := false;     { Quitter proc‚dure si erreur }
            WriteLn( #13'Piste Erreur?aft      ' );
            exit;                              { Terminer la proc‚dure }
          end;
      end;
  PhysicalFormat := true;              { Proc‚dure quitt‚e sans erreur }
end;

{**********************************************************************}
{* LogicalFormat : Formatage logique de la disquette (‚criture du     *}
{*                 secteur de boot, des FAT et du r‚pertoire racine)  *}
{* Entr‚e        : DRIVE = Num‚ro de lecteur                          *}
{*                 PDATA = informations physiques de formatage        *}
{*                 LDATA = informntions logiques de formatage         *}
{* Sortie        : TRUE si aucune erreur ne s'est produite            *}
{**********************************************************************}

function LogicalFormat( Drive : byte;
                        PData : PhysDataType;
                        LData : LogDataType ) : boolean;

var Status         : byte;             { Retour de la fonction appel‚e }
    TousSecteurs   : word;                  { Nombre total de secteurs }
    i              : byte;                     { Compteur d'it‚rations }
    AktSector,
    AktSide,
    AktTrack       : byte;
    Nombre         : integer;   { Nombre des secteurs restant … ‚crire }
    TamponPiste    : PisteBufType;            { M‚moire pour une piste }

begin
  fillchar( TamponPiste, word( PData.Secteurs ) * 512, 0 );{Vide tampon}

  {-- Secteur de boot : partie fixe -----------------------------------}

  move( Masqueboot, TamponPiste, 102 );   { Copier masque secteur boot }
  move( BootMes[1], TamponPiste[ 1, 103 ],      { Copie textes de boot }
        ord(BootMes[0]) );
  TamponPiste[ 1, 511 ] := $55;      { Signe de fin du secteur de boot }
  TamponPiste[ 1, 512 ] := $AA;

  {-- Secteur de boot : partie variable  ------------------------------}

  TousSecteurs := PData.Pistes * PData.Secteurs * Pdata.Faces;
  TamponPiste[ 1, 14 ] := LData.Cluster;            { Longueur Cluster }
  TamponPiste[ 1, 18 ] := LData.RootSize; { Nombre Entr‚es ds r‚p.rac. }
  TamponPiste[ 1, 20 ] := lo( TousSecteurs );{ Nombre total de secteur }
  TamponPiste[ 1, 21 ] := hi( TousSecteurs );       { sur la disquette }
  TamponPiste[ 1, 22 ] := LData.Media;           { descripteur support }
  TamponPiste[ 1, 23 ] := LData.FAT;                { Longueur des FAT }
  TamponPiste[ 1, 25 ] := PData.Secteurs;         { Secteurs par piste }
  TamponPiste[ 1, 27 ] := PData.Faces;               { Nombre de faces }

  {-- Cr‚er FAT et sa copie (contient 00) -----------------------------}

  TamponPiste[ 2, 1 ] := LData.Media;                 { Cr‚er 1Šre FAT }
  TamponPiste[ 2, 2 ] := $FF;
  TamponPiste[ 2, 3 ] := $FF;
  TamponPiste[ LData.FAT + 2, 1 ] := LData.Media;     { Cr‚er 2Šme FAT }
  TamponPiste[ LData.FAT + 2, 2 ] := $FF;
  TamponPiste[ LData.FAT + 2, 3 ] := $FF;

  {-- Boot-Sektor und FAT schreiben -----------------------------------}

  Status := WriteTrack( Drive, 0, 0, 1, PData.Secteurs, TamponPiste );
  if Status <> 0 then
    LogicalFormat := FALSE

  {-- Pas d'erreur? Ecrire r‚pertoire racine --------------------------}

  else
    begin
      fillchar( TamponPiste, 512, 0 );                  { Secteur vide }
      AktSector := PData.Secteurs;      { Ecriture 1Šre piste complŠte }
      AktTrack := 0;                                  { Piste courante }
      AktSide := 0;                                    { Face courante }

      {-- Retourner nombre des secteurs restants et les ‚crire --------}

      Nombre := LData.FAT * 2 + ( LData.Rootsize * 32 div 512 ) +
                1 - PData.Secteurs;

      i := 1;
      repeat
        inc( AktSector );                            { Secteur suivant }
        if ( AktSector > PData.Secteurs ) then      { Fin de la piste? }
          begin
            AktSector := 1;                  { Continuer par secteur 1 }
            inc( AktSide );                          { Face suivante ? }
            if ( AktSide = PData.Faces ) then       { D‚j… 2Šme face ? }
              begin
                AktSide := 0;                   { Revenons … la face 0 }
                inc( AktTrack );
              end;
          end;
        Status := WriteTrack( Drive, AktSide, AktTrack,
                              AktSector, 1, TamponPiste );
        inc( i );
      until ( i > Nombre ) or ( status <> 0 );
      LogicalFormat := ( status = 0 )
    end;
end;



begin
      Param := Drive;   { REtourner lecteur ( 0 = a:, 1 = b: ) }
      AktDrive := ord( upcase( Param[ 1 ] ) ) - 65;
      AktDriveType := GetDriveType( AktDrive ); { Type lecteur courant }
      if ( AktDriveType > 0 ) then                 { Lecteur existant? }
        begin                       { Oui, le programme peut continuer }
          if GetFormatParameter(Format, AktDriveType,
                                 PData, LData) then
            begin                 { Format et lecteur sont compatibles }
              DiskPrepare( AktDrive, PData );
              GetIntVec( $1E, AncDDPT );            { Stocker anc DDPT }
              SetIntVec( $1E, PData.DDPT );    { D‚finir nouvelle DDPT }

              ok := PhysicalFormat( AktDrive, PData, Verify);
              if ok then
                begin
                  Writeln(#13'Ecriture du secteur de boot et des FAT ');
                  ok := LogicalFormat( AktDrive, PData, LData )
                end;

                       {-- Evaluation du formatage --------------------}

              if ok then
                begin
                  WriteLn( #13'Formatage o.k.                 ' );
                  EndCode := 0;
                end
              else
                begin
                  WriteLn( #13'Une erreur a interrompu le formatage' );
                  EndCode := 1;
                end;
              SetIntVec( $1E, AncDDPT );          { Restaurer anc DDPT }
            end
          else
            begin
              WriteLn( 'Le format demand‚ ne peut ˆtre ' +
                       'utilis‚ sur ce lecteur!' );
              EndCode := 2;   { Valeur de retour au processus appelant }
            end
        end
      else
        begin
          WriteLn( 'Le lecteur de disquettes demand‚ n''existe pas');
          EndCode := 3;       { Valeur de retour au processus appelant }
        end
end;

Begin
end.

{------------------------------------------------------------------------}

Function CopyFile;
Type Buf=Array[1..64000] of byte;

Var f1,f2      :File;
    Longueur   :LongInt;
    Buffer     :^Buf;
    FichierLng :Text;
    PbEcrit,
    PbLit,
    Ligne_test :String[80];


Begin
    Assign(FichierLng,nom_langage+'.LNG');
    Reset(FichierLng);
    Repeat
      Readln(FichierLng,Ligne_test);
    Until Ligne_test='{GEST_DIS.6}';
    Readln(FichierLng,PbEcrit);
    Readln(FichierLng,PbLit);
    Close(FichierLng);
    {$I-}
    Assign(f1,Source);
    Assign(f1,Destination);
    Reset(f1,1);
    If Ioresult<>0 Then
    Begin
      Alerte(PbLit+' '+Source);
      CopyFile:=False;
      Exit;
    End;
    Rewrite(f2,1);
    If Ioresult<>0 Then
    Begin
       Alerte(PbEcrit+' '+Destination);
       CopyFile:=False;
       Exit;
    End;
    {$i+}
    Longueur:=Filesize(f1);
    If Longueur=0 Then
    Begin
         Close(f1);
         Close(f2);
         Exit;
    End;
    Repeat
         If Longueur>=64000 then
         Begin
              Blockread(f1,Buffer^,64000);
              Blockwrite(f2,Buffer^,64000);
              Longueur:=Longueur-64000;
         End
    Else
         Begin
              BlockRead(f1,Buffer^,Longueur);
              BlockWrite(f2,Buffer^,Longueur);
              Longueur:=0;
         End;
    Until Longueur=0;
    Close(f1);
    Close(f2);
    CopyFile:=True;
End;
{------------------------------------------------------------------------}
Function Kill;
Var f          :File;
    Long       :LongInt;
    Blank      :Array[1..12000] of Byte;
    FichierLng :Text;
    Ligne_Test,
    PbTrouve   :String[80];
Begin
  Assign(FichierLng,nom_langage+'.LNG');
  Reset(FichierLng);
  Repeat
    Readln(FichierLng,Ligne_test);
  Until Ligne_test='{GEST_DIS.7}';
  Readln(FichierLng,PbTrouve);
  Close(FichierLng);
  For long:=1 to 12000 do Blank[Long]:=Byte('-');
  {$I-}
  Assign(f,Nom);
  Reset(f,1);
  {$I+}
  If IOresult<>0 Then
  Begin
   Alerte(PbTrouve+' '+Nom);
   Kill:=False;
  End
  Else
  Begin
  Long:=Filesize(f);
  Close(f);
  Rewrite(f,1);
  Repeat
        If Long<=12000 Then
        Begin
             BlockWrite(f,Blank,Long);
             Long:=0;
        End
        Else
        Begin
             BlockWrite(f,Blank,12000);
             Long:=Long-12000;
        End;
  Until Long=0;
  Close(f);
  Erase(f);
  Kill:=True;
  End;
End;

{------------------------------------------------------------------------}
Function Erreur_disk:Boolean;
Var Ligne_erreur:Array[1..18] Of String[80];
    FichierLng:Text;
    Ligne_test:String[80];
    Boucle:Integer;

Begin
If Ioresult<>0 Then
Begin
Chargeconfig;
Assign(FichierLng,nom_langage+'.LNG');
reset(FichierLng);
Repeat
 Readln(FichierLng,Ligne_test);
Until Ligne_test='{GEST_DIS.5}';
Readln(FichierLng,Ligne_test);
Close(FichierLng);
Alerte(Ligne_test);
Erreur_disk:=True;
End
Else Erreur_disk:=False;
End;

type Str8=String[8];

Function Disk_Requester(Chemin,Suffixe:String;acces:char):String;

Var inexistant:String[30];
    reecrire:String[30];
    Lignes:Array[1..3] of string[80];


Procedure Charge_langage;
Var fichier:text;
    Ligne_test:String[80];

Begin
Assign(Fichier,nom_langage+'.LNG');
reset(Fichier);
Repeat
 Readln(Fichier,Ligne_test);
Until Ligne_test='{GEST_DIS.2}';
readln(Fichier,Reecrire);
readln(Fichier,Inexistant);
readln(Fichier,Lignes[1]);
readln(Fichier,Lignes[2]);
readln(Fichier,Lignes[3]);
Close(Fichier);
End;

Function Max_Fichier:Integer;
Var Boucle:integer;
    FBC:Searchrec;

Begin
FindFirst(Chemin+'\*.'+Suffixe,Anyfile,FBC);
 Boucle:=0;
 while DosError=0 do
  Begin
   with FBC do
   Begin
    Inc(Boucle);
   End;
 FindNext(FBC);
 End;
Max_Fichier:=Boucle;
End;


Function Recherche_nom_fichier(Enregistrement:Longint):Str8;

Var Boucle:integer;
    Fichier:String[8];
    FBC:Searchrec;

Begin
 FindFirst(Chemin+'\*.'+Suffixe,Anyfile,FBC);
 Boucle:=0;
 while DosError=0 do
  Begin
  with FBC do
  Begin
   Inc(Boucle);
   If Boucle=Enregistrement then
   Begin
    Fichier:='';
    Fichier:=Copy(Name,1,Pos('.',Name)-1);
    recherche_nom_fichier:=fichier;
    Exit;
   End;
  End;
  FindNext(FBC);
 End;
End;

Function Recherche_taille_fichier(Enregistrement:Longint):Str8;

Var Boucle,Taille:LongInt;
    FBC:Searchrec;
    Taille2:String[8];

Begin
 FindFirst(Chemin+'\*.'+Suffixe,Anyfile,FBC);
 Boucle:=0;
 while DosError=0 do
  Begin
  with FBC do
  Begin
   Inc(Boucle);
   If Boucle=Enregistrement then
   Begin
    Taille:=0;
    Taille:=Size;
    If Size<0 then Size:=-Size;
    Taille2:='';
    Str(Taille,Taille2);
    Recherche_taille_fichier:=Taille2;
    Exit;
   End;
  End;
  FindNext(FBC);
 End;
End;

Procedure Presentation;
Var Boucle:integer;
Begin
 Couleur('N');
 Window(25,6,55,20);
 Clrscr;
 Window(1,1,80,25);
 Cadre(25,6,55,20,1);
 gotoxy(26,7);
 Couleur('I');
 If Couleur_ecran Then Begin TextColor(9); TextBackground(3); End;
 If Acces='C' Then Write(Remplissage(Lignes[1],29));
 If Acces='S' Then Write(Remplissage(Lignes[2],29));
 If Acces='E' Then Write(Remplissage(Lignes[3],29));
 Couleur('N');
 If Couleur_ecran Then Begin TextColor(9); TextBackground(0); End;
 Window(25,7,55,20);
 Cadre(2,2,28,10,1);
 Cadre(2,11,30,13,1);
 gotoxy(29,2);
 write('/\');
 gotoxy(29,10);
 write('\/');
 for boucle:=3 to 9 do begin gotoxy(29,boucle); write('³³'); End;
End;

Var Boucle,Boucle2,Boucle4,XSo,YSo:integer;
    Hs:Char;
    Boucle1,Boucle3:LongInt;
    Nom,Nom2,Taille2:string[10];
    trouve,So1,So2,So3:Boolean;
    Test:Char;
    Boucle5:Word;



Begin
Charge_langage;
presentation;
Boucle:=0;
Boucle1:=0;
Boucle4:=1;
Nom:='';
Hs:=':';
Repeat
Repeat
Nom2:='';
Taille2:='';
If GererSouris And SourisAffichee then CacherLaSouris;
If Hs<>'!' Then
For Boucle:=1 to 7 do
Begin
 gotoxy(3,2+Boucle);
 If ((Boucle+Boucle1<Max_fichier+1) and (Boucle+Boucle1>0))  then
 Begin
 Nom2:=Recherche_nom_fichier(Boucle+Boucle1);
 Taille2:=Recherche_taille_fichier(Boucle+Boucle1);
 If Boucle=Boucle4 then Begin Couleur('I'); Nom:=Nom2; End Else Couleur('N');
 Write(Nom2);
 For Boucle2:=0 to 24-(Length(Nom2)+Length(Taille2)) do
 Begin
  write(' ');
 End;
 Write(Taille2);
 End;
End;
If Hs<>'!' Then
 Begin
 Couleur('N');
 gotoxy(3,12);
 write('                           ');
 gotoxy(3,12);
End;
Hs:='!';
if keypressed then
Begin
     Couleur('H');
     nom:=input('M',nom,8,HS);
     Couleur('N');
End;
If Hs<>'!' then
Begin
 gotoxy(3,12);
 Write(Nom);
End;
If gererSouris then
Begin
 If Not SourisAffichee Then MontrerLaSouris;
 EtatSouris(So1,So2,So3,XSo,YSo);
 If ClipSouris(XSo,YSo,52,7,2,1) and So1 then Hs:='U';
 If ClipSouris(XSo,YSo,52,15,2,1) and So1 then Hs:='D';
 If So3 then Hs:='E';
 If So1 then For Boucle5:=1 to 8 do
 If ClipSouris(XSo,YSo,26,7+Boucle5,25,1) then Begin Nom:=Recherche_nom_fichier(Boucle5+Boucle1); Hs:=' '; End;
End;
 if HS='H' then begin Dec(boucle4); nom:=''; end
  else if HS='U' then begin boucle1:=boucle1-7; nom:=''; end
   else if HS='D' then begin boucle1:=boucle1+7; nom:=''; end
    else if HS='B' then begin inc(boucle4); nom:='' end
     else if HS='O' then Begin boucle1:=0; boucle4:=1; nom:='' end
      else if HS='F' then Begin Boucle1:=Max_fichier-7;Boucle4:=7; nom:='' end
       else if HS='E' then Begin Nom:=' '; Disk_requester:=' '; End
        else if HS=' ' then Begin If Nom='' then nom:=Recherche_nom_fichier(Boucle1+Boucle4);
                                                 Hs:=' ';  Disk_requester:=Nom; End
         else Nom:='';
If Boucle4=8 then Begin Inc(Boucle1); Boucle4:=7; End;
If Boucle4=0 then Begin Dec(Boucle1); Boucle4:=1; End;
If Boucle1+7>Max_fichier then Begin Boucle1:=Max_Fichier-7; End;
If Boucle1<0 then Boucle1:=0;
repeat
   If ((Boucle4>Max_fichier) and (Boucle1+7>Max_fichier)) then Dec(Boucle4);
Until Boucle4<Max_fichier+1;
until length(nom)>0;
 if nom<>' ' then
 begin
  trouve:=false;
  for boucle3:=0 to Max_Fichier do
  Begin
   if nom=Recherche_nom_fichier(Boucle3) then trouve:=true;
  end;
  if ((not trouve) and ((acces='C') or (acces='E'))) then
  begin
   gotoxy(3,12);
   write(inexistant);
   delay(500);
   nom:='';
   Disk_requester:='';
  end;
  if (trouve and (acces='S')) then
  begin
   gotoxy(3,12);
   write(reecrire);
   trouve:=false;
   Hs:=readkey;
   hs:=Upcase(Hs);
   test:=Reecrire[Pos('/',Reecrire)-1];
   test:=upcase(test);
   if ((Hs =test)) then trouve:=true
   else
   begin
    Nom:='';
    Disk_requester:='';
   end;
  end;
 end
until length(nom)>0;
Hs:=' ';
Window(25,6,55,20);
If GererSouris and SourisAffichee then CacherLaSouris;
Clrscr;
window(1,1,80,25);
End;


{------------------------------------------------------------------------}

Procedure Cheminprecis;
Var HS:Char;
    AncienChemin,MemChemin:String;
    Libre,Directory,Erreur:String[80];
    Fichiers:text;
    Ligne_test:String[80];

Begin
Assign(Fichiers,nom_langage+'.LNG');
Reset(Fichiers);
Repeat
 Readln(Fichiers,Ligne_test);
Until Ligne_test='{GEST_DIS.4}';
readln(Fichiers,Directory);
readln(Fichiers,Erreur);
readln(Fichiers,Libre);
Close(Fichiers);
Cadre(27,5,55,13,2);
Effacement_ecran(28,6,54,12);
Gotoxy(28,6);
Couleur('I');
Write(Remplissage(Directory,27));
Couleur('N');
Gotoxy(28,8);
Write('    ',Diskfree(Ord(Chemin[1])-64));
Gotoxy(41,8);
Write('/');
Gotoxy(43,8);
Write(Disksize(Ord(Chemin[1])-64));
Gotoxy(28,9);
Write('         ',Round((Diskfree(Ord(Chemin[1])-64)*100/Disksize(Ord(Chemin[1])-64))),'%',Libre);
Cadre(28,10,54,12,1);
Gotoxy(29,11);
Getdir(0,AncienChemin);
MemChemin:=Chemin;
Couleur('H');
Chemin:=ScrollInput('M',Chemin,50,24,Hs);
Couleur('N');
If Hs=' ' then
Begin
{$i-}
 Chdir(Chemin);
{$i+}
 If IOResult<>0 then
 begin
  Cadre(30,7,52,9,1);
  Effacement_ecran(31,8,51,8);
  gotoxy(31,8);
  write(Erreur);
  Chdir(AncienChemin);
  Chemin:=MemChemin;
  Delay(2000);
 End
 Else
 Begin
 {$i-}
  Chdir(AncienChemin);
 {$i+}
 End;
End
Else Chemin:=MemChemin;
Effacement_Ecran(27,5,55,13);
SauveConfig;
End;


Const
TailleBuffer=4096;
LongueurMax=255+17;
BufferInMax=4096;
Rien=tailleBuffer;

Var
Buffer:array[0..TailleBuffer+longueurmax] of byte;
Precedent:array[0..TailleBuffer-1] of word;
Suivant:array[0..TailleBuffer+255] of word;
BufferOut:array[0..24] of byte;
BufferOutPtr:word;
FicIN,FicOUT:file;
Adresse,longueur:word;

{------------------------------------------------------------------------}

Procedure StockerChaine(r:word);

var p:word;
Begin
p:=buffer[r]+taillebuffer;
suivant[r]:=suivant[p];
Suivant[p]:=r;
Precedent[r]:=p;
If Suivant[r]<>Rien then Precedent[Suivant[r]]:=r;
End;

Procedure RechercherChaine(r:word);
Var i,p:word;
Begin
p:=Buffer[r]+tailleBuffer;
p:=Suivant[p];
Longueur:=0;
While p<>rien do begin
If keypressed then exit;
i:=1;
While (Buffer[r+i]=Buffer[P+i]) and (i<LongueurMax) do Inc(i);
If I>Longueur then Begin
Longueur:=i;
Adresse:=p;
If i=LongueurMax then Exit;
End;
P:=Suivant[p];
End;
End;

Procedure EffacerChaine(r:word);
Begin
If precedent[r]=Rien then Exit;
Suivant[precedent[r]]:=rien;
precedent[r]:=rien;
End;

Procedure Compression(Suf1,Suf2:String);
Var i,a,len,r,s:word;
b,mask:byte;
TailleIn,tailleOut:longInt;
Fichein,FicheOut:string;
Compression_en_cours,Bilan,Avant_compactage,Apres_compactage,Gain:String[80];
Fichiers:text;
Ligne_test:String[80];
XSo,YSo:Integer;
So1,So2,So3:Boolean;

Begin
Assign(Fichiers,Nom_langage+'.LNG');
Reset(Fichiers);
Repeat
 Readln(Fichiers,Ligne_test);
Until Ligne_test='{GEST_DIS.1}';
readln(Fichiers,Compression_en_cours);
readln(Fichiers,Bilan);
readln(Fichiers,Avant_compactage);
readln(Fichiers,Apres_compactage);
readln(Fichiers,Gain);
Close(Fichiers);
Fichein:=Disk_requester(Chemin,Suf1,'C');
If Fichein=' ' then exit;
Ficheout:=Chemin+'\'+Fichein+'.'+Suf2;
Fichein:=Chemin+'\'+fichein+'.'+Suf1;
{$i-}
Assign(ficin,Fichein);
Assign(ficout,FicheOut);
reset(ficin,1);
If Erreur_disk Then Begin Clrscr; Exit End;
rewrite(ficout,1);
If Erreur_disk Then Begin Clrscr; Exit End;
{$i+}
Ecran_attente(Compression_en_cours);
For i:=0 to TailleBuffer-1 do precedent[i]:=rien;
For i:=TailleBuffer to TailleBuffer+255 do suivant[i]:=Rien;
R:=LongueurMax;
S:=r+LongueurMax;
For i:=0 to LongueurMax-1 do Buffer[i]:=$20;
Blockread(ficin,Buffer[r],LongueurMax,len);
TailleIn:=Len;
TailleOut:=0;
For i:=0 to LongueurMax-1 do StockerChaine(i);
BufferOutPtr:=1;
BufferOut[0]:=0;
Mask:=1;
While len<>0 do Begin
Pourcentage((Taillein-len)/taillein*100);
RechercherChaine(r);
If longueur>len then longueur:=len;
If Longueur<2 then begin
Longueur:=1;
BufferOut[0]:=BufferOut[0] or mask;
BufferOut[BufferOutPtr]:=Buffer[r];
Inc(BufferOutPtr);
End
Else Begin
BufferOut[BufferOutPtr]:=lo(Adresse);
Inc(BufferOutPtr);
If Longueur>=17 then Begin
BufferOut[BufferOutPtr]:=$F0 or hi(adresse);
Inc(BufferOutPtr);
BufferOut[BufferOutPtr]:=Longueur-17;
end
else begin
BufferOut[BufferOutPtr]:=((longueur-2) shl 4) or hi(adresse);
end;
inc(BufferOutPtr);
end;
Mask:=Mask shl 1;
If Mask=0 then begin
Blockwrite(FicOut,BufferOut,BufferOutPtr);
Inc(TailleOut,BufferOutPtr);
BufferOut[0]:=0;
BufferOutPtr:=1;
Mask:=1;
end;
For i:=1 to longueur do begin
StockerChaine(r);
EffacerChaine(s);
Blockread(ficin,Buffer[s],1,a);
If a=0 then
dec(len)
else begin
Inc(TailleIn);
if s<LongueurMax then Buffer[s+TailleBuffer]:=Buffer[s];
End;
r:=(r+1) and (TailleBuffer-1);
s:=(s+1) and (TailleBuffer-1);
End;
End;
If BufferOutPtr>1 then begin
BlockWrite(ficOut,BufferOut,BufferOutPtr);
Inc(TailleOut,BufferOutPtr);
Pourcentage((Taillein-len)/taillein*100);
End;
Cadre(24,12,56,19,1);
Window(25,13,55,18);
Clrscr;
Gotoxy(1,1);
Couleur('I');
If Couleur_ecran Then Begin TextBackground(3); TextColor(9); End;
Write(Remplissage(BILAN,43));
Couleur('N');
If Couleur_ecran Then Begin TextBackground(0); Textcolor(9); End;
Gotoxy(1,2);
Write('-------------------------------');
Gotoxy(2,3);
Write(Remplissage(Avant_compactage,20),TailleIn/1000:5:2,' Ko');
Gotoxy(2,4);
Write(Remplissage(Apres_compactage,20),TailleOut/1000:5:2,' Ko');
Gotoxy(2,5);
Writeln(Remplissage(Gain,20),100*(1-TailleOut/TailleIn):0:2,' %');
Repeat
If GererSouris Then EtatSouris(So1,So2,So3,XSo,YSo);
until (keypressed or (GererSouris and So1) or (GererSouris and So3));
Window(18,9,60,16);
Clrscr;
Window(1,1,80,25);
Close(ficin);
Erase(Ficin);
Close(ficout);
End;

Procedure Decompression(Suf1,Suf2:String);
Var i,a,r:word;
Entete,mask,b:byte;
Nbre_de_ligne_instant,Nbre_de_ligne_totale,TailleOut1,TailleOut:longint;
Fichein,Ficheout:string;
Fichiers:text;
Decompression:String[80];
Ligne_test:String[80];


Begin
Assign(Fichiers,Nom_langage+'.LNG');
reset(Fichiers);
If Erreur_disk Then Begin Clrscr; Exit End;
Repeat
 Readln(Fichiers,Ligne_test);
Until Ligne_test='{GEST_DIS.3}';
readln(Fichiers,Decompression);
Close(Fichiers);
Fichein:=Disk_requester(Chemin,Suf1,'C');
If Fichein=' ' then exit;
Ficheout:=Chemin+'\'+Fichein+'.'+Suf2;
Fichein:=Chemin+'\'+Fichein+'.'+Suf1;
{$i-}
Assign(ficin,fichein);
Assign(ficout,ficheout);
reset(ficin,1);
If Erreur_disk Then Begin Clrscr; Exit End;
rewrite(ficout,1);
If Erreur_disk Then Begin Clrscr; Exit End;
{$i+}
Ecran_attente(Decompression);
r:=LongueurMax;
For i:=0 to LongueurMax-1 do Buffer[i]:=$20;
Mask:=0;
TailleOut:=0;
TailleOut1:=0;
Nbre_de_ligne_totale:=0;
Nbre_de_ligne_instant:=0;
Repeat
Blockread(Ficin,b,1);
Inc(Nbre_de_ligne_totale);
Until Eof(Ficin);
Reset(Ficin,1);
While not eof(ficin) do begin
Pourcentage(Nbre_de_Ligne_instant/Nbre_de_Ligne_totale*100);
if mask=0 then begin
Blockread(ficin,entete,1);
Inc(Nbre_de_Ligne_instant);
Mask:=1;
End;
If (entete and mask)<>0 then begin
Blockread(ficin,b,1);
Inc(Nbre_de_Ligne_instant);
Blockwrite(ficout,b,1);
Buffer[r]:=b;
r:=(r+1) and (TailleBuffer-1);
Inc(TailleOut);
End
Else begin
Blockread(ficin,a,2);
Inc(Nbre_de_Ligne_instant,2);
Longueur:=(hi(a) shr 4)+2;
If longueur=17 then begin
Blockread(ficin,b,1);
Inc(Nbre_de_Ligne_instant);
Inc(longueur,b);
end;
Adresse:=a and $0FFF;
For i:=1 to longueur do begin
Buffer[r]:=Buffer[Adresse];
Blockwrite(FicOut,Buffer[r],1);
r:=(r+1) and (TailleBuffer-1);
Adresse:=(Adresse+1) and (tailleBuffer-1);
End;
Inc(TailleOut,Longueur);
End;
If TailleOut>TailleOut1 then begin
Inc(TailleOut1,1024);
End;
Mask:=Mask shl 1;
Pourcentage(Nbre_de_Ligne_instant/Nbre_de_Ligne_totale*100);
End;
Close(Ficin);
Erase(Ficin);
CLose(ficout);
Effacement_ecran(29,9,59,15);
End;

{------------------------------------------------------------------------}
End.
