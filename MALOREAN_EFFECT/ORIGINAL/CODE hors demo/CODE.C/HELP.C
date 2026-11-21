
 Opérateurs de multiplication   ( *  /  % )
 ══════════════════════════════════════════

Vous disposez de trois opérateurs multiplicatifs:

  *  (multiplication)
  /  (division)
  %  (modulos ou restes)

En voici la syntaxe:

  multiplicative-expr
     cast-expr
     multiplicative-expr * cast-expr
     multiplicative-expr / cast-expr
     multiplicative-expr % cast-expr

Opérandes:

Les opérandes pour * et / doivent être de type arithmétique.

Les opérandes pour % doivent être de type valeur. Les conversions
arithmétiques standard sont appliquées.

Résultats:

Le résultat de (op1 * op2) est le produit des deux opérandes.

Le résultat de (op1 / op2) et de (op1 % op2) sont le quotient et le reste de
la division de op1 par op2, à supposer que op2 est différent de zéro.

Si vous appliquez / ou % avec un second opérande égal à zéro, une erreur
apparaît (la division par zéro est impossible).

Lorsque op1 et op2 sont des entiers et que le quotient n'est pas un entier
les résultats sont les suivant (notez que l'arrondi est toujours par défaut:

 1. Si op1 et op2 sont de même signe op1 / op2
correspond au plus grand entier inférieur au vrai qotient et op1 % op2 prend
le signe de op1.

 2. Si op1 et op2 sont de signes opposés, op1 / op2
correspond au plus petit entier plus grand que le vrai quotient et op1 % op2
prend le signe de op1.

--------------------------------------------------------------------------

 Opérateurs de référence et d'indirection ( & * )
 ════════════════════════════════════════════════

Les deux opérateurs & et * peuvent être utilisés en combinaison pour accéder
à des éléments de données directement ou par indirection.

Le symbole & est utilisé en C++ pour indiquer une transmission de paramètres
par adresse. C'est également un opérateur ET logique.

Vous pouvez utiliser l'astérisque en tant qu'opérateur d'indirection de
pointeurs ou bien sûr en tant que opérateur de multiplication.

 &   Opérateur de référence
 ────────────────────────
Dans l'expression

  & cast-expression

l'opérande doit être l'un des éléments suivant:

 ■ un descripteur de fonction

 ■ une lvalue désignant un objet qui n'est pas
   un champ de bits et qui n'est pas déclaré au
   moyen du spécificateur de stockage register.

   Si l'opérande est du type <type>, le résultat
   est du type <type> pointeur vers le type.

 *   Opérateur d'indirection
 ──────────────────────────-
L'opérateur astérisque (*), utilisé dans une expression de variable, permet
de créer un pointeur vers un type.

Dans l'expression suivante

  * cast-expression

l'expression doit être d'un type "pointeur sur <type>", <type> dans
n'importe quel type de données. Le résultat de l'indirection est du type
mentionné.

Si l'opérande est du type "pointeur sur fonction", le résultat est un
descripteur de fonction.

Si l'opérande est un pointeur sur un objet, le résultat est une lvalue
désignant l'objet.

Dans les deux situations suivantes, le résultat d'une indirection n'est pas
défini:

 1. L'expression est un pointeur nul.
 2. L'expression est une adresse d'une variable
    automatique alors que l'exécution du bloc qui
    la définit est terminée.

----------------------------------------------------------------------------

 Opérateur de complément binaire    ~ (tilde)
 ════════════════════════════════════════

Dans l'expression

  ~cast-expression

cast-expression, l'opérande, doit être d'un type valeur (integral value).

Le résultat est le complément binaire de l'opérande après tout calcul
éventuel.

Chaque bit à 0 est armé (mis à 1) et chaque bit à 1 est mis à 0.

Notez qu'en C++, le signe tilde permet d'indiquer le nom d'un destructeur.
----------------------------------------------------------------------------

 Opérateurs de décalage binaire    ( <<  >> )
 ════════════════════════════════════════════

Il existe deux opérateurs de décalage: << et >>. Voici la syntaxe:

  shift-expression << additive-expression
  shift-expression >> additive-expression

Dans les expressions E1 << E2 et E1 >> E2, les opérandes E1 et E2 doivent
être de type valeur. Les évaluations préalables sont réalisées puis le type
du résultat est celui résultant de l'évaluation.

Si E2 est négatif ou s'il est constitué d'un nombre égal ou supérieur de
bits que E1, l'opération n'est pas définie.

Le résultat de E1 << E2 est la valeur de E1 décalée de E2 positions
binaires, des zéro étant insérés à la droite.

Le résultat de E1 >> E2 est la valeur de E1 décalée à droite de E2 positions
binaires.

Sachez qu'en C++, ces opérateurs sont surchargés.

----------------------------------------------------------------------------

 Opérateurs d'affectation   ( =  etc.)
 ═════════════════════════════════

Il existe 11 opérateurs d'affectation en Turbo C++. L'opérateur = est le
plus simple d'entre eux; les autres sont les opérateurs d'affectation
composés.

Voici ces opérateurs:

  =
  *=     /=     %=    +=    -=
  <<=    >>=    &=    ^=    |=

La syntaxe est:

  unary-expr  assignment-op  assignment-expr

Dans l'expression E1 = E2, E1 doit être une lvalue modifiable.

La valeur de E2, après conversion vers le type de E1, est stockée dans
l'objet désigné par E1 (en remplaçant sa valeur antérieure).

La valeur de l'expression d'affectation est celle de E1 après l'opération.

L'expression d'affectation n'est pas une lvalue de elle-même.

Aussi bien pour les opérateurs simples que composés, les opérandes E1 et E2
doivent obéir à l'une des règles suivantes:

 1. E1 est un type arithmétique qualifié ou non et
E2 est d'un type arithmétique.

 2. E1 est une version qualifiée ou non d'un type
struture ou union compatible avec celui de E2.

 3. E1 et E2 sont pointeurs sur des versions
qualifiées ou non de type compatibles ou non. Le type pointé par le membre
gauche est qualifié autant que le type pointé par le membre droit.

 4. Soit E1 soit E2 est un pointeru sur un objet ou
un type incomplet et l'autre est un pointeur sur une version qualifiée ou
non du type void.

    Le type pointé par le mevre gauche est autant
qualifié que celui pointé par le membre droit.

 5. E1 est un pointeur et E2 est une constante
pointeur nulle.

Les affectations composées sont de la forme op=, dans laquelle op peut être
l'un des dix opérateurs suivants:

  *      /    %    +    -
  <<    >>    &    ^    |

L'expression

  E1 op= E2

a le même effet que

  E1 = E1 op E2

En dehors du fait que la lvalue E1 n'est évaluée qu'une fois. Par exemple,
E1 += E2 est équivalent à E1 = E1 + E2.

--------------------------------------------------------------------------



 Opérateurs d'accès structure  .  ->
 ═══════════════════════════════════

  .   (sélecteur de membre direct)
  ->  (sélecteur de membre indirect, pointeur)

Ces opérateurs de sélection permettent d'accéder aux membres des structures
et des unions.

Supposons qu'un objets est de type Struct et que sptr est un pointeur sur ce
type S.

Ensuite, si m est un membre du type M déclaré dans le type S, les
expressions

  s.m

et

  sptr->m

seront de type M. Elles représentent toutes deux le membre m de la structure
s.

L'expression

  s->sptr

est une écriture abrégée pour (*sptr).m.


Voici la syntaxe d'un sélecteur direct:
  postfix-expression . identifier

 ■ L'expression postfix peut être du type
      union ou structure
 ■ identifier est le nom d'un membre de la
      structure indiquée.

Syntaxe du sélecteur indirect:
  postfix-expression -> identifier

 ■ L'expression postfix doit être d'un type
    pointeur sur une structure ou sur une union.

 ■ identifier doit être un membre de la structure
    pointée.must be the name of a

L'expression désigne un membre d'une structure de données complexe. La
valeur de l'expression correspond à celle du membre sélecté; il peut s'agir
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

L'expression s.m est une lvalue (évaluation), à condition que s ne soit pas
une lvalue et que m ne soit pas de type tableau.

L'expression sptr->m est une lvalue sauf si m est de type tableau.

Si la structure B contient un champ dont le type est structure A, les
membres de A peuvent être atteints en appliquant deux fois les sélecteurs de
membres.

Voir aussi

  opérateurs    séparateurs

----------------------------------------------------------------------------

 opérateurs Incrément/Décrément ( ++    -- )
 ═══════════════════════════════════════════

 Opérateur incrément  ( ++ )
 ──────────────────────────

Syntaxe:

  postfix-expression ++       (postincrement)
  ++ unary-expression         (preincrement)

L'expression est l'opérande; il doit s'agir d'un type scalaire (numérique ou
pointeur) et il doit s'agir d'une lvalue modifiable.

Dans le cas de l'opérateur d'incrémentation en postfixe, la valeur de
l'expression complète est celle de l'expression postfix avant
incrémentation. Une fois que l'expression est évaluée, l'opérande est
augmentée de 1. Dans le cas de l'opérateur préfixe, l'opérande est
incrémenté de 1 avant évaluation de l'expression; la valeur de l'expression
correspond à la valeur de l'opérande incrémenté. La valeur incrémentée
correspond au type de l'opérande.

Les types pointeurs suivent les règles d'arithmétique appliquables aux
pointeurs.


 Opérateur décrement  ( -- )
 ──────────────────────────

Syntaxe:

  postfix-expression --       (postdecrement)
  -- unary-expression         (predecrement)

L'opérateur de décrémentation fonctionne selon les mêmes règles que celui
d'incrémentation en dehors du fait que l'opérande est décrémenté de 1 après
ou avant évaluation de l'expression.

Voir aussi

  opérateurs
----------------------------------------------------------------------------

Opérateurs plus et moins     (+   -)
 ═══════════════════════════════════

 Plus et moins unaires
 ────────────────────
Dans les expressions unaires avec + et -

  + cast-expression
  - cast-expression

cast-expression est un opérande qui doit être de type arithmétique.

Le résultat de "+ cast-expression" est la valeur de l'opérande après toute
intégration de calculs.

Le résultat de "- cast-expression" est l'inverse de la valeur de l'opérande
après toute intégration de calculs.

 Plus et Moins binaires
 ─────────────────────
La syntaxe des opérateurs binaires + et - est

  add-expression + multiplicative-expression
  add-expression - multiplicative-expression

 ──────────────────────────────────────────────────
Les types autorisés pour les opérandes op1 + op2 sont

 1. op1 et op2 sont tous deux de type arithmétique

 2. op1 est de type valeur et op2 de type pointeur

 3. op2 est de type valeur et op1 est de type
    pointeur

Dans le premier cas, les opérandes sont sujet aux conversions arithmétiques
standard et le résultat est la somme arithmétique des opérandes.

Dans les cas 2 et 3, les règles concernant les pointeurs sont appliquables.

 ──────────────────────────────────────────────────

Les types d'opérandes valides pour op1 - op2 sont

 1. op1 et op2 sont tous deux de type
    arithmétique.
 2. op1 et op2 sont tous deux de type
    pointeur sur des objets compatibles
    (le type non qualifié <type> est
    considéré comme compatible avec les
    types qualifiés const, volatile et
    const volatile).
 3. op1 est un pointeur sur un type et
    op2 un type valeur.

Dans le premier cas, les opérandes sont sujets aux conversions arithmétiques
standard et le résultat est la différence arithmétique de l'opérande.

Dans les cas 2 et 3, les règles concernant les pointeurs sont appliquables.

Voir aussi

  opérateurs

-----------------------------------------------------------------------------

 Opérateur de négation logique      !
 ════════════════════════════════════

Dans l'expression

  ! cast-expression

cast-expression, l'opérande, doit être d'un type scalaire.

Le résultat est de type int et il correspond à la négation logique de
l'opérande:

 ■ 0 si l'opérande est différent de zéro
 ■ 1 si l'opérande est égal à zéro

L'expression !E est équivalente à (0 == E).

Voir aussi

  opérateurs

---------------------------------------------------------------------------


 Opérateurs d'égalité      ( ==  != )
 ════════════════════════════════════

Les deux opéraeurs == et != permettent de tester l'égalité ou la non égalité
de deux valeurs arithmétiques ou pointeurs, en appliquant les règles et
opérateurs relationnels.

Les opérateurs d'égalité ont une moins grande priorité que les relationnels.
Vous pouvez comparer des types pointeur que les opérateurs relationnels ne
permettent pas de comparer.

Dans les expressions E1 == E2 et E1 != E2, les opérandes doivent être
conformes à l'une des expressions suivantes:

 1. E1 et E2 sont de type arithmétiques.

 2. E1 et E2 sont des poineteurs sur des versions
qualifiées ou non de types compatibles.

 3. Soit E1 soit E2 est un pointeur sur un objet ou
un type incomplet, l'autre opérande étant un pointeur sur une version
qualifiée ou non de void.

 4. Soit E1 soit E2 est un pointeur, l'autre
opérande étant une constante pointeur nulle.

    Dans ce cas, le pointeur sur l'objet ou le type
incomplet est converti vers le type de l'autre opérande (pointeur sur une
version qualifiée ou non de void).

Si E1 et E2 sont des types valides pour un opérateur relationnel, les mêmes
règles de comparaison s'appliquent.

Si E1 et E2 sont des pointeurs sur des types fonction, E1 == E2 renvoie 1
(true) si les deux pointeurs sont nuls ou s'ils pointent tous deux sur la
même fonction.

De même si E1 == E2 renvoie 1, cela indique soit que E1 et E2 pointent sur
la même fonction, soit sont tous deux nuls.

L'expression E1 != E2 obéit aux mêmes règles, sauf que le résultat est
inversé: Si les opérandes sont différents le résultat est 1 (true).

Voir aussi

  opérateurs

---------------------------------------------------------------------------

 Opérateurs Logiques et sur bit    & ^ | && ||
 ════════════════════════════════════════════

Turbo C++ fourni 5 opérateurs permettant de manipuler les opérations au
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

Les opérandes doivent être de type valeur.

Dans les expressions

  E1 && E2
  E1 || E2

Les deux opérandes doivent être de type scalaire.

Les conversions arithmétiques habituelles sont appliquées à E1 et E2.

En ce qui concerne les opérateurs au niveau du bit chaque bit du résultat
correspond à la table de vérité suivante:

  En entrée   │         En sortie
  ═════════   │         ══════════
   E1  E2     │ E1 & E2    E1 ^ E2    E1 | E2
 ═════════════╪══════════════════════════════
   0      0   │    0          0          0
   1      0   │    0          1          1
   0      1   │    0          1          1
   1      1   │    1          0          1

A l'inverse des opérateurs au niveau du bit, les opérateurs logiques && et
|| garantissent une opération de gauche à droite.

E1 est évalué en premier; s'il est égal à 0, E1 && E2 renvoient 0 et E2
n'est pas évalué.

Dans le cas de E1 || E2, si E1 est différent de 0, l'expression complète
renvoie 1 et E2 n'est pas évaluée.

Voir aussi

  opérateurs


---------------------------------------------------------------------------

 Opérateur conditionnel   ( ? : )
 ════════════════════════════════

L'opérateur conditionnel ?: est un opérateur ternaire. Voici la syntaxe:

  logical-OR-expr ? expr : conditional-expr

Dans l'expression E1 ? E2 : E3, l'opérande E1 doit être de type scalaire.
Les opérandes E1 et E3 doivent obéir à l'une des règles ci-dessous:

 1. Tous deux sont de type arithmétique.

    Dans ce cas, aussi bien E2 que E3 se voient
appliquer les conversions arithmétiques habituelles et le type du résultat
est le type commun résultant de la conversion.

 2. Les deux opérandes sont de type structure ou
union compatibles.

    Dans ce cas le type du résultat est le type de
la structure de E2 et E3.

 3. Les deux opérandes sont de type void.

    Dans ce cas le résultat est de type void.

 4. Les deux opérandes sont de type pointeur sur
une version qualifiée ou non de types compatibles.

    Dans ce cas le type du résultat est un pointeur
sur un type qualifié par tous les types qualifiés des types pointés par les
opérandes.


 5. Un opérande est de type pointeur et l'autre une
constante pointeur nulle.

    Dans ce cas le type du résultat est un pointeur
sur un type qualifié par rapport à tous les types qualifiés des types
pointés par les opérandes.

 6. Un opérande est de type pointeur sur un objet
ou un type incomplet, l'autre étant un pointeur sur une version qualifiée ou
non du type void.

    Dans ce cas le type du résultat est celui de
l'opérande qui n'est pas pointeur sur void.

Dans tous les cas E1 est évalué en premier. Si la valeur est différente de
0, E2 est évalué et E3 est ignoré. Si E1 est égal à 0, E3 est évalué mais E2
ne l'est pas.

Le résultat de E1 ? E2 : E3 correspond à la valeur de E2 ou de E3 suivant le
cas.

Voir aussi

  opérateurs


---------------------------------------------------------------------------

 Opérateurs et signe virgule       ( , )
 ═══════════════════════════════════════

La virgule permet de séparer les éléments d'une liste d'arguments de
fonction.

La virgule sert aussi en tant qu'opérateur dans les expressions virgule.
L'usage simultané dans les deux significations est autorisé, mais vous devez
utiliser les parenthèses pour clarifier l'écriture. La syntaxe des
expressions virgule est la suivante:

  expression , assignment-expression

L'opérande gauche E1 est évalué en tant qu'expression nulle, puis E2 est
évalué pour fournir le résultat et le type de l'expression virgule. En
appliquant une récursion. L'expression

  E1, E2, ..., En

résultera en une évaluation de gauche à droite de chaque élément E. La
valeur et le type de En donneront le résultat de toute l'expression.

Pour éviter toute ambiguïté entre les virgules dans les arguments de
fonction et dans les listes d'initialisation, vous devez ajouter des
aprenthèses. Par exemple,

  fonc(i, (j = 1, j + 4), k);

provoque l'appel de fonc avec trois arguments et non quatre. Les arguments
sont i, 5 et k.

Voir aussi

  opérateurs

---------------------------------------------------------------------------

 #define (directive)
 ═══════════════════

Définit une macro.

  #define <id1>[( <id2>, ... )] <élément_chaine>

La directive #define définit une macro. Les macros procurent un mécanisme de
remplacement d'élément avec, ou sans, un jeu de paramètres formels.

Dans le texte source, toutes les occurences suivantes de l'identificateur
<id1> seront remplacées par le texte défini par <élément_chaine>.

Si <id1> est IMMEDIATEMENT suivi d'une (, les identificateurs suivants cette
parenthèse ouvrante (<id2>, etc.) sont traités comme des paramétres d'une
fonction et non comme une partie de <élément_chaîne>.

Toutes les occurences de <id2> dans <élément_chaîne> seront remplacés par le
texte réel défini pour <id2> quand <id1> est référencé dans le source.

Pour continuer la définition sur une ligne suivante, terminez la ligne
courante par le signe \.

 Exemple
 ───────
  #define MAXINT 32767
  #define ctrl(x) ((x) \
                   - 64)

Voir aussi

  #undef    #if    token pasting

---------------------------------------------------------------------------

 Token pasting
 ═════════════

Lors de l'utilisation de macros avec liste d'arguments, vous pouvez
fusionner (ou coller) deux éléments si ceux-ci sont séparés par ##. Par
exemple, avec la définition

  #define VAR(i,j) (i##j)

l'appel de call VAR(x,6) se résoud en (x6).

Cette méthode remplace l'ancienne (non portable) dont la syntaxe était
(i/**/j).

Bien que cela soit légal, il n'est pas du tout judicieux d'utiliser des mots
réservés de Turbo C++ comme identificateurs de macro. Par exemple,

  #define int long

est légal, mais sans doute catastrophique.

Aucun des identificateurs globaux suivants ne peut être employé
immédiatement après une directive #define ou #undef :

  __DATE__      __LINE__      __TIME__
  __FILE__      __STDC__

Voir aussi:

  #define

---------------------------------------------------------------------------

---------------------------------------------------------------------------


---------------------------------------------------------------------------