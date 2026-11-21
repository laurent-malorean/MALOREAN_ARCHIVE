UNIT VIDEO;



INTERFACE

const EV_STATC         = $3DA;       { Registre d'‚tat couleur EGA/VGA }
      EV_STATM         = $3BA;          { Registre d'‚tat mono EGA/VGA }
      EV_ATTR          = $3C0;         { Contr“leur d'attribut EGA/VGA }

procedure ETEINT_CARTE_VIDEO;
procedure ALUME_CARTE_VIDEO;

IMPLEMENTATION

{*************************************************************************}

procedure CLI; inline( $FA );                { Inhibe les interruptions}
procedure STI; inline( $FB );             { R‚tablit les interruptions }

{*************************************************************************}

procedure ETEINT_CARTE_VIDEO;
var dummy : BYTE;          { Pour m‚moriser les contenus des registres }

begin
  cli;                             { Pas d'interruption pour le moment }
  dummy := port[EV_STATC];          { Reset du registre d'‚tat couleur }
  dummy := port[EV_STATM];             { Reset du registre d'‚tat mono }
  port[EV_ATTR] := $00;                       { Efface le bit 5 ce qui }
                      { supprime la liaison avec le contr“leur d'‚cran }
  sti;                                    { R‚tablit les interruptions }
end;

{*************************************************************************}

procedure ALUME_CARTE_VIDEO;
var dummy : BYTE;          { Pour m‚moriser les contenus des registres }

begin
  cli;                                      { Inhibe les interruptions }
  dummy := port[EV_STATC];          { Reset du registre d'‚tat couleur }
  dummy := port[EV_STATM];             { Reset du registre d'‚tat mono }
  port[EV_ATTR] := $20;                       { Active le bit 5 ce qui }
                       { r‚tablit la liaison avec le contr“leur d'‚cran}
  sti;                          { Autorise … nouveau les interruptions }
end;

{*************************************************************************}

END.