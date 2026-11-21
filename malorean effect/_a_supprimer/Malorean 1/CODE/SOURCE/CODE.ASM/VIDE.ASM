; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ
; þ                                                                      þ
; þ                      SOURCE POUR GERER                               þ
; þ                                                                      þ
; þ          LES 4 PLANS DE BYTE EN VGA 320*200 256 COULEURS             þ
; þ                 LA PALETTE DAC 256 COULEURS                          þ
; þ                 CHARGER DES FICHIERS IMAGES                          þ
; þ                                                                      þ
; þ            1993 VOLPONE for MALOREAN EFFFECT TEAM                    þ
; þ                                                                      þ
; þ                                                                      þ
; þ                     DEBUT          : Juillet 1993                    þ
; þ                     DERNIERE MODIF : Juillet 1993                    þ
; þ                                                                      þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ


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

   Mov ah, 4ch          ;fonction de d‚sactivation de programme du DOS
   Int 21h              ;appel du DOS

   END
