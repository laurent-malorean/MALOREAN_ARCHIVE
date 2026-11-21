{$M 1024,0,1260}

Uses CScreen,Dos,Mouse,Cgraph,Crt;

Type Tf = ARRAY [1..20] Of String [20];


     T1 = Array [1..3] Of TypeContenuWinAuto;

     T2 = RECORD
          Entete  : String [20];
          Name    : TypeContenuWinAuto;
          Command : Array [1..15] Of String [35];
          Work    : Array [1..15] Of String [20];
          END;

     T3 = ARRAY [1..3] Of T2;



Var
     Mousse  : ObjMouse;

     WinFond : ObjWin;
     Winhelp : ObjWin;

     WinFile1: ObjWinAuto;
     WinFile2: ObjWinAuto;
     WinFile3: ObjWinAuto;


     BRun    : ObjButton;
     BExit   : ObjButton;
     BWIN3   : ObjButton;

     StateRun  :  TState;
     StateExit :  TState;
     StateWin3 :  TState;

     NoProg    :  Byte;
     NoWin     :  Byte;

     Text      :  TGraphVga;

     Lanceur   : T3;

PROCEDURE init;
begin;
Lanceur[1].Name[1]:=('TURBO PASCAL');
Lanceur[1].Name[2]:=('TPX');
Lanceur[1].Name[3]:=('FRACTINT 17.0');
Lanceur[1].Name[4]:=('DELUXE PAINT II');
Lanceur[1].Name[5]:=('GALLERY');
Lanceur[1].Name[6]:=('A ANIMATOR');
Lanceur[1].Name[7]:=('G.W.S');
Lanceur[1].Name[8]:=('');
Lanceur[1].Name[9]:=('');
Lanceur[1].Name[10]:=('');
Lanceur[1].Name[11]:=('');
Lanceur[1].Name[12]:=('');
Lanceur[1].Name[13]:=('');
Lanceur[1].Name[14]:=('');
Lanceur[1].Name[15]:=('');
Lanceur[1].Name[16]:=('');
Lanceur[1].Name[17]:=('');
Lanceur[1].Name[18]:=('');
Lanceur[1].Name[19]:=('');
Lanceur[1].Name[20]:=('');
Lanceur[1].Name[21]:=('');
Lanceur[1].Name[22]:=('');

Lanceur[2].Name[1]:=('PCSHELL');
Lanceur[2].Name[2]:=('COPYX');
Lanceur[2].Name[3]:=('DM');
Lanceur[2].Name[4]:=('SPEED DISK');
Lanceur[2].Name[5]:=('DISKFIX');
Lanceur[2].Name[6]:=('DISKTOOL');
Lanceur[2].Name[7]:=('NDD');
Lanceur[2].Name[8]:=('');
Lanceur[2].Name[9]:=('');
Lanceur[2].Name[10]:=('');
Lanceur[2].Name[11]:=('');
Lanceur[2].Name[12]:=('');
Lanceur[2].Name[13]:=('');
Lanceur[2].Name[14]:=('');
Lanceur[2].Name[15]:=('');
Lanceur[2].Name[16]:=('');
Lanceur[2].Name[17]:=('');
Lanceur[2].Name[18]:=('');
Lanceur[2].Name[19]:=('');
Lanceur[2].Name[20]:=('');
Lanceur[2].Name[21]:=('');
Lanceur[2].Name[22]:=('');

Lanceur[3].Name[1]:=('TURBO PASCAL');
Lanceur[3].Name[2]:=('DELUXE PAINT');
Lanceur[3].Name[3]:=('FRACTINT');
Lanceur[3].Name[4]:=('PIZZA+');
Lanceur[3].Name[5]:=('PCSHELL');
Lanceur[3].Name[6]:=('');
Lanceur[3].Name[7]:=('');
Lanceur[3].Name[8]:=('');
Lanceur[3].Name[9]:=('');
Lanceur[3].Name[10]:=('');
Lanceur[3].Name[11]:=('');
Lanceur[3].Name[12]:=('');
Lanceur[3].Name[13]:=('');
Lanceur[3].Name[14]:=('');
Lanceur[3].Name[15]:=('');
Lanceur[3].Name[16]:=('');
Lanceur[3].Name[17]:=('');
Lanceur[3].Name[18]:=('');
Lanceur[3].Name[19]:=('');
Lanceur[3].Name[20]:=('');
Lanceur[3].Name[21]:=('');
Lanceur[3].Name[22]:=('');


Lanceur[1].Command[1]:=('c:\tp\turbo.exe');
Lanceur[1].Command[2]:=('c:\tp\tpx.exe');
Lanceur[1].Command[3]:=('c:\ecran\frac17\fractint.exe');
Lanceur[1].Command[4]:=('c:\dpii\dpii.exe');
Lanceur[1].Command[5]:=('c:\dpii\gallery.exe');
Lanceur[1].Command[6]:=('c:\ecran\aa\aa.exe');
Lanceur[1].Command[7]:=('c:\ecran\gws\gws.exe');
Lanceur[1].Command[8]:=('');
Lanceur[1].Command[9]:=('');
Lanceur[1].Command[10]:=('');
Lanceur[1].Command[11]:=('');
Lanceur[1].Command[12]:=('');
Lanceur[1].Command[13]:=('');
Lanceur[1].Command[14]:=('');
Lanceur[1].Command[15]:=('');

Lanceur[2].Command[1]:=('c:\PCTOOLS\Pcshell.exe');
Lanceur[2].Command[2]:=('c:\copieur\copyx.exe');
Lanceur[2].Command[3]:=('c:\pctools\dm.exe');
Lanceur[2].Command[4]:=('c:\pctools\sd.exe');
Lanceur[2].Command[5]:=('c:\pctools\diskfix.exe');
Lanceur[2].Command[6]:=('c:\pctools\disktools.exe');
Lanceur[2].Command[7]:=('c:\pctools\ndd.exe');
Lanceur[2].Command[8]:=('');
Lanceur[2].Command[9]:=('');



end;

Procedure Fenetres;
Begin;
WinFond.Fond_Ecran (WorkScreen,Blanc,Bleu);
WinFond.WIn4  (WorkScreen,'MALOREAN EFFECT : Groupe de demo',3,2,77,22,Blanc,Bleu,Magenta);
WinFile1.Init  (6,4,15,Blanc,Bleu,Noir,Blanc,'Applications',Lanceur[1].Name);
WinFile1.Show  (Workscreen);
WinFile2.Init  (26,4,15,Blanc,Bleu,Noir,Blanc,'Utilitaires',Lanceur[2].Name);
WinFile2.Show  (Workscreen);
WinFile3.Init  (46,4,15,Blanc,Bleu,Noir,Blanc,'Jeux Demo',Lanceur[3].Name);
WinFile3.Show  (Workscreen);

BRun .Init    (Workscreen,65,5,Blanc,Vert,'Run ');
BRun .Show    (Workscreen);
BExit.Init    (Workscreen,65,7,Blanc,Vert,'Dos ');
BExit.Show    (Workscreen);
BWin3.Init    (Workscreen,65,9,Blanc,Vert,'WIN 3.1 ');
BWin3.Show    (Workscreen);

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

PROCEDURE RUNWIN3;
VAR       f : Word;
BEGIN;

Patience;
SwapVectors;

   ChDir('c:\windows');
   Exec('c:\windows\win.com','');
   For f:=1 to 40000 do ;

SwapVectors;
noprog:=1;
Text.TextMode;
WinHelp.Erase_Curseur;
fenetres;
Mousse.init;
Mousse.Show;


END;



Procedure Run;
Var f : word;
Begin;



Patience;
SwapVectors;

   ChDir(Lanceur[NoWin].Work[NoProg]);
   Exec(Lanceur[NoWin].Command[NoProg],'');
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
    Inter  : Array [1..3] Of Byte;

Begin;
Repeat;

Repeat;

StateRun :=BRun.State;
StateExit:=BExit.State;
StateWin3:=BWin3.State;

Inter[1]:=Winfile1.State;
Inter[2]:=Winfile2.State;
Inter[3]:=Winfile3.State;

For f1:=1 to 3 do if inter[f1]>0 then Begin;
                                      NoProg:=Inter[f1];
                                      NoWin:=F1;
                                      end;

Until (StateRun=alume) or (StateExit=alume) or (stateWin3=alume);

If (StateRun=alume) Then Run;
If stateWin3=alume Then RunWIn3;
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
init;
Fenetres;
Fenetres;
test;
End.