{***********************************************************************
*                        V O N O F F P . P A S                         *
**--------------------------------------------------------------------**
*  Fonction  : Montre comment éteindre et rallumer un écran EGA ou VGA *
**--------------------------------------------------------------------**
*  Auteur         : MICHAEL TISCHER                                    *
*  Développé le   : 05.08.1990                                         *
*  dernière MAJ   : 14.01.1991                                         *
***********************************************************************}

program VOnOffP;

uses DOS, CRT;                                    { Inclut les unités  }

{-- Constantes --------------------------------------------------------}

const EV_STATC         = $3DA;       { Registre d'état couleur EGA/VGA }
      EV_STATM         = $3BA;          { Registre d'état mono EGA/VGA }
      EV_ATTR          = $3C0;         { Contrôleur d'attribut EGA/VGA }

procedure CLI; inline( $FA );                { Inhibe les interruptions}
procedure STI; inline( $FB );             { Rétablit les interruptions }

{***********************************************************************
*  ScrOff : Désactive un écran EGA ou VGA.                             *
**--------------------------------------------------------------------**
*  Entrée  : néant                                                     *
***********************************************************************}

procedure ScrOff;

var dummy : BYTE;          { Pour mémoriser les contenus des registres }

begin
  cli;                             { Pas d'interruption pour le moment }
  dummy := port[EV_STATC];          { Reset du registre d'état couleur }
  dummy := port[EV_STATM];             { Reset du registre d'état mono }
  port[EV_ATTR] := $00;                       { Efface le bit 5 ce qui }
                      { supprime la liaison avec le contrôleur d'écran }
  sti;                                    { Rétablit les interruptions }
end;

{***********************************************************************
*  ScrOn : Réactive un écran EGA ou VGA.                               *
**--------------------------------------------------------------------**
*  Entrée : néant                                                      *
***********************************************************************}

procedure ScrOn;

var dummy : BYTE;          { Pour mémoriser les contenus des registres }

begin
  cli;                                      { Inhibe les interruptions }
  dummy := port[EV_STATC];          { Reset du registre d'état couleur }
  dummy := port[EV_STATM];             { Reset du registre d'état mono }
  port[EV_ATTR] := $20;                       { Active le bit 5 ce qui }
                       { rétablit la liaison avec le contrôleur d'écran}
  sti;                          { Autorise à nouveau les interruptions }
end;

{***********************************************************************
*  IsEgaVga : Teste la présence d'une carte EGA ou VGA .               *
**--------------------------------------------------------------------**
*  Entrée : néant                                                      *
*  Sortie : TRUE, si carte EGA ou VGA, sinon FALSE                     *
***********************************************************************}

function IsEgaVga : boolean;

var Regs : Registers;            { Resgitres pour gérer l'interruption }

begin
  Regs.AX := $1a00;               { La fonction 1Ah n'existe qu'en VGA }
  Intr( $10, Regs );
  if ( Regs.AL = $1a ) then                     { Est-elle disponible ?}
    IsEgaVGa := TRUE
  else
    begin
      Regs.ah := $12;                           { Appelle l'option 10h }
      Regs.bl := $10;                          { de l'interruption 12h }
      intr($10, Regs);                { Déclenche l'interruption vidéo }
      IsEgaVga := ( Regs.bl <> $10 );
    end;
end;

{**********************************************************************}
{--                        PROGRAMME PRINCIPAL                       --}
{**********************************************************************}

var ch : char;                                   { Mémorise une touche }

begin
  ClrScr;
  writeln( 'VONOFFP  -  (c) 1990, 1991 by MICHAEL TISCHER'#13#10 );
  if IsEgaVga then                                { Carte EGA ou VGA ? }
    begin                                               { Oui, on y va }
      writeln( 'Attention l''écran va s''éteindre dans 5 secondes');
      writeln( 'Appuyez ensuite sur une touche pour le rallumer');

      Delay( 5000 );                           { Attente de 5 secondes }
      while KeyPressed do                  { Vide le buffer du clavier }
        ch := ReadKey;
      ScrOff;                                         { Eteint l'écran }
      ch := ReadKey;                               { Attend une frappe }
      ScrOn;                                        { Restaure l'écran }
      writeln ( #13#10#10#10 + 'C''est tout ...' );
    end
  else                                  { Non, pas de carte EGA ou VGA }
    writeln( 'Attention ! Ce programme exige ' +
             'une carte EGA ou VGA.' );
end.
