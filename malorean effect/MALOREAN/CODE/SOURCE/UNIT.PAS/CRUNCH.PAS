USES GEST_DISQUE;

VAR DISK : TDISQUE;

BEGIN;
DISK.INIT;
{DISK.Compression('benoit.000','Data.cru');}
DISK.DeCompression('data.cru','Data.001');

END.