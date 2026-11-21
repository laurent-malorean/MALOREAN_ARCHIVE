# Outils de rétro-ingénierie

Ces scripts ont servi à lire les `.EXE` dont le source Pascal n'a pas été retrouvé. Ils demandent `capstone` et `unicorn` (`pip install capstone unicorn`, de préférence dans un venv).

* `disasm16.py <exe> <offset_hex> <n>` : désassemble `n` instructions 16 bits d'un `.EXE` MZ à partir d'un offset dans l'image (après l'en-tête).
* `disraw.py <fichier> <offset_hex> <n>` : idem pour un fichier brut (image déballée).
* `unpklite.py <exe> <sortie>` : décompresse un `.EXE` PKLITE en émulant son décompresseur (unicorn) jusqu'à l'entrée du programme d'origine ; écrit la mémoire à partir du PSP. L'image déballée commence à l'offset 0x100 de la sortie.
* `pas2js.py <DEM2.PAS> <sortie.js>` : traducteur Pascal vers JavaScript des procédures d'effets de MAT_2.

`FORTUNE_decompresse.bin` (dans `DEMO/FORTUNE/`) est l'image déballée de `FORTUNE.EXE` : le programme commence à l'offset 0x4720 (initialisation de Turbo Pascal), la procédure d'effet à l'offset 0x516.
