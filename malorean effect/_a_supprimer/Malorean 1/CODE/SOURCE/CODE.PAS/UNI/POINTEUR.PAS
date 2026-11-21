{**********************************************************************
*                                                                     *
*                     Unit‚ de gestion de pointeur                    *
*                      Par Laurent Desechalliers                      *
*                                                                     *
***********************************************************************}

UNIT POINTEUR;

INTERFACE

TYPE STRING12                 = STRING[12] ;
TYPE STRING8                  = STRING[8] ;


TYPE Pointeur_Byte            = ^Byte      ;
     Pointeur_Word            = ^Word      ;
     Pointeur_Integer         = ^Integer   ;
     Pointeur_LongInt         = ^LongInt   ;
     Pointeur_String          = ^String    ;
     Pointeur_Boolean         = ^Boolean   ;
     Pointeur_Char            = ^Char      ;

     Pointeur_String12        = ^String12  ;

     Pointeur_Array_Byte      = Array[0..10000] of Pointeur_Byte    ;
     Pointeur_Array_Word      = Array[0..10000] of Pointeur_Word    ;
     Pointeur_Array_Integer   = Array[0..10000] of Pointeur_Integer ;
     Pointeur_Array_LongInt   = Array[0..10000] of Pointeur_LongInt ;
     Pointeur_Array_String    = Array[0..10000] of Pointeur_String  ;
     Pointeur_Array_Boolean   = Array[0..10000] of Pointeur_Boolean ;
     Pointeur_Array_Char      = Array[0..10000] of Pointeur_Char    ;

     Pointeur_Array_String12  = Array[-1..10000] of Pointeur_String12;


IMPLEMENTATION

BEGIN;
END.