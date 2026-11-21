UNIT GRAPH4P;



INTERFACE

CONST OFSET_PAGE_GRAPHIQUE_0=0;
      OFSET_PAGE_GRAPHIQUE_1=16000;
      OFSET_PAGE_GRAPHIQUE_2=32000;
      OFSET_PAGE_GRAPHIQUE_3=48000;




VAR    MUL80  : ARRAY[0..201] OF WORD;
VAR    MUL80_PLUS_CENTRE : ARRAY[0..201] OF WORD;
VAR    MOIN_MUL80_PLUS_CENTRE : ARRAY[0..201] OF WORD;

VAR    _C1    : WORD;

PROCEDURE GRAPH_MODE_4;
PROCEDURE TEXT_MODE   ;
PROCEDURE PUTPIXEL_4  (X,Y     : Word ;
                       Couleur : Byte );
PROCEDURE PUTPIXEL_4_OCTANT  (X,Y     : Word ;
                              Couleur : Byte );


IMPLEMENTATION

{**************************************************************************}

PROCEDURE GRAPH_MODE_4; ASSEMBLER;
ASM; { Initialisation du mode 320*200 256 couleurs
                          4 plans de bite , 4 pages}
         MOV AX,0012h  { Passage en mode 320*200 16 couleurs 4 plans      }
         INT 10h       { pour netoyer les 256 ko de Vram                  }
         MOV AX,013h   { Passage en mode 320*200 256 couleur              }
         INT 10h       { sans plan de bit                                 }

         MOV DX,03C4h  { Séquenceur registre 4 "memory mode"              }
         MOV AX,0604h  { Masque 110b  byte 1->256k Vram                   }
                       {              byte 2->Mode odd/even désactivé     }
                       {        traitement linéaire d'un plan de bite     }
         OUT DX,AX     { Ecriture dans le port                            }

         MOV DL,0D4h   { Controleur CRT                                   }
         MOV AX,0014h  { Registre 14h M                                   }
                       { Masque 00000000b  -> Vire le mode Double Word    }

         OUT DX,AX     {  Ecriture dans le port                           }

         MOV AX,0E317h {  Registre 17h                                    }
                       {  Masque 11100011b -> Passe en mode Byte          }
         OUT DX,AX     {  Ecriture dans le port                           }

END;

{**************************************************************************}

PROCEDURE TEXT_MODE; ASSEMBLER;
ASM;     MOV AX,03h
         Int 10h
END;

{**************************************************************************}
PROCEDURE PUTPIXEL_4  (X,Y     : Word ;
                       Couleur : Byte );
VAR OFSET_POINT : WORD;
BEGIN; OFSET_POINT:=MUL80[Y];

ASM; { Donnne le segment du point}

   MOV AX,0A000h     ; {Segment de la vram}
   MOV ES,AX         ;

   MOV AX,OFSET_POINT  ;{Determine l'ofset du point} {AX:=y*80}


   MOV BX,X          { BX:=X                      }
   MOV CX,BX         { CX:=X                      }
   SHR BX,2          { BX:=Round(X/4)             }
   ADD BX,AX         { BX:=80*Y+Round(X/4)        }
{   ADD BX,PageDeBase ; BX:=80*Y+Round(X/4)+PageDeBase}

{  Determine le plan de bit et masque les autre    }

   AND CL,011b       { Cl:=X mod 4=n° du plan de bit                   }
   MOV AX,0102h      { AL:=2d -> 2em registre "MAP MASK"               }
                     { AH:=1b -> Sera combiné avec SHL pour le masque  }
   SHL AH,CL         { Le masque est crée                              }
   MOV DX,03C4h      { Séquenceur VGA                                  }
   OUT DX,AX         { Selectione le port                              }


{  Affiche le pixel dans la VRAM}

   MOV AL,Couleur
   MOV Es:[BX],AL

END;
END;

{**************************************************************************}

PROCEDURE PUTPIXEL_4_OCTANT  (X,Y     : Word ;
                              Couleur : Byte );
VAR OFSET_POINT_X : WORD;
VAR OFSET_POINT_Y : WORD;
VAR OFSET_POINT_Z : WORD;

BEGIN; OFSET_POINT_X:=MUL80[X];
       OFSET_POINT_Y:=MUL80_PLUS_CENTRE[Y];
       OFSET_POINT_Z:=MOIN_MUL80_PLUS_CENTRE[Y];

ASM; { Donnne le segment du point}

   MOV AX,0A000h     ; {Segment de la vram}
   MOV ES,AX         ;
   MOV AX,OFSET_POINT_Y  ;{Determine l'ofset du point} {AX:=y*80}


   MOV BX,X          { BX:=X                      }
   MOV CX,BX         { CX:=X                      }
   SHR BX,2          { BX:=Round(X/4)             }
   ADD BX,AX         { BX:=80*Y+Round(X/4)        }

{  Determine le plan de bit et masque les autre    }

   AND CL,011b       { Cl:=X mod 4=n° du plan de bit                   }
   MOV AX,0102h      { AL:=2d -> 2em registre "MAP MASK"               }
                     { AH:=1b -> Sera combiné avec SHL pour le masque  }
   SHL AH,CL         { Le masque est crée                              }
   MOV DX,03C4h      { Séquenceur VGA                                  }
   OUT DX,AX         { Selectione le port                              }


{  Affiche le pixel dans la VRAM}

   MOV AL,Couleur
   MOV Es:[BX],AL

   MOV AX,OFSET_POINT_Z  ;{Determine l'ofset du point} {AX:=y*80}


   MOV BX,X          { BX:=X                      }
   MOV CX,BX         { CX:=X                      }
   SHR BX,2          { BX:=Round(X/4)             }
   ADD BX,AX         { BX:=80*Y+Round(X/4)        }

{  Affiche le pixel dans la VRAM}

   MOV AL,Couleur
   MOV Es:[BX],AL

END;
END;

{**************************************************************************}



BEGIN;  For _C1:=0 to 201 do Begin;
                             MUL80[_C1]:=_C1*80;
                             MUL80_PLUS_CENTRE[_c1]:=80*_C1+8040;
                             MOIN_MUL80_PLUS_CENTRE[_c1]:=8040-80*_C1;
                             End;
END.