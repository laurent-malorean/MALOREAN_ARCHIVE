
 Op‚rateurs de multiplication   ( *  /  % )
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

Vous disposez de trois op‚rateurs multiplicatifs:

  *  (multiplication)
  /  (division)
  %  (modulos ou restes)

En voici la syntaxe:

  multiplicative-expr
     cast-expr
     multiplicative-expr * cast-expr
     multiplicative-expr / cast-expr
     multiplicative-expr % cast-expr

Op‚randes:

Les op‚randes pour * et / doivent ˆtre de type arithm‚tique.

Les op‚randes pour % doivent ˆtre de type valeur. Les conversions
arithm‚tiques standard sont appliqu‚es.

R‚sultats:

Le r‚sultat de (op1 * op2) est le produit des deux op‚randes.

Le r‚sultat de (op1 / op2) et de (op1 % op2) sont le quotient et le reste de
la division de op1 par op2, … supposer que op2 est diff‚rent de z‚ro.

Si vous appliquez / ou % avec un second op‚rande ‚gal … z‚ro, une erreur
apparaŒt (la division par z‚ro est impossible).

Lorsque op1 et op2 sont des entiers et que le quotient n'est pas un entier
les r‚sultats sont les suivant (notez que l'arrondi est toujours par d‚faut:

 1. Si op1 et op2 sont de mˆme signe op1 / op2
correspond au plus grand entier inf‚rieur au vrai qotient et op1 % op2 prend
le signe de op1.

 2. Si op1 et op2 sont de signes oppos‚s, op1 / op2
correspond au plus petit entier plus grand que le vrai quotient et op1 % op2
prend le signe de op1.

--------------------------------------------------------------------------

 Op‚rateurs de r‚f‚rence et d'indirection ( & * )
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

Les deux op‚rateurs & et * peuvent ˆtre utilis‚s en combinaison pour acc‚der
… des ‚l‚ments de donn‚es directement ou par indirection.

Le symbole & est utilis‚ en C++ pour indiquer une transmission de paramŠtres
par adresse. C'est ‚galement un op‚rateur ET logique.

Vous pouvez utiliser l'ast‚risque en tant qu'op‚rateur d'indirection de
pointeurs ou bien s–r en tant que op‚rateur de multiplication.

 &   Op‚rateur de r‚f‚rence
 ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Dans l'expression

  & cast-expression

l'op‚rande doit ˆtre l'un des ‚l‚ments suivant:

 ş un descripteur de fonction

 ş une lvalue d‚signant un objet qui n'est pas
   un champ de bits et qui n'est pas d‚clar‚ au
   moyen du sp‚cificateur de stockage register.

   Si l'op‚rande est du type <type>, le r‚sultat
   est du type <type> pointeur vers le type.

 *   Op‚rateur d'indirection
 ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-
L'op‚rateur ast‚risque (*), utilis‚ dans une expression de variable, permet
de cr‚er un pointeur vers un type.

Dans l'expression suivante

  * cast-expression

l'expression doit ˆtre d'un type "pointeur sur <type>", <type> dans
n'importe quel type de donn‚es. Le r‚sultat de l'indirection est du type
mentionn‚.

Si l'op‚rande est du type "pointeur sur fonction", le r‚sultat est un
descripteur de fonction.

Si l'op‚rande est un pointeur sur un objet, le r‚sultat est une lvalue
d‚signant l'objet.

Dans les deux situations suivantes, le r‚sultat d'une indirection n'est pas
d‚fini:

 1. L'expression est un pointeur nul.
 2. L'expression est une adresse d'une variable
    automatique alors que l'ex‚cution du bloc qui
    la d‚finit est termin‚e.

----------------------------------------------------------------------------

 Op‚rateur de compl‚ment binaire    ~ (tilde)
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

Dans l'expression

  ~cast-expression

cast-expression, l'op‚rande, doit ˆtre d'un type valeur (integral value).

Le r‚sultat est le compl‚ment binaire de l'op‚rande aprŠs tout calcul
‚ventuel.

Chaque bit … 0 est arm‚ (mis … 1) et chaque bit … 1 est mis … 0.

Notez qu'en C++, le signe tilde permet d'indiquer le nom d'un destructeur.
----------------------------------------------------------------------------

 Op‚rateurs de d‚calage binaire    ( <<  >> )
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

Il existe deux op‚rateurs de d‚calage: << et >>. Voici la syntaxe:

  shift-expression << additive-expression
  shift-expression >> additive-expression

Dans les expressions E1 << E2 et E1 >> E2, les op‚randes E1 et E2 doivent
ˆtre de type valeur. Les ‚valuations pr‚alables sont r‚alis‚es puis le type
du r‚sultat est celui r‚sultant de l'‚valuation.

Si E2 est n‚gatif ou s'il est constitu‚ d'un nombre ‚gal ou sup‚rieur de
bits que E1, l'op‚ration n'est pas d‚finie.

Le r‚sultat de E1 << E2 est la valeur de E1 d‚cal‚e de E2 positions
binaires, des z‚ro ‚tant ins‚r‚s … la droite.

Le r‚sultat de E1 >> E2 est la valeur de E1 d‚cal‚e … droite de E2 positions
binaires.

Sachez qu'en C++, ces op‚rateurs sont surcharg‚s.

----------------------------------------------------------------------------

 Op‚rateurs d'affectation   ( =  etc.)
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

Il existe 11 op‚rateurs d'affectation en Turbo C++. L'op‚rateur = est le
plus simple d'entre eux; les autres sont les op‚rateurs d'affectation
compos‚s.

Voici ces op‚rateurs:

  =
  *=     /=     %=    +=    -=
  <<=    >>=    &=    ^=    |=

La syntaxe est:

  unary-expr  assignment-op  assignment-expr

Dans l'expression E1 = E2, E1 doit ˆtre une lvalue modifiable.

La valeur de E2, aprŠs conversion vers le type de E1, est stock‚e dans
l'objet d‚sign‚ par E1 (en rempla‡ant sa valeur ant‚rieure).

La valeur de l'expression d'affectation est celle de E1 aprŠs l'op‚ration.

L'expression d'affectation n'est pas une lvalue de elle-mˆme.

Aussi bien pour les op‚rateurs simples que compos‚s, les op‚randes E1 et E2
doivent ob‚ir … l'une des rŠgles suivantes:

 1. E1 est un type arithm‚tique qualifi‚ ou non et
E2 est d'un type arithm‚tique.

 2. E1 est une version qualifi‚e ou non d'un type
struture ou union compatible avec celui de E2.

 3. E1 et E2 sont pointeurs sur des versions
qualifi‚es ou non de type compatibles ou non. Le type point‚ par le membre
gauche est qualifi‚ autant que le type point‚ par le membre droit.

 4. Soit E1 soit E2 est un pointeru sur un objet ou
un type incomplet et l'autre est un pointeur sur une version qualifi‚e ou
non du type void.

    Le type point‚ par le mevre gauche est autant
qualifi‚ que celui point‚ par le membre droit.

 5. E1 est un pointeur et E2 est une constante
pointeur nulle.

Les affectations compos‚es sont de la forme op=, dans laquelle op peut ˆtre
l'un des dix op‚rateurs suivants:

  *      /    %    +    -
  <<    >>    &    ^    |

L'expression

  E1 op= E2

a le mˆme effet que

  E1 = E1 op E2

En dehors du fait que la lvalue E1 n'est ‚valu‚e qu'une fois. Par exemple,
E1 += E2 est ‚quivalent … E1 = E1 + E2.

--------------------------------------------------------------------------



 Op‚rateurs d'accŠs structure  .  ->
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  .   (s‚lecteur de membre direct)
  ->  (s‚lecteur de membre indirect, pointeur)

Ces op‚rateurs de s‚lection permettent d'acc‚der aux membres des structures
et des unions.

Supposons qu'un objets est de type Struct et que sptr est un pointeur sur ce
type S.

Ensuite, si m est un membre du type M d‚clar‚ dans le type S, les
expressions

  s.m

et

  sptr->m

seront de type M. Elles repr‚sentent toutes deux le membre m de la structure
s.

L'expression

  s->sptr

est une ‚criture abr‚g‚e pour (*sptr).m.


Voici la syntaxe d'un s‚lecteur direct:
  postfix-expression . identifier

 ş L'expression postfix peut ˆtre du type
      union ou structure
 ş identifier est le nom d'un membre de la
      structure indiqu‚e.

Syntaxe du s‚lecteur indirect:
  postfix-expression -> identifier

 ş L'expression postfix doit ˆtre d'un type
    pointeur sur une structure ou sur une union.

 ş identifier doit ˆtre un membre de la structure
    point‚e.must be the name of a

L'expression d‚signe un membre d'une structure de donn‚es complexe. La
valeur de l'expression correspond … celle du membre s‚lect‚; il peut s'agir
d'une lvalue seulement si l'expression postfix en est une.

Par exemple,

  struct mastruct {
     int i;
     char str[21];
     double d;
  } s, *sptr=&s;

  ...

  s.i = 3;       // affecte la valeur au membre i
                 // de la structure s
  sptr->d = 1.23;   // affecte la valeur au membre
                    // d de s

L'expression s.m est une lvalue (‚valuation), … condition que s ne soit pas
une lvalue et que m ne soit pas de type tableau.

L'expression sptr->m est une lvalue sauf si m est de type tableau.

Si la structure B contient un champ dont le type est structure A, les
membres de A peuvent ˆtre atteints en appliquant deux fois les s‚lecteurs de
membres.

Voir aussi

  op‚rateurs    s‚parateurs

----------------------------------------------------------------------------

 op‚rateurs Incr‚ment/D‚cr‚ment ( ++    -- )
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

 Op‚rateur incr‚ment  ( ++ )
 ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Syntaxe:

  postfix-expression ++       (postincrement)
  ++ unary-expression         (preincrement)

L'expression est l'op‚rande; il doit s'agir d'un type scalaire (num‚rique ou
pointeur) et il doit s'agir d'une lvalue modifiable.

Dans le cas de l'op‚rateur d'incr‚mentation en postfixe, la valeur de
l'expression complŠte est celle de l'expression postfix avant
incr‚mentation. Une fois que l'expression est ‚valu‚e, l'op‚rande est
augment‚e de 1. Dans le cas de l'op‚rateur pr‚fixe, l'op‚rande est
incr‚ment‚ de 1 avant ‚valuation de l'expression; la valeur de l'expression
correspond … la valeur de l'op‚rande incr‚ment‚. La valeur incr‚ment‚e
correspond au type de l'op‚rande.

Les types pointeurs suivent les rŠgles d'arithm‚tique appliquables aux
pointeurs.


 Op‚rateur d‚crement  ( -- )
 ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Syntaxe:

  postfix-expression --       (postdecrement)
  -- unary-expression         (predecrement)

L'op‚rateur de d‚cr‚mentation fonctionne selon les mˆmes rŠgles que celui
d'incr‚mentation en dehors du fait que l'op‚rande est d‚cr‚ment‚ de 1 aprŠs
ou avant ‚valuation de l'expression.

Voir aussi

  op‚rateurs
----------------------------------------------------------------------------

Op‚rateurs plus et moins     (+   -)
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

 Plus et moins unaires
 ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Dans les expressions unaires avec + et -

  + cast-expression
  - cast-expression

cast-expression est un op‚rande qui doit ˆtre de type arithm‚tique.

Le r‚sultat de "+ cast-expression" est la valeur de l'op‚rande aprŠs toute
int‚gration de calculs.

Le r‚sultat de "- cast-expression" est l'inverse de la valeur de l'op‚rande
aprŠs toute int‚gration de calculs.

 Plus et Moins binaires
 ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
La syntaxe des op‚rateurs binaires + et - est

  add-expression + multiplicative-expression
  add-expression - multiplicative-expression

 ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Les types autoris‚s pour les op‚randes op1 + op2 sont

 1. op1 et op2 sont tous deux de type arithm‚tique

 2. op1 est de type valeur et op2 de type pointeur

 3. op2 est de type valeur et op1 est de type
    pointeur

Dans le premier cas, les op‚randes sont sujet aux conversions arithm‚tiques
standard et le r‚sultat est la somme arithm‚tique des op‚randes.

Dans les cas 2 et 3, les rŠgles concernant les pointeurs sont appliquables.

 ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Les types d'op‚randes valides pour op1 - op2 sont

 1. op1 et op2 sont tous deux de type
    arithm‚tique.
 2. op1 et op2 sont tous deux de type
    pointeur sur des objets compatibles
    (le type non qualifi‚ <type> est
    consid‚r‚ comme compatible avec les
    types qualifi‚s const, volatile et
    const volatile).
 3. op1 est un pointeur sur un type et
    op2 un type valeur.

Dans le premier cas, les op‚randes sont sujets aux conversions arithm‚tiques
standard et le r‚sultat est la diff‚rence arithm‚tique de l'op‚rande.

Dans les cas 2 et 3, les rŠgles concernant les pointeurs sont appliquables.

Voir aussi

  op‚rateurs

-----------------------------------------------------------------------------

 Op‚rateur de n‚gation logique      !
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

Dans l'expression

  ! cast-expression

cast-expression, l'op‚rande, doit ˆtre d'un type scalaire.

Le r‚sultat est de type int et il correspond … la n‚gation logique de
l'op‚rande:

 ş 0 si l'op‚rande est diff‚rent de z‚ro
 ş 1 si l'op‚rande est ‚gal … z‚ro

L'expression !E est ‚quivalente … (0 == E).

Voir aussi

  op‚rateurs

---------------------------------------------------------------------------


 Op‚rateurs d'‚galit‚      ( ==  != )
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

Les deux op‚raeurs == et != permettent de tester l'‚galit‚ ou la non ‚galit‚
de deux valeurs arithm‚tiques ou pointeurs, en appliquant les rŠgles et
op‚rateurs relationnels.

Les op‚rateurs d'‚galit‚ ont une moins grande priorit‚ que les relationnels.
Vous pouvez comparer des types pointeur que les op‚rateurs relationnels ne
permettent pas de comparer.

Dans les expressions E1 == E2 et E1 != E2, les op‚randes doivent ˆtre
conformes … l'une des expressions suivantes:

 1. E1 et E2 sont de type arithm‚tiques.

 2. E1 et E2 sont des poineteurs sur des versions
qualifi‚es ou non de types compatibles.

 3. Soit E1 soit E2 est un pointeur sur un objet ou
un type incomplet, l'autre op‚rande ‚tant un pointeur sur une version
qualifi‚e ou non de void.

 4. Soit E1 soit E2 est un pointeur, l'autre
op‚rande ‚tant une constante pointeur nulle.

    Dans ce cas, le pointeur sur l'objet ou le type
incomplet est converti vers le type de l'autre op‚rande (pointeur sur une
version qualifi‚e ou non de void).

Si E1 et E2 sont des types valides pour un op‚rateur relationnel, les mˆmes
rŠgles de comparaison s'appliquent.

Si E1 et E2 sont des pointeurs sur des types fonction, E1 == E2 renvoie 1
(true) si les deux pointeurs sont nuls ou s'ils pointent tous deux sur la
mˆme fonction.

De mˆme si E1 == E2 renvoie 1, cela indique soit que E1 et E2 pointent sur
la mˆme fonction, soit sont tous deux nuls.

L'expression E1 != E2 ob‚it aux mˆmes rŠgles, sauf que le r‚sultat est
invers‚: Si les op‚randes sont diff‚rents le r‚sultat est 1 (true).

Voir aussi

  op‚rateurs

---------------------------------------------------------------------------

 Op‚rateurs Logiques et sur bit    & ^ | && ||
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

Turbo C++ fourni 5 op‚rateurs permettant de manipuler les op‚rations au
niveau du bit:

  &   ET entre bit
  ^   OU exclusif entre bit
  |   OU entre bit

  &&  ET logique
  ||  OU logique

Voici la syntaxe:

  AND-expression    &  equality-expression
  exclusive-OR-expr ^  AND-expression
  inclusive-OR-expr |  exclusive-OR-expression
  logical-AND-expr  && inclusive-OR-expression
  logical-OR-expr   || logical-AND-expression

Dans les expressions

  E1 & E2
  E1 ^ E2
  E1 | E2

Les op‚randes doivent ˆtre de type valeur.

Dans les expressions

  E1 && E2
  E1 || E2

Les deux op‚randes doivent ˆtre de type scalaire.

Les conversions arithm‚tiques habituelles sont appliqu‚es … E1 et E2.

En ce qui concerne les op‚rateurs au niveau du bit chaque bit du r‚sultat
correspond … la table de v‚rit‚ suivante:

  En entr‚e   ³         En sortie
  ÍÍÍÍÍÍÍÍÍ   ³         ÍÍÍÍÍÍÍÍÍÍ
   E1  E2     ³ E1 & E2    E1 ^ E2    E1 | E2
 ÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ
   0      0   ³    0          0          0
   1      0   ³    0          1          1
   0      1   ³    0          1          1
   1      1   ³    1          0          1

A l'inverse des op‚rateurs au niveau du bit, les op‚rateurs logiques && et
|| garantissent une op‚ration de gauche … droite.

E1 est ‚valu‚ en premier; s'il est ‚gal … 0, E1 && E2 renvoient 0 et E2
n'est pas ‚valu‚.

Dans le cas de E1 || E2, si E1 est diff‚rent de 0, l'expression complŠte
renvoie 1 et E2 n'est pas ‚valu‚e.

Voir aussi

  op‚rateurs


---------------------------------------------------------------------------

 Op‚rateur conditionnel   ( ? : )
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

L'op‚rateur conditionnel ?: est un op‚rateur ternaire. Voici la syntaxe:

  logical-OR-expr ? expr : conditional-expr

Dans l'expression E1 ? E2 : E3, l'op‚rande E1 doit ˆtre de type scalaire.
Les op‚randes E1 et E3 doivent ob‚ir … l'une des rŠgles ci-dessous:

 1. Tous deux sont de type arithm‚tique.

    Dans ce cas, aussi bien E2 que E3 se voient
appliquer les conversions arithm‚tiques habituelles et le type du r‚sultat
est le type commun r‚sultant de la conversion.

 2. Les deux op‚randes sont de type structure ou
union compatibles.

    Dans ce cas le type du r‚sultat est le type de
la structure de E2 et E3.

 3. Les deux op‚randes sont de type void.

    Dans ce cas le r‚sultat est de type void.

 4. Les deux op‚randes sont de type pointeur sur
une version qualifi‚e ou non de types compatibles.

    Dans ce cas le type du r‚sultat est un pointeur
sur un type qualifi‚ par tous les types qualifi‚s des types point‚s par les
op‚randes.


 5. Un op‚rande est de type pointeur et l'autre une
constante pointeur nulle.

    Dans ce cas le type du r‚sultat est un pointeur
sur un type qualifi‚ par rapport … tous les types qualifi‚s des types
point‚s par les op‚randes.

 6. Un op‚rande est de type pointeur sur un objet
ou un type incomplet, l'autre ‚tant un pointeur sur une version qualifi‚e ou
non du type void.

    Dans ce cas le type du r‚sultat est celui de
l'op‚rande qui n'est pas pointeur sur void.

Dans tous les cas E1 est ‚valu‚ en premier. Si la valeur est diff‚rente de
0, E2 est ‚valu‚ et E3 est ignor‚. Si E1 est ‚gal … 0, E3 est ‚valu‚ mais E2
ne l'est pas.

Le r‚sultat de E1 ? E2 : E3 correspond … la valeur de E2 ou de E3 suivant le
cas.

Voir aussi

  op‚rateurs


---------------------------------------------------------------------------

 Op‚rateurs et signe virgule       ( , )
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

La virgule permet de s‚parer les ‚l‚ments d'une liste d'arguments de
fonction.

La virgule sert aussi en tant qu'op‚rateur dans les expressions virgule.
L'usage simultan‚ dans les deux significations est autoris‚, mais vous devez
utiliser les parenthŠses pour clarifier l'‚criture. La syntaxe des
expressions virgule est la suivante:

  expression , assignment-expression

L'op‚rande gauche E1 est ‚valu‚ en tant qu'expression nulle, puis E2 est
‚valu‚ pour fournir le r‚sultat et le type de l'expression virgule. En
appliquant une r‚cursion. L'expression

  E1, E2, ..., En

r‚sultera en une ‚valuation de gauche … droite de chaque ‚l‚ment E. La
valeur et le type de En donneront le r‚sultat de toute l'expression.

Pour ‚viter toute ambigu‹t‚ entre les virgules dans les arguments de
fonction et dans les listes d'initialisation, vous devez ajouter des
aprenthŠses. Par exemple,

  fonc(i, (j = 1, j + 4), k);

provoque l'appel de fonc avec trois arguments et non quatre. Les arguments
sont i, 5 et k.

Voir aussi

  op‚rateurs

---------------------------------------------------------------------------

 #define (directive)
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

D‚finit une macro.

  #define <id1>[( <id2>, ... )] <‚l‚ment_chaine>

La directive #define d‚finit une macro. Les macros procurent un m‚canisme de
remplacement d'‚l‚ment avec, ou sans, un jeu de paramŠtres formels.

Dans le texte source, toutes les occurences suivantes de l'identificateur
<id1> seront remplac‚es par le texte d‚fini par <‚l‚ment_chaine>.

Si <id1> est IMMEDIATEMENT suivi d'une (, les identificateurs suivants cette
parenthŠse ouvrante (<id2>, etc.) sont trait‚s comme des param‚tres d'une
fonction et non comme une partie de <‚l‚ment_chaŒne>.

Toutes les occurences de <id2> dans <‚l‚ment_chaŒne> seront remplac‚s par le
texte r‚el d‚fini pour <id2> quand <id1> est r‚f‚renc‚ dans le source.

Pour continuer la d‚finition sur une ligne suivante, terminez la ligne
courante par le signe \.

 Exemple
 ÄÄÄÄÄÄÄ
  #define MAXINT 32767
  #define ctrl(x) ((x) \
                   - 64)

Voir aussi

  #undef    #if    token pasting

---------------------------------------------------------------------------

 Token pasting
 ÍÍÍÍÍÍÍÍÍÍÍÍÍ

Lors de l'utilisation de macros avec liste d'arguments, vous pouvez
fusionner (ou coller) deux ‚l‚ments si ceux-ci sont s‚par‚s par ##. Par
exemple, avec la d‚finition

  #define VAR(i,j) (i##j)

l'appel de call VAR(x,6) se r‚soud en (x6).

Cette m‚thode remplace l'ancienne (non portable) dont la syntaxe ‚tait
(i/**/j).

Bien que cela soit l‚gal, il n'est pas du tout judicieux d'utiliser des mots
r‚serv‚s de Turbo C++ comme identificateurs de macro. Par exemple,

  #define int long

est l‚gal, mais sans doute catastrophique.

Aucun des identificateurs globaux suivants ne peut ˆtre employ‚
imm‚diatement aprŠs une directive #define ou #undef :

  __DATE__      __LINE__      __TIME__
  __FILE__      __STDC__

Voir aussi:

  #define

---------------------------------------------------------------------------

---------------------------------------------------------------------------


---------------------------------------------------------------------------