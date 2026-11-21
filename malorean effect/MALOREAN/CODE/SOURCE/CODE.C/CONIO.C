CONIO.H
═══════

Fonctions
─────────
cgets              clreol             clrscr             cprintf
cputs              cscanf             delline            getch
getche             getpass            gettext            gettextinfo
gotoxy             highvideo          insline            kbhit
lowvideo           movetext           normvideo          putch
puttext            _setcursortype     textattr           textbackground
textcolor          textmode           ungetch            wherex
wherey             window


Constantes, types et variables globales
───────────────────────────────────────
BLINK           COLORS          directvideo     text_info
text_modes

Voir aussi
──────────
liste des fichiers d'entête





*****************************************************************************
█▐ cgets

Lit une chaîne depuis le clavier.

  char *cgets(char *str);

Prototype dans  conio.h

str[0] doit contenir la longueur maximale de la chaîne à lire. Au retour,
str[1] contient le nombre de caractères réellement lus. La chaîne lue débute
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

    /* Il y a de la place pour 80 caractère, le dernier est NULL */
    buffer[0] = 81;

    printf("Saisissez des caractères:");
    p = cgets(buffer);
    printf("\ncgets à lu %d caractères: \"%s\"\n", buffer[1], p);
    printf("Le pointeur renvoyé est %p, buffer[0] est à l'adresse %p\n",
           p, &buffer);

    /* Libère de la place pour 5 caractères plus NULL */
    buffer[0] = 6;

    printf("Saisissez des caractères:");
    p = cgets(buffer);
    printf("\ncgets à lu %d caractères: \"%s\"\n", buffer[1], p);
    printf("Le pointeur renvoyé est %p, buffer[0] est à l'adresse %p\n",
           p, &buffer);
    return 0;
 }
*****************************************************************************
█▐ clreol

Efface la fin de la ligne dans la fenêtre texte.

  void clreol(void);

Prototype dans  conio.h

Voir aussi

  clrscr    delline    window

 #include <conio.h>

 int main(void)

 {
    clrscr();
    cprintf("La fonction CLREOL efface tous les caractères depuis la\r\n");
    cprintf("position du curseur jusqu'à la fin de la ligne à l'interieur\r\n");
    cprintf("de la fenêtre texte, sans déplacer le curseur.\r\n");
    cprintf("Frappez une touche pour continuer. . .");
    gotoxy(14, 4);
    getch();

    clreol();
    getch();

    return 0;
 }

*****************************************************************************
█▐ clrscr

Efface la fenêtre texte.

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
    cprintf("\r\nFrappez une touche pour effacer l'écran");
    getch();

    clrscr();
    cprintf("L'écran a été éffacé!");
    getch();

    return 0;
 }

*****************************************************************************
█▐ cprintf

Affiche des données formatées dans la fenêtre texte courante.

  int cprintf(const char *format[,
              argument,...]);

Prototype dans  conio.h

Renvoie le nombre d'octets affichés.

Voir aussi

  directvideo    printf    sprintf
  fprintf        putch     vprintf

 #include <conio.h>

 int main(void)
 {
    /* efface l'écran */
    clrscr();

    /* création d'une fenêtre texte */
    window(10, 10, 80, 25);

    /* affiche un texte dans la fenêtre */
    cprintf("Salut tout le monde\r\n");

    /* pause clavier */
    getch();
    return 0;
 }


*****************************************************************************
█▐ cputs

Affiche une chaîne dans la fenêtre texte courante.

  int cputs(const char *str);

Prototype dans  conio.h

Renvoie le dernier caractère affiché.

Voir aussi

  cgets          fputs    puts
  directvideo    putch

 #include <conio.h>

 int main(void)
 {
    /* éfface écran */
    clrscr();

    /* création d'une fenêtre texte */
    window(10, 10, 80, 25);

    /* affiche un texte dans la fenêtre */
    cputs("Je suis à l'intérieur de la fenêtre\r\n");

    /* pause clavier */
    getch();
    return 0;
 }

*****************************************************************************
█▐ cscanf

Effectue des entrées formatées depuis le clavier.

  int cscanf(char *format [ , address, ... ]);

Prototype dans  conio.h

Renvoie le nombre de champs d'entrée correctement lus. Si une fonction tente
de lire à la fin d'un fichier, la valeur renvoyée sera EOF.

Voir aussi

  fscanf    getche    scanf    sscanf

 #include <conio.h>

 int main(void)
 {
    char string[80];

    /* éfface écran */
    clrscr();

    /* Demande à l'utilisateur d'éffectuer une entrée */
    cprintf("Entrez une chaîne sans espace:");

    /* lit la chaîne entrée */
    cscanf("%s", string);

    /* affiche ce qui a été lu */
    cprintf("\r\nLa chaîne entrée est: %s", string);
    return 0;
 }


*****************************************************************************
█▐ delline

Efface une ligne dans la fenêtre texte.

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
            décalées d'une position vers le haut.\r\n");
    cprintf("La portée de DELLINE est limitée à \
            la fenêtre texte courante.\r\n");
    cprintf("Frappez une touche pour continuer . . .");
    gotoxy(1,2);  /* déplace le curseur à la
                     seconde ligne, première colonne */
    getch();

    delline();
    getch();

    return 0;
 }

*****************************************************************************
█▐ getch/getche

Renvoie un caractère lu au clavier, sans/avec écho à l'écran.

  int getch(void);
  int getche(void);
Prototype dans  conio.h

Les deux fonctions renvoient le caractère lu. Les caractères peuvent être
traités directe- ment. L'entrée n'est pas mémorisée dans une mémoire tampon.

Les touches spéciales, touches de fonctions et de déplacement sont
représentées par une séquence de deux caractères: le caractère 0, suivi du
code géographique de la touche frappée.

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
    printf("\nVous avez entré un '%c'\n", ch);
    return 0;
 }

*****************************************************************************
█▐ getpass

Lit un mot de passe au clavier.

  char *getpass(const char *prompt);
Prototype dans  conio.h

Renvoie un pointeur sur la chaîne contenant le mot de passe, c'est la même
chaîne statique qui est utilisée à chaque appel.

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
█▐ gettext

Sauvegarde dans une mémoire tampon du texte provenant de l'écran en mode
texte.

  int gettext(int left, int top, int right,
              int bottom, void *destin);
Prototype dans  conio.h

Les coordonnées sont absolues et non pas relatives à la fenêtre, (1,1)
représente toujours le coin supérieur gauche de l'écran (et non celui d'une
fenêtre). Si l'opération aboutit, gettext renvoie non zéro.

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
    cprintf("Frappez une touche pour effacer l'écran...");
    getch();
    clrscr();
    gotoxy(1, 25);
    cprintf("Frappez une touche pour restituer l'écran...");
    getch();
    puttext(1, 1, 80, 25, buffer);
    gotoxy(1, 25);
    cprintf("Frappez une touche pour quitter...");
    getch();

    return 0;
 }

*****************************************************************************
█▐ gettextinfo

Donne des informations sur le mode texte courant.

  void gettextinfo(struct text_info *r);
Prototype dans  conio.h

Les résultats sont placés dans la structure pointée par r.

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
    cprintf("Frappez une touche pour effacer l'écran...");
    getch();
    clrscr();
    gotoxy(1, 25);
    cprintf("Frappez une touche pour restituer l'écran...");
    getch();

    puttext(1, 1, 80, 25, buffer);
    gotoxy(1, 25);
    cprintf("Frappez une touche pour quitter...");
    getch();

    return 0;
 }

*****************************************************************************
█▐ gotoxy

Positionne le curseur dans la fenêtre texte.

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
█▐ highvideo

Sélectionne l'affichage des caractères en sur-intensité.

  void highvideo(void);
Prototype dans  conio.h

Affecte conséquemment à son appel les caractères affichés par une fonction
d'affichage écran (par exemple cprintf) en mode texte.

Voir aussi

  cprintf        lowvideo     textattr
  cputs          normvideo    textcolor
  gettextinfo

 #include <conio.h>

 int main(void)
 {
    clrscr();

    lowvideo();
    cprintf("Texte en basse intensité\r\n");
    highvideo();
    gotoxy(1,2);
    cprintf("Texte en haute intensité\r\n");

    return 0;
 }

*****************************************************************************
█▐ insline

Insère une ligne vide dans la fenêtre texte.

  void insline(void);
Prototype dans  conio.h

Toutes les lignes placées sous la ligne insérée sont décalées d'une ligne
vers le bas et la dernière ligne est effacée de l'écran.

Voir aussi

  clreol    delline    window

 #include <conio.h>

 int main(void)
 {
    clrscr();
    cprintf("INSLINE insère une ligne vide dans la fenêtre texte\r\n");
    cprintf("depuis la position du curseur en utilisant la couleur\r\n");
    cprintf("du fond.  Toutes les lignes placées sous la ligne insérée\r\n");
    cprintf("sont décalées d'une ligne vers le bas et la dernière ligne\r\n");
    cprintf("est effacée de l'écran.\r\n");
    cprintf("\r\nFrappez une touche pour continuer:");
    gotoxy(1, 3);
    getch();
    insline();
    getch();
    return 0;
 }

*****************************************************************************
█▐ kbhit

Teste une eventuelle frappe au clavier.

  int kbhit(void);
Prototype dans  conio.h

Teste si un caractère est disponible à la suite d'une frappe au clavier. Si
c'est le cas, kbhit renvoie un entier non nul, sinon elle renvoie 0.

Voir aussi

  getch    getche

 #include <conio.h>

 int main(void)
 {
    cprintf("Frappez une touche pour continuer:");
    while (!kbhit()) /* attente d'une frappe */ ;
    cprintf("\r\nUne touche à été frappée...\r\n");
    return 0;
 }

*****************************************************************************
█▐ lowvideo

Sélectionne l'affichage des caractère en sous-intensité.

  void lowvideo(void);
Prototype dans  conio.h

lowvideo N'a d'effet que sur les caractères, qui après son appel, sont
affichés par une primitive d'affichage écran (par exemple cprintf) en mode
texte

Voir aussi

  highvideo   normvideo   textattr   textcolor

 #include <conio.h>

 int main(void)
 {
    clrscr();

    highvideo();
    cprintf("Texte en haute intensité\r\n");
    lowvideo();
    gotoxy(1,2);
    cprintf("Texte en basse intensité\r\n");

    return 0;
 }

*****************************************************************************
█▐ movetext

Recopie une zone rectangulaire de texte d'un emplacement de l'écran vers un
autre.

  int movetext(int gauche, int haut, int droit,
               int bas, int dest_gauche,
               int dest_haut);

Prototype  :  conio.h

Coordonnées relatives au coin supérieur gauche de l'écran (1,1).

En cas de succès, renvoie une valeur non nullle.

Voir aussi

  gettext    puttext

 #include <conio.h>
 #include <string.h>

 int main(void)
 {
    char *str = "Une chaîne test";

    clrscr();
    cputs(str);
    getch();

    movetext(1, 1, strlen(str), 2, 10, 10);
    getch();

    return 0;
 }

*****************************************************************************
█▐ normvideo

Restaure l'attribut vidéo courant lors du lancement du programme (en mode
texte).

  void normvideo(void);

Prototype  :  conio.h

N'affecte que les affichages postérieurs dans la fenêtre texte (par des
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
█▐ putch

Ecrit un caractère dans la fenêtre courante de l'écran.

  int putch(int c);

Prototype  :  conio.h

Utilise la couleur courante.

Succès : renvoie c, le caractère affiché Echec  : renvoie EOF

Voir aussi

  cprintf    getch     putc
  cputs      getche    putchar

 #include <stdio.h>
 #include <conio.h>

 int main(void)
 {
    char ch = 0;

    printf("Saisissez une chaîne :");
    while ((ch != '\r'))
    {
       ch = getch();
       putch(ch);
    }
    return 0;
 }

*****************************************************************************
█▐ puttext

Copie le texte contenu dans une zone en mémoire sur l'écran texte.

  int puttext(int gauche, int haut, int droit,
              int bas, void *source);

Prototype  :  conio.h

Les coordonnées sont absolues et non pas relatives à la fenêtre. Le coin
supérieur gauche est en (1,1).

Succès : renvoie une valeur différente de zéro.

Voir aussi

  gettext    movetext    window

 #include <conio.h>

 int main(void)
 {
    char buffer[512];

    /* écrit quelque chose à l'écran */
    clrscr();
    gotoxy(20, 12);
    cprintf("Ceci est un essai.   Frappez unetouche pour continuer...");
    getch();

    /* mémorise le contenu de l'écran */
    gettext(20, 12, 36, 21,buffer);
    clrscr();

    /* réaffiche le contenu de l'écran qui a étémémorisé */
    gotoxy(20, 12);
    puttext(20, 12, 36, 21, buffer);
    getch();

    return 0;
 }

*****************************************************************************
█▐ _setcursortype

Sélectionne une forme de curseur.

  void _setcursortype(int curseur);

Prototype  :  conio.h

Le curseur peut être : _NOCURSOR      Pas de curseur _SOLIDCURSOR   Curseur
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

    /* Sélectionne le curseur plein */
    _setcursortype(_SOLIDCURSOR);
    cprintf("\n\rCurseur Plein  : ");
    getch();

    /* Sélectionne de nouveau le curseur normal */
    _setcursortype(_NORMALCURSOR);
    cprintf("\n\rCurseur Normal : ");
    getch();

    return 0;
 }
*****************************************************************************
█▐ textattr

Sélectionne l'attribut du texte.

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
█▐ textbackground

Sélectionne la couleur d'affichage du fond en mode texte.

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
█▐ textcolor

Sélectionne la couleur d'affichage des caractères en mode texte.

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
█▐ textmode

Sélectionne un mode texte spécifique.

  void textmode(int newmode);

Prototype :    conio.h

Ne doit être utilisée que lorsque l'écran est en mode texte (pour passer
d'un mode texte à un autre).

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
█▐ ungetch

Replace un caractère dans le tampon du clavier.

  int ungetch(int c);

Prototype :    conio.h

ungetch replace le caractère c dans le tampon du clavier, de telle sorte
qu'il soit le prochain caractère lu .

Succès : renvoie le caractère c Echec  : renvoie EOF

Voir aussi

  getch    getche

 #include <stdio.h>
 #include <ctype.h>
 #include <conio.h>

 int main( void )
 {
    int i=0;
    char ch;

    puts("Entrez un entier suivi d'un caractère:");

    /* lit des caractères jusqu'à un non chiffre ou EOF */
    while((ch = getche()) != EOF && isdigit(ch))
       i = 10 * i + ch - 48; /* convertit la valeur ASCII en décimale */

    /* Si le caractère lu est un non chiffre, le replace dans
       le tampon d'entrée */
    if (ch != EOF)
       ungetch(ch);

    printf("\n\ni = %d, prochain caractère dans le tampon = %c\n", i, getch());
    return 0;
 }

*****************************************************************************
█▐ wherex

Renvoie l'abcisse de la position courante du curseur dans la fenêtre texte
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
█▐ wherey

Renvoie l'ordonnée de la position courante du curseur dans la fenêtre texte
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
█▐ window

Définit une fenêtre d'affichage en mode texte.

  void window(int gauche, int haut,
              int droit,  int bas);

Le coin supérieur gauche de l'écran est en (1,1).

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
───────────────────────────────────────

*****************************************************************************
COLORS (type énuméré)

Couleurs et attributs standards CGA

  BLACK        DARKGRAY
  BLUE         LIGHTBLUE
  GREEN        LIGHTGREEN
  CYAN         LIGHTCYAN
  RED          LIGHTRED
  MAGENTA      LIGHTMAGENTA
  BROWN        YELLOW
  LIGHTGRAY    WHITE

Définition dans  conio.h
            graphics.h

BLINK: A ajouter à la couleur de caractère pour faire clignoter les
caractères (en mode texte).

Définition dans  conio.h

*****************************************************************************
 directvideo (variable globale)
 ═════════════════════════════

Contrôle le mode de gestion des affichages.

  int directvideo

Définie dans  conio.h

directvideo permet de choisir entre écriture directe des affichages dans la
zone mémoire de l'écran vidéo ou l'appel des routines du ROM BIOS
(directvideo = 0).

La valmeur implicite est directvideo = 1 (écriture en mémoire vidéo).

Dans ce mode d'affichage rapide, l'adaptateur vidéo doit être très
compatible.

Avec directvideo = 0, vous pouvez utiliser un système moins compatible, du
moment qu'il le soit au niveau du BIOS.

Voir aussi:

  liste des variables globales

*****************************************************************************
 text_info (structure)
 ═════════════════════

Informations au sujet de la fenêtre texte active.

  struct text_info {
    unsigned char  winleft,   wintop;
    unsigned char  winright,  winbottom;
    unsigned char  attribute, normattr;
    unsigned char  currmode;
    unsigned char  screenheight;
    unsigned char  screenwidth;
    unsigned char  curx, cury;
  };

Défini dans  conio.h

Voir aussi

  gettextinfo

*****************************************************************************
text_modes (type énuméré)

Modes texte standards

  LASTMODE    BW80
  BW40        C80
  C40         C4350
  MONO

Définition dans  conio.h







