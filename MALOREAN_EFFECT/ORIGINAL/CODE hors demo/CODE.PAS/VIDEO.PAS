UNIT VIDEO;



INTERFACE

const EV_STATC         = $3DA;       { Registre d'état couleur EGA/VGA }
      EV_STATM         = $3BA;          { Registre d'état mono EGA/VGA }
      EV_ATTR          = $3C0;         { Contrôleur d'attribut EGA/VGA }

procedure ETEINT_CARTE_VIDEO;
procedure ALUME_CARTE_VIDEO;

IMPLEMENTATION

{*************************************************************************}

procedure CLI; inline( $FA );                { Inhibe les interruptions}
procedure STI; inline( $FB );             { Rétablit les interruptions }

{*************************************************************************}

procedure ETEINT_CARTE_VIDEO;
var dummy : BYTE;          { Pour mémoriser les contenus des registres }

begin
  cli;                             { Pas d'interruption pour le moment }
  dummy := port[EV_STATC];          { Reset du registre d'état couleur }
  dummy := port[EV_STATM];             { Reset du registre d'état mono }
  port[EV_ATTR] := $00;                       { Efface le bit 5 ce qui }
                      { supprime la liaison avec le contrôleur d'écran }
  sti;                                    { Rétablit les interruptions }
end;

{*************************************************************************}

procedure ALUME_CARTE_VIDEO;
var dummy : BYTE;          { Pour mémoriser les contenus des registres }

begin
  cli;                                      { Inhibe les interruptions }
  dummy := port[EV_STATC];          { Reset du registre d'état couleur }
  dummy := port[EV_STATM];             { Reset du registre d'état mono }
  port[EV_ATTR] := $20;                       { Active le bit 5 ce qui }
                       { rétablit la liaison avec le contrôleur d'écran}
  sti;                          { Autorise à nouveau les interruptions }
end;

{*************************************************************************}

END.