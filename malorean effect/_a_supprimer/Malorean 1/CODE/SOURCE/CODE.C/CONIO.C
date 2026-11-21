CONIO.H
ÍÍÍÍÍÍÍ

Fonctions
ÄÄÄÄÄÄÄÄÄ
cgets              clreol             clrscr             cprintf
cputs              cscanf             delline            getch
getche             getpass            gettext            gettextinfo
gotoxy             highvideo          insline            kbhit
lowvideo           movetext           normvideo          putch
puttext            _setcursortype     textattr           textbackground
textcolor          textmode           ungetch            wherex
wherey             window


Constantes, types et variables globales
ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
BLINK           COLORS          directvideo     text_info
text_modes

Voir aussi
ÄÄÄÄÄÄÄÄÄÄ
liste des fichiers d'entˆte





*****************************************************************************
ÛŞ cgets

Lit une chaŒne depuis le clavier.

  char *cgets(char *str);

Prototype dans  conio.h

str[0] doit contenir la longueur maximale de la chaŒne … lire. Au retour,
str[1] contient le nombre de caractŠres r‚ellement lus. La chaŒne lue d‚bute
donc par str[2]. La fonction renvoie &str[2].

Voir aussi

  cputs    getch     gets
  fgets    getche

 #include <stdio.h>
 #include <conio.h>

 int main(void)
 {
    char buffer[83];
    char *p;

    /* Il y a de la place pour 80 caractŠre, le dernier est NULL */
    buffer[0] = 81;

    printf("Saisissez des caractŠres:");
    p = cgets(buffer);
    printf("\ncgets … lu %d caractŠres: \"%s\"\n", buffer[1], p);
    printf("Le pointeur renvoy‚ est %p, buffer[0] est … l'adresse %p\n",
           p, &buffer);

    /* LibŠre de la place pour 5 caractŠres plus NULL */
    buffer[0] = 6;

    printf("Saisissez des caractŠres:");
    p = cgets(buffer);
    printf("\ncgets … lu %d caractŠres: \"%s\"\n", buffer[1], p);
    printf("Le pointeur renvoy‚ est %p, buffer[0] est … l'adresse %p\n",
           p, &buffer);
    return 0;
 }
*****************************************************************************
ÛŞ clreol

Efface la fin de la ligne dans la fenˆtre texte.

  void clreol(void);

Prototype dans  conio.h

Voir aussi

  clrscr    delline    window

 #include <conio.h>

 int main(void)

 {
    clrscr();
    cprintf("La fonction CLREOL efface tous les caractŠres depuis la\r\n");
    cprintf("position du curseur jusqu'… la fin de la ligne … l'interieur\r\n");
    cprintf("de la fenˆtre texte, sans d‚placer le curseur.\r\n");
    cprintf("Frappez une touche pour continuer. . .");
    gotoxy(14, 4);
    getch();

    clreol();
    getch();

    return 0;
 }

*****************************************************************************
ÛŞ clrscr

Efface la fenˆtre texte.

  void clrscr(void);

Prototype dans  conio.h

Voir aussi

  clreol    delline    window

 #include <conio.h>

 int main(void)
 {
    int i;

    clrscr();
    for (i = 0; i < 20; i++)
       cprintf("%d\r\n", i);
    cprintf("\r\nFrappez une touche pour effacer l'‚cran");
    getch();

    clrscr();
    cprintf("L'‚cran a ‚t‚ ‚ffac‚!");
    getch();

    return 0;
 }

*****************************************************************************
ÛŞ cprintf

Affiche des donn‚es format‚es dans la fenˆtre texte courante.

  int cprintf(const char *format[,
              argument,...]);

Prototype dans  conio.h

Renvoie le nombre d'octets affich‚s.

Voir aussi

  directvideo    printf    sprintf
  fprintf        putch     vprintf

 #include <conio.h>

 int main(void)
 {
    /* efface l'‚cran */
    clrscr();

    /* cr‚ation d'une fenˆtre texte */
    window(10, 10, 80, 25);

    /* affiche un texte dans la fenˆtre */
    cprintf("Salut tout le monde\r\n");

    /* pause clavier */
    getch();
    return 0;
 }


*****************************************************************************
ÛŞ cputs

Affiche une chaŒne dans la fenˆtre texte courante.

  int cputs(const char *str);

Prototype dans  conio.h

Renvoie le dernier caractŠre affich‚.

Voir aussi

  cgets          fputs    puts
  directvideo    putch

 #include <conio.h>

 int main(void)
 {
    /* ‚fface ‚cran */
    clrscr();

    /* cr‚ation d'une fenˆtre texte */
    window(10, 10, 80, 25);

    /* affiche un texte dans la fenˆtre */
    cputs("Je suis … l'int‚rieur de la fenˆtre\r\n");

    /* pause clavier */
    getch();
    return 0;
 }

*****************************************************************************
ÛŞ cscanf

Effectue des entr‚es format‚es depuis le clavier.

  int cscanf(char *format [ , address, ... ]);

Prototype dans  conio.h

Renvoie le nombre de champs d'entr‚e correctement lus. Si une fonction tente
de lire … la fin d'un fichier, la valeur renvoy‚e sera EOF.

Voir aussi

  fscanf    getche    scanf    sscanf

 #include <conio.h>

 int main(void)
 {
    char string[80];

    /* ‚fface ‚cran */
    clrscr();

    /* Demande … l'utilisateur d'‚ffectuer une entr‚e */
    cprintf("Entrez une chaŒne sans espace:");

    /* lit la chaŒne entr‚e */
    cscanf("%s", string);

    /* affiche ce qui a ‚t‚ lu */
    cprintf("\r\nLa chaŒne entr‚e est: %s", string);
    return 0;
 }


*****************************************************************************
ÛŞ delline

Efface une ligne dans la fenˆtre texte.

  void delline(void);

Prototype dans  conio.h

Voir aussi

  clreol    clrscr    insline    window

 #include <conio.h>

 int main(void)
 {
    clrscr();
    cprintf("La fonction DELLINE efface \
            la ligne contenant le curseur\r\n");
    cprintf("et toutes les lignes suivantes sont\
            d‚cal‚es d'une position vers le haut.\r\n");
    cprintf("La port‚e de DELLINE est limit‚e … \
            la fenˆtre texte courante.\r\n");
    cprintf("Frappez une touche pour continuer . . .");
    gotoxy(1,2);  /* d‚place le curseur … la
                     seconde ligne, premiŠre colonne */
    getch();

    delline();
    getch();

    return 0;
 }

*****************************************************************************
ÛŞ getch/getche

Renvoie un caractŠre lu au clavier, sans/avec ‚cho … l'‚cran.

  int getch(void);
  int getche(void);
Prototype dans  conio.h

Les deux fonctions renvoient le caractŠre lu. Les caractŠres peuvent ˆtre
trait‚s directe- ment. L'entr‚e n'est pas m‚moris‚e dans une m‚moire tampon.

Les touches sp‚ciales, touches de fonctions et de d‚placement sont
repr‚sent‚es par une s‚quence de deux caractŠres: le caractŠre 0, suivi du
code g‚ographique de la touche frapp‚e.

Voir aussi

  cgets    getpass    getchar
  fgetc    putch      kbhit
  getc     cscanf     ungetch


 #include <stdio.h>
 #include <conio.h>

 int main(void)
 {
    char ch;

    printf("Frappez une touche:");
    ch = getche();
    printf("\nVous avez entr‚ un '%c'\n", ch);
    return 0;
 }

*****************************************************************************
ÛŞ getpass

Lit un mot de passe au clavier.

  char *getpass(const char *prompt);
Prototype dans  conio.h

Renvoie un pointeur sur la chaŒne contenant le mot de passe, c'est la mˆme
chaŒne statique qui est utilis‚e … chaque appel.

Voir aussi

  getch

 #include <conio.h>

 int main(void)
 {
    char *password;

    password = getpass("Entrez un mot de passe:");
    cprintf("Le mot de passe est: %s\r\n",
            password);
    return 0;
 }


*****************************************************************************
ÛŞ gettext

Sauvegarde dans une m‚moire tampon du texte provenant de l'‚cran en mode
texte.

  int gettext(int left, int top, int right,
              int bottom, void *destin);
Prototype dans  conio.h

Les coordonn‚es sont absolues et non pas relatives … la fenˆtre, (1,1)
repr‚sente toujours le coin sup‚rieur gauche de l'‚cran (et non celui d'une
fenˆtre). Si l'op‚ration aboutit, gettext renvoie non z‚ro.

Voir aussi

  movetext    puttext

 #include <conio.h>

 char buffer[4096];

 int main(void)
 {
    int i;

    clrscr();
    for (i = 0; i <= 20; i++)
       cprintf("Ligne #%d\r\n", i);
    gettext(1, 1, 80, 25, buffer);

    gotoxy(1, 25);
    cprintf("Frappez une touche pour effacer l'‚cran...");
    getch();
    clrscr();
    gotoxy(1, 25);
    cprintf("Frappez une touche pour restituer l'‚cran...");
    getch();
    puttext(1, 1, 80, 25, buffer);
    gotoxy(1, 25);
    cprintf("Frappez une touche pour quitter...");
    getch();

    return 0;
 }

*****************************************************************************
ÛŞ gettextinfo

Donne des informations sur le mode texte courant.

  void gettextinfo(struct text_info *r);
Prototype dans  conio.h

Les r‚sultats sont plac‚s dans la structure point‚e par r.

Voir aussi

  textattr          textmode    wherey
  textbackground    wherex      window
  textcolor

 #include <conio.h>

 char buffer[4096];

 int main(void)
 {
    int i;

    clrscr();
    for (i = 0; i <= 20; i++)
       cprintf("Ligne #%d\r\n", i);

    gettext(1, 1, 80, 25, buffer);

    gotoxy(1, 25);
    cprintf("Frappez une touche pour effacer l'‚cran...");
    getch();
    clrscr();
    gotoxy(1, 25);
    cprintf("Frappez une touche pour restituer l'‚cran...");
    getch();

    puttext(1, 1, 80, 25, buffer);
    gotoxy(1, 25);
    cprintf("Frappez une touche pour quitter...");
    getch();

    return 0;
 }

*****************************************************************************
ÛŞ gotoxy

Positionne le curseur dans la fenˆtre texte.

  void gotoxy(int x, int y);
Prototype dans  conio.h

Voir aussi

  wherex    wherey    window

 #include <conio.h>

 int main(void)
 {
    clrscr();
    gotoxy(35, 12);
    cprintf("Salut tout le monde");
    getch();
    return 0;
 }

*****************************************************************************
ÛŞ highvideo

S‚lectionne l'affichage des caractŠres en sur-intensit‚.

  void highvideo(void);
Prototype dans  conio.h

Affecte cons‚quemment … son appel les caractŠres affich‚s par une fonction
d'affichage ‚cran (par exemple cprintf) en mode texte.

Voir aussi

  cprintf        lowvideo     textattr
  cputs          normvideo    textcolor
  gettextinfo

 #include <conio.h>

 int main(void)
 {
    clrscr();

    lowvideo();
    cprintf("Texte en basse intensit‚\r\n");
    highvideo();
    gotoxy(1,2);
    cprintf("Texte en haute intensit‚\r\n");

    return 0;
 }

*****************************************************************************
ÛŞ insline

InsŠre une ligne vide dans la fenˆtre texte.

  void insline(void);
Prototype dans  conio.h

Toutes les lignes plac‚es sous la ligne ins‚r‚e sont d‚cal‚es d'une ligne
vers le bas et la derniŠre ligne est effac‚e de l'‚cran.

Voir aussi

  clreol    delline    window

 #include <conio.h>

 int main(void)
 {
    clrscr();
    cprintf("INSLINE insŠre une ligne vide dans la fenˆtre texte\r\n");
    cprintf("depuis la position du curseur en utilisant la couleur\r\n");
    cprintf("du fond.  Toutes les lignes plac‚es sous la ligne ins‚r‚e\r\n");
    cprintf("sont d‚cal‚es d'une ligne vers le bas et la derniŠre ligne\r\n");
    cprintf("est effac‚e de l'‚cran.\r\n");
    cprintf("\r\nFrappez une touche pour continuer:");
    gotoxy(1, 3);
    getch();
    insline();
    getch();
    return 0;
 }

*****************************************************************************
ÛŞ kbhit

Teste une eventuelle frappe au clavier.

  int kbhit(void);
Prototype dans  conio.h

Teste si un caractŠre est disponible … la suite d'une frappe au clavier. Si
c'est le cas, kbhit renvoie un entier non nul, sinon elle renvoie 0.

Voir aussi

  getch    getche

 #include <conio.h>

 int main(void)
 {
    cprintf("Frappez une touche pour continuer:");
    while (!kbhit()) /* attente d'une frappe */ ;
    cprintf("\r\nUne touche … ‚t‚ frapp‚e...\r\n");
    return 0;
 }

*****************************************************************************
ÛŞ lowvideo

S‚lectionne l'affichage des caractŠre en sous-intensit‚.

  void lowvideo(void);
Prototype dans  conio.h

lowvideo N'a d'effet que sur les caractŠres, qui aprŠs son appel, sont
affich‚s par une primitive d'affichage ‚cran (par exemple cprintf) en mode
texte

Voir aussi

  highvideo   normvideo   textattr   textcolor

 #include <conio.h>

 int main(void)
 {
    clrscr();

    highvideo();
    cprintf("Texte en haute intensit‚\r\n");
    lowvideo();
    gotoxy(1,2);
    cprintf("Texte en basse intensit‚\r\n");

    return 0;
 }

*****************************************************************************
ÛŞ movetext

Recopie une zone rectangulaire de texte d'un emplacement de l'‚cran vers un
autre.

  int movetext(int gauche, int haut, int droit,
               int bas, int dest_gauche,
               int dest_haut);

Prototype  :  conio.h

Coordonn‚es relatives au coin sup‚rieur gauche de l'‚cran (1,1).

En cas de succŠs, renvoie une valeur non nullle.

Voir aussi

  gettext    puttext

 #include <conio.h>
 #include <string.h>

 int main(void)
 {
    char *str = "Une chaŒne test";

    clrscr();
    cputs(str);
    getch();

    movetext(1, 1, strlen(str), 2, 10, 10);
    getch();

    return 0;
 }

*****************************************************************************
ÛŞ normvideo

Restaure l'attribut vid‚o courant lors du lancement du programme (en mode
texte).

  void normvideo(void);

Prototype  :  conio.h

N'affecte que les affichages post‚rieurs dans la fenˆtre texte (par des
fonctions telles que putch ou cprintf).

Voir aussi

  highvideo   lowvideo   textattr   textcolor

 #include <conio.h>

 int main(void)
 {
    normvideo();
    cprintf("Texte en affichage NORMAL\r\n");
    return 0;
 }

*****************************************************************************
ÛŞ putch

Ecrit un caractŠre dans la fenˆtre courante de l'‚cran.

  int putch(int c);

Prototype  :  conio.h

Utilise la couleur courante.

SuccŠs : renvoie c, le caractŠre affich‚ Echec  : renvoie EOF

Voir aussi

  cprintf    getch     putc
  cputs      getche    putchar

 #include <stdio.h>
 #include <conio.h>

 int main(void)
 {
    char ch = 0;

    printf("Saisissez une chaŒne :");
    while ((ch != '\r'))
    {
       ch = getch();
       putch(ch);
    }
    return 0;
 }

*****************************************************************************
ÛŞ puttext

Copie le texte contenu dans une zone en m‚moire sur l'‚cran texte.

  int puttext(int gauche, int haut, int droit,
              int bas, void *source);

Prototype  :  conio.h

Les coordonn‚es sont absolues et non pas relatives … la fenˆtre. Le coin
sup‚rieur gauche est en (1,1).

SuccŠs : renvoie une valeur diff‚rente de z‚ro.

Voir aussi

  gettext    movetext    window

 #include <conio.h>

 int main(void)
 {
    char buffer[512];

    /* ‚crit quelque chose … l'‚cran */
    clrscr();
    gotoxy(20, 12);
    cprintf("Ceci est un essai.   Frappez unetouche pour continuer...");
    getch();

    /* m‚morise le contenu de l'‚cran */
    gettext(20, 12, 36, 21,buffer);
    clrscr();

    /* r‚affiche le contenu de l'‚cran qui a ‚t‚m‚moris‚ */
    gotoxy(20, 12);
    puttext(20, 12, 36, 21, buffer);
    getch();

    return 0;
 }

*****************************************************************************
ÛŞ _setcursortype

S‚lectionne une forme de curseur.

  void _setcursortype(int curseur);

Prototype  :  conio.h

Le curseur peut ˆtre : _NOCURSOR      Pas de curseur _SOLIDCURSOR   Curseur
rectangle plein _NORMALCURSOR  Curseur normal, signe de soulignement


  #include <conio.h>

 int main(void)
 {
    /* Affiche le curseur normal */
    cprintf("\n\rCurseur normal : ");
    getch();

    /* Supprime le curseur */
    _setcursortype(_NOCURSOR);
    cprintf("\n\rPas de Curseur : ");
    getch();

    /* S‚lectionne le curseur plein */
    _setcursortype(_SOLIDCURSOR);
    cprintf("\n\rCurseur Plein  : ");
    getch();

    /* S‚lectionne de nouveau le curseur normal */
    _setcursortype(_NORMALCURSOR);
    cprintf("\n\rCurseur Normal : ");
    getch();

    return 0;
 }
*****************************************************************************
ÛŞ textattr

S‚lectionne l'attribut du texte.

  void textattr(int newattr);

Prototype :    conio.h

Voir aussi

  gettextinfo    lowvideo     textbackground
  highvideo      normvideo    textcolor

 #include <conio.h>

 int main(void)
 {
    int i;

    clrscr();
    for (i=0; i<9; i++)
    {
        textattr(i + ((i+1) << 4));
        cprintf("Ceci est un test\r\n");
    }

    return 0;
 }
*****************************************************************************
ÛŞ textbackground

S‚lectionne la couleur d'affichage du fond en mode texte.

  void textbackground(int newcolor);

Prototype :    conio.h

Voir aussi

  gettextinfo    textattr    textcolor

 #include <conio.h>

 int main(void)
 {
    int i, j;

    clrscr();
    for (i=0; i<9; i++)
    {
        for (j=0; j<80; j++)
          cprintf("C");
        cprintf("\r\n");
        textcolor(i+1);
        textbackground(i);
    }

    return 0;
 }

*****************************************************************************
ÛŞ textcolor

S‚lectionne la couleur d'affichage des caractŠres en mode texte.

  void textcolor(int newcolor);

Prototype :    conio.h

Voir aussi

  gettextinfo    lowvideo     textattr
  highvideo      normvideo    textbackground

 #include <conio.h>

 int main(void)
 {
    int i;

    for (i=0; i<15; i++)
    {
        textcolor(i);
        cprintf("Couleur du premier plan\r\n");
    }

    return 0;
 }

*****************************************************************************
ÛŞ textmode

S‚lectionne un mode texte sp‚cifique.

  void textmode(int newmode);

Prototype :    conio.h

Ne doit ˆtre utilis‚e que lorsque l'‚cran est en mode texte (pour passer
d'un mode texte … un autre).

Voir aussi

  gettextinfo    window

 #include <conio.h>

 int main(void)
 {
    textmode(BW40);
    cprintf("ABC");
    getch();

    textmode(C40);
    cprintf("ABC");
    getch();

    textmode(BW80);
    cprintf("ABC");
    getch();

    textmode(C80);
    cprintf("ABC");
    getch();

    textmode(MONO);
    cprintf("ABC");
    getch();

    return 0;
 }

*****************************************************************************
ÛŞ ungetch

Replace un caractŠre dans le tampon du clavier.

  int ungetch(int c);

Prototype :    conio.h

ungetch replace le caractŠre c dans le tampon du clavier, de telle sorte
qu'il soit le prochain caractŠre lu .

SuccŠs : renvoie le caractŠre c Echec  : renvoie EOF

Voir aussi

  getch    getche

 #include <stdio.h>
 #include <ctype.h>
 #include <conio.h>

 int main( void )
 {
    int i=0;
    char ch;

    puts("Entrez un entier suivi d'un caractŠre:");

    /* lit des caractŠres jusqu'… un non chiffre ou EOF */
    while((ch = getche()) != EOF && isdigit(ch))
       i = 10 * i + ch - 48; /* convertit la valeur ASCII en d‚cimale */

    /* Si le caractŠre lu est un non chiffre, le replace dans
       le tampon d'entr‚e */
    if (ch != EOF)
       ungetch(ch);

    printf("\n\ni = %d, prochain caractŠre dans le tampon = %c\n", i, getch());
    return 0;
 }

*****************************************************************************
ÛŞ wherex

Renvoie l'abcisse de la position courante du curseur dans la fenˆtre texte
courante.

  int wherex(void);

Prototype :    conio.h

Renvoie un entier compris entre 1 et 80.

Voir aussi

  gettextinfo    gotoxy    wherey


 #include <conio.h>

 int main(void)
 {
    clrscr();
    gotoxy(10,10);
    cprintf("Emplacement actuel X : %d  Y : %d\r\n", wherex(), wherey());
    getch();

    return 0;
 }

*****************************************************************************
ÛŞ wherey

Renvoie l'ordonn‚e de la position courante du curseur dans la fenˆtre texte
courante.

  int wherey(void);

Prototype :    conio.h

Renvoie un entier compris entre 1 et 25.

Voir aussi

  gettextinfo    gotoxy    wherex

 #include <conio.h>

 int main(void)
 {
    clrscr();
    gotoxy(10,10);
    cprintf("Emplacement actuel X : %d  Y : %d\r\n", wherex(), wherey());
    getch();

    return 0;
 }

*****************************************************************************
ÛŞ window

D‚finit une fenˆtre d'affichage en mode texte.

  void window(int gauche, int haut,
              int droit,  int bas);

Le coin sup‚rieur gauche de l'‚cran est en (1,1).

Prototype :    conio.h

Voir aussi

  clreol    delline        gotoxy     puttext
  clrscr    gettextinfo    insline    textmode

 #include <conio.h>

 int main(void)
 {

    window(10,10,40,11);
    textcolor(BLACK);
    textbackground(WHITE);
    cprintf("Ceci est un test\r\n");

    return 0;
 }


Constantes, types et variables globales
ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

*****************************************************************************
COLORS (type ‚num‚r‚)

Couleurs et attributs standards CGA

  BLACK        DARKGRAY
  BLUE         LIGHTBLUE
  GREEN        LIGHTGREEN
  CYAN         LIGHTCYAN
  RED          LIGHTRED
  MAGENTA      LIGHTMAGENTA
  BROWN        YELLOW
  LIGHTGRAY    WHITE

D‚finition dans  conio.h
            graphics.h

BLINK: A ajouter … la couleur de caractŠre pour faire clignoter les
caractŠres (en mode texte).

D‚finition dans  conio.h

*****************************************************************************
 directvideo (variable globale)
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

Contr“le le mode de gestion des affichages.

  int directvideo

D‚finie dans  conio.h

directvideo permet de choisir entre ‚criture directe des affichages dans la
zone m‚moire de l'‚cran vid‚o ou l'appel des routines du ROM BIOS
(directvideo = 0).

La valmeur implicite est directvideo = 1 (‚criture en m‚moire vid‚o).

Dans ce mode d'affichage rapide, l'adaptateur vid‚o doit ˆtre trŠs
compatible.

Avec directvideo = 0, vous pouvez utiliser un systŠme moins compatible, du
moment qu'il le soit au niveau du BIOS.

Voir aussi:

  liste des variables globales

*****************************************************************************
 text_info (structure)
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

Informations au sujet de la fenˆtre texte active.

  struct text_info {
    unsigned char  winleft,   wintop;
    unsigned char  winright,  winbottom;
    unsigned char  attribute, normattr;
    unsigned char  currmode;
    unsigned char  screenheight;
    unsigned char  screenwidth;
    unsigned char  curx, cury;
  };

D‚fini dans  conio.h

Voir aussi

  gettextinfo

*****************************************************************************
text_modes (type ‚num‚r‚)

Modes texte standards

  LASTMODE    BW80
  BW40        C80
  C40         C4350
  MONO

D‚finition dans  conio.h







