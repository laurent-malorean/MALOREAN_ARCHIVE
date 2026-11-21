{$M 1024,0,1260}
Uses CScreen,Dos,Mouse,CGraph;

Type Tf = ARRAY [1..20] Of String [20];


     T1 = Array [1..3] Of TypeContenuWinAuto;
     T2 = RECORD
          Entete  : String [20];
          Name    : TypeContenuWinAuto;
          Command : Array [1..15] Of String [35];
          Work    : Array [1..15] Of String [20];
          END;
     T3 = ARRAY [1..3] Of T2;

Const
C1 : T1              =(
                        ('TURBO PASCAL',
                         'DELUXE PAINT',
                         'FRACTINT',
                         'PIZZA +',
                         'PCSHELL',
                         '',
                         '',
                         '',
	                 '',
                         '',
                         '',
	                 '',
                         '',
                         '',
                         '','','','','','','',''),

                        ('KERMIT       ',
                         'COPYX',
                         'DCF',
                         'GWS',
                         'DERIVE',
                         'DISKFIX',
                         'PCSHELL',
                         'DISKFIX',
	                 'DISKTOOLS',
                         'DM',
                         'FORMATEUR',
	                 'COMPRESS',
                         'UNDELET',
                         'VIEW',
                         'NDD','','','','','','',''),

                        ('UNREAL     ',
                         'BAL',
                         'INC 1',
                         'INC 2',
                         'TDT 1',
                         'TDT 2',
                         'TDT 3',
                         'TRSI 1',
	                 'TRSI 2',
                         '',
                         'Alone In ...',
	                 'Lemings',
                         '4D Sports ...',
                         'Super tetris',
                         '','','','','','','','')
                         );
execute : TF =('c:\works\works.exe',
               'c:\hugo\hugo.exe',
               'c:\fp\fp.exe',
               'c:\hg\hg.exe',
               'c:\dpii\dpii.exe',
               'd:\turbo\turbo.exe',
               'c:\pc\p.exe',
               'c:\pc\diskfix.exe',
               'c:\pc\ndd.exe',
               'c:\pc\dm.exe',
               'c:\pc\pcformat.exe',
               'c:\pc\Sd.exe',
               'c:\pc\si.exe',
               'c:\pc\Undel.exe',
               'c:\dos\mem.exe',
               '','','','','');

va_dir : TF = ('f:\apis',
	       '',
	       '',
	       '',
	       'd:\dpii',
	       'd:\turbo',
	       '','','','','','','','','','','','','','');


Var
     Mousse  : ObjMouse;

     WinFond : ObjWin;
     Winhelp : ObjWin;

     WinFile1: ObjWinAuto;
     WinFile2: ObjWinAuto;
     WinFile3: ObjWinAuto;


     BRun    : ObjButton;
     BExit   : ObjButton;

     StateRun  :  TState;
     StateExit :  TState;
     NoProg    :  Byte;

     Text      :  TGraphVga;

     Lanceur   : T3;



Procedure Fenetres;
Begin;
Lanceur[1].command[5]:=('jjj');
WinFond.Fond_Ecran (WorkScreen,Blanc,Bleu);
WinFond.WIn4  (WorkScreen,'MALOREAN EFFECT : Groupe de demo',3,2,77,24,Blanc,Bleu,Magenta);
WinFile1.Init  (6,6,15,Blanc,Bleu,Noir,Blanc,'Applications',C1[1]);
WinFile1.Show  (Workscreen);
WinFile2.Init  (26,6,15,Blanc,Bleu,Noir,Blanc,'Utilitaires',C1[2]);
WinFile2.Show  (Workscreen);
WinFile3.Init  (46,6,15,Blanc,Bleu,Noir,Blanc,'Jeux Demo',C1[3]);
WinFile3.Show  (Workscreen);



BRun .Init    (Workscreen,66,7,Blanc,Vert,'Run ');
BRun .Show    (Workscreen);
BExit.Init    (Workscreen,66,9,Blanc,Vert,'Dos ');
BExit.Show    (Workscreen);
MovECran(Ecran,WorkScreen);
Ecran:=WorkScreen;
End;


Procedure patience;
Var Win : ObjWIn;
    Buf : Type_Text_Ecran;


Begin;
Buf:=ecran;

Win.WIn4  (Buf,'Patience',25,10,55,14,Blanc,Rouge,Vert);
Win.Write (Buf,26,12,Blanc,Vert,' Veuillez patienter pendant');
Win.Write (Buf,26,13,Blanc,Vert,' le chargement du programme');

ecran:=buf;

End;

Procedure Run;
Var f : word;
Begin;

Patience;
SwapVectors;

   WinFile1.Cls(7);
   ChDir(Va_Dir[NoProg]);
   Exec(execute[NoProg],'');
   For f:=1 to 40000 do ;

SwapVectors;
noprog:=1;
Text.TextMode;
WinHelp.Erase_Curseur;
fenetres;
Mousse.init;
Mousse.Show;
End;


Procedure Test;
Var noDisk : Word;
    f1,f2  : byte;
    Inter  : Byte;
    Inter1 : Byte;
    Inter2 : Byte;
    Inter3 : Byte;

Begin;
Repeat;

Repeat;

StateRun :=BRun.State;
StateExit:=BExit.State;
Inter1:=Winfile1.State;
Inter2:=Winfile2.State;
Inter3:=Winfile3.State;

if inter>0 then NoProg:=Inter;


Until (StateRun=alume) or (StateExit=alume);
If (StateRun=alume) Then Run;
Until (StateExit=alume);
WinHelp.Clear_Buffer (WorkScreen,Noir);
WinHelp.Cls (0);
WinHelp.GotoXY(1,1);
For f1:=1 to 80 do for f2:=1 to 24 do Ecran[f2,f1,couleur]:=7;
Text.TextMode;
Halt(1);
End;



Begin;
Mousse.Show;
WinHelp.Erase_Curseur;
noprog:=1;
Fenetres;
Fenetres;
test;
End.