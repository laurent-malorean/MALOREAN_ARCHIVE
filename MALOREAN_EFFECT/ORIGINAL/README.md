# ORIGINAL : archives d'origine

```
DEMO/
  <nom de la démo>/
    code/        sources (Pascal, assembleur, archives)
    build/       exécutables et fichiers de lancement
    ressources/  données, images, musique, notices
CODE hors demo/
  CODE.PAS/ …    essais Pascal (une quarantaine de dossiers)
  CODE.ASM, CODE.C, GRAPH, UNIT.PAS, STRANGE, MUSIC, …
  Image/         fractales GIF et images
```

Archives d'origine, dédupliquées (issues de l'ancien dossier `malorean effect/MALOREAN/`) : chaque contenu n'existe qu'une fois ; `DOUBLONS.tsv` liste les copies omises et le fichier conservé.

| Démo | code | build | ressources |
|---|---:|---:|---:|
| [Mathematica 1](DEMO/MAT_1/README.md) | 19 | 2 | 1 |
| [Mathematica 2](DEMO/MAT_2/README.md) | 6 | 3 | 9 |
| [Mathematica 3](DEMO/MAT_3/README.md) | 1 | 1 | 6 |
| [Mathematica 5](DEMO/MAT_5/README.md) | 1 | 1 | 2 |
| [Mathematica 6](DEMO/MAT_6/README.md) | 6 | 0 | 8 |
| [All Over The World (Malorean)](DEMO/ALL_OVER/README.md) | 4 | 5 | 6 |
| [Kashmir](DEMO/KASHMIR/README.md) | 0 | 0 | 28 |
| [Belladone : Posseded To 3D](DEMO/BELLADONE/README.md) | 0 | 2 | 12 |
| [The Come Back of SuperCustard Tart](DEMO/FLAN/README.md) | 0 | 1 | 1 |
| [Fortune plango vulnera](DEMO/FORTUNE/README.md) | 0 | 1 | 2 |

`CODE hors demo/` : 798 fichiers. Total : 936 fichiers uniques (+ ce README et les READMEs de démos).

Notes : MAT_4 n'a ni build ni source (dossiers vides dans l'archive) ; l'exécutable de MAT_6 manque ; Strange et Cube n'ont pas de dossier de démo (formules dans `CODE hors demo/STRANGE/`, cube dans `CODE hors demo/CODE.PAS/3D/`) ; `DEMO/FORTUNE/ressources/FORTUNE_decompresse.bin` est `FORTUNE.EXE` déballé par `PORTAGE_JS/tools/unpklite.py`, pas un original.
