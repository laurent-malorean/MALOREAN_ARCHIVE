; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                      ■
; ■                      SOURCE POUR GERER                               ■
; ■                                                                      ■
; ■          LES 4 PLANS DE BYTE EN VGA 320*200 256 COULEURS             ■
; ■                 LA PALETTE DAC 256 COULEURS                          ■
; ■                 CHARGER DES FICHIERS IMAGES                          ■
; ■                                                                      ■
; ■            1993 VOLPONE for MALOREAN EFFFECT TEAM                    ■
; ■                                                                      ■
; ■                                                                      ■
; ■                     DEBUT          : Juillet 1993                    ■
; ■                     DERNIERE MODIF : Juillet 1993                    ■
; ■                                                                      ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■


   .286
   DOSSEG
   .MODEL LARGE
   org 100h

   .STACK 1024

   .DATA






   .CODE

   MOV AX,@data
   MOV DS,AX


   JMP FinCode





FinCode:



;********************************************************************

   Mov ah, 4ch          ;fonction de désactivation de programme du DOS
   Int 21h              ;appel du DOS

   END
