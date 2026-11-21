# SIGMA, 2003 : simuler un port avec du Java et beaucoup de patterns

<!--
À VÉRIFIER AVANT PUBLICATION
1. Rattachement CNRS du laboratoire PSI : aucun document de l'archive ne le mentionne. Les diaporamas disent seulement « laboratoire P.S.I. » et le mémoire de Mames « laboratoire PSI de l'INSA de Rouen ». Ajouter la mention CNRS ici si elle est exacte.
2. Titre officiel du diplôme et du document : les diaporamas parlent de « rapport de stage » et de « mémoire de stage ». « Thèse professionnelle » est le terme du Mastère Spécialisé, à confirmer.
3. Le texte du rapport de stage lui-même n'est pas dans l'archive (seulement les diaporamas et la planche A3). Les chiffres cités viennent des diaporamas.
-->

Dix ans après mes démos, un autre projet de l'archive n'a rien à voir avec la démoscène : **SIGMA**. Ce n'est pas une démo. C'est ma thèse professionnelle, soutenue en octobre 2003 au CESI de Rouen pour le Mastère Spécialisé en Management de projet informatique en milieu industriel. Le titre de la soutenance : *Architecture et reverse-engineering appliqués à la plate-forme SIGMA*.

Le code est écrit en **Java**, la modélisation en **UML**, les données en **XML**. Le prototype dont il est issu était en Lisp. Je l'ai réalisé dans un laboratoire de recherche, le **laboratoire PSI (Perception, Systèmes et Information) de l'INSA de Rouen**.

## Le problème : tester un port sans toucher au port

Un terminal à conteneurs, c'est des navires, des camions, des grues et des chariots cavaliers qui déplacent des boîtes de 20 ou 40 pieds entre le quai, le stockage et la sortie. Changer l'implantation ou acheter un engin coûte une fortune. Le domaine est très concurrentiel, et personne ne veut essayer « pour voir ».

La réponse est la **simulation** : on décrit le site dans un fichier, on rejoue le trafic dans l'ordinateur, et on compare des stratégies d'exploitation. Le laboratoire en avait déjà un, **SGTC**, écrit en Lisp, 6 années-hommes de travail, validé au Havre puis dans un projet européen (Intraseas). Il avait fait son travail : valider des spécifications. Mais c'était un prototype jetable, et personne ne pouvait plus le faire évoluer.

Un nouveau noyau, **SIGMA**, l'avait remplacé : en Java, découpé en composants, pensé pour durer. Ce noyau a été conçu par Christophe Mames pour son mémoire d'ingénieur CNAM. Il tournait. Il n'était presque pas documenté, et très couplé.

C'est là que j'arrive.

## Le principe de SIGMA en trois lignes

- Un **client** (un camion, un navire) demande un **service** à un **serveur** (équipe, déplacement, stockage).
- Chaque demande est un **événement** daté, avec la liste des événements qui doivent être finis avant lui.
- Un **échéancier** prend le premier événement activable, fait avancer l'horloge et laisse le serveur exécuter. Un service peut se décomposer en sous-services, ce qui donne du parallélisme gratuit.

Il y a une [page interactive](sigma-explorer.html) pour jouer avec ça : on règle le nombre de camions et de chariots, et on regarde l'échéancier avancer, avec un navire, une grue, des chariots cavaliers et les attentes de ressource.

## Ce que j'ai fait

Mon sujet n'était pas d'inventer un simulateur, mais de **comprendre celui-là, le rendre maintenable et l'ouvrir**. Concrètement :

- **Lire et documenter** un code sans doc, avec des diagrammes UML pour chaque partie. Je ne connaissais rien à la simulation en arrivant. Il a fallu étudier la théorie avant de toucher au code.
- **Découpler**. Le système tenait en un bloc : l'initialisation d'un scénario mélangeait la création des serveurs avec les algorithmes de choix des équipes. J'ai **inversé les responsabilités** : le scénario XML produit des requêtes, des fabriques construisent les objets, et le système ne sait plus rien du métier.
- **Un pattern maison, Consumer / Manager / Strategy**, pour que chaque client puisse jouer sa propre stratégie dans un même scénario. Dans le XML, un camion déclare `gotostrategy="computing"` et le suivant `gotostrategy="basic"`.
- **Refaire le service de déplacement.** La version 1.0 renvoyait un temps de trajet de `4 ± 2·random`, quel que soit le départ et l'arrivée. La 1.1 calcule le temps d'après les points, décrits en XML, tout en gardant la logique service / tâches du noyau.
- **Mesurer avant d'optimiser.** Un prototype a montré que plus de 90 % du temps processeur partait dans la recherche des dépendances d'un événement, avec une complexité en n × m dont le m grossit sans arrêt. J'ai étudié des pistes de partitionnement de la file des événements terminés.
- **Ouvrir le système** : éditeur de service, visionneuse de simulation.

## Et le management

Le mastère étant un diplôme de **gestion de projet**, la moitié de la soutenance parle de la manière de conduire le travail : cycle en spirale, itérations avec intégration continue, un peu de **XP** (le client choisit les fonctionnalités, le développeur estime les coûts), cinq jalons, une analyse de risques avec **RISKMAN** et **AMDEC**.

Contraintes de départ : pas de budget, besoin de portabilité, doc faible, un stagiaire qui ne connaît pas la simulation. D'où Java et UML, des outils du domaine public. Trois risques avaient été identifiés (financier, planning, ressources humaines). Deux ne l'ont pas été : la démission d'un stagiaire, et la canicule d'août.

L'enjeu final tenait dans un schéma : le laboratoire produit un prototype et des spécifications, une SSII en tire un logiciel commercial, le client en profite. Valorisation industrielle.

## Ce que j'en retiens

Je retrouve dans SIGMA ce que j'aimais déjà dans les démos : un petit noyau, une règle simple qui fait tout (ici, « un événement n'est activable que si ceux dont il dépend sont finis »), et des gains qui viennent de la structure plus que de la vitesse brute. Reprendre un système des autres sans documentation est un autre métier que d'écrire le sien. C'est celui que j'ai fait ensuite.

Une piste du mémoire de Mames me plaît encore : une **bourse de services** où les clients publient leurs demandes et où des équipes se forment à la volée pour y répondre. On dirait aujourd'hui un système multi-agents.

## Pour aller plus loin

- [L'explication complète](SIGMA.md) : du problème au fonctionnel, puis à l'implémentation, avec une lecture multi-agents.
- [La page interactive](sigma-explorer.html) : l'échéancier en marche.
- Les sources, le binaire et la documentation Java d'origine restent dans mes archives et ne sont pas publiés.
