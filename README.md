Archives de mes production réalisée voila plus de 30 ans su rdes machies plusieurs milliers de fois moins puissantes que nos Mac M4 actuels. 

A l'époque j'officiais sosu le pseudo de volpone. 

## Qu'est-ce qu'une démo ?

Une **démo** est un court programme (quelques minutes) qui produit en temps réel des images animées synchronisées sur de la musique. Elle n'a aucune utilité pratique : son but est de montrer jusqu'où on peut pousser une machine, par la technique (code optimisé, souvent en assembleur) comme par l'esthétique.

Les **demomakers** forment la « demoscene », une culture née dans les années 80 et très active dans les années 90 (Amiga, Atari ST, PC). Ils travaillent en groupes (programmeurs, graphistes, musiciens) et présentent leurs créations en compétition lors de rencontres appelées *demoparties*. Les effets typiques sont les plasmas, tunnels, rotozoomers, fractales ou objets 3D, tous calculés avec des astuces mathématiques pour compenser la faible puissance des machines de l'époque.

## Le contexte technique de l'époque

Ces démos tournent sur des **PC compatibles IBM des années 90** (processeurs 286/386/486, cadencés de quelques MHz à quelques dizaines de MHz), en mode graphique **VGA** : 320×200 pixels en 256 couleurs, la mémoire vidéo étant écrite directement par le programme. À titre de comparaison, un Mac M4 actuel exécute plusieurs milliers de fois plus d'opérations par seconde, avec des milliers de fois plus de mémoire, et dispose d'un processeur graphique dédié. À l'époque, il n'y avait ni GPU, ni accélération 3D : chaque pixel était calculé par le processeur.

Pour tenir 20 à 30 images par seconde dans ces conditions, les sources combinent plusieurs langages :
- **Pascal** (Turbo Pascal) pour la structure du programme, la grande majorité du code ;
- **assembleur x86** pour les boucles critiques (affichage, remplissage de polygones, effets de palette) ;
- un peu de **C**.

On évitait les calculs coûteux : tables de sinus précalculées, arithmétique entière en virgule fixe plutôt que flottante, animation des couleurs par la palette plutôt que par le redessin de l'image. C'est ce qui explique le lien avec les articles de maths de ce dépôt.




## Contenu du repo 

MALOREAN_JS
- portage en HTML/JavaScript des démo
  - Consultable [en ligne](https://claude.ai/artifact/LR7wHQjS4YWbaKbsEe1vQH)
- Articles sur les concepts méthématiques utilisés pour réaliser les démo 
- Galerie d'image produite 


Docs 
- [Articles sur les mathématiques utilisées pour els démos](docs/mathematiques-des-demos.md)

