# Découverte de la classe sesamanuel

- Je récupère le fichier de classe **sesamanuel.cls** originale de ma TexLive2022
- Je répercute les modifications faites par Christophe POULAIN sur cette classe pour permettre de compiler avec **luaLaTeX**
- Je commence la lecture de la [documentation du paquet sesamanuel](https://distrib-coffee.ipsl.jussieu.fr/pub/mirrors/ctan/macros/latex/contrib/sesamanuel/sesamath-doc-fr.pdf)

## Correctifs

- Lorsqu'on utilise la commande **\newThema** le compteur de chapitre n'était pas initialisé, je modifie donc la classe cf [commit 36181c2](https://github.com/slozano54/latexManuels/commit/36181c2adbd5b45d925bc58a936daf7dfc941a00)

# Découverte du paquet profcollege

- Mise à jour du paquet le 3 aout 2022 donc mise à jour locale avec :
```bash
tlmgr update profcollege

mktexlsr # juste pour être sûr !
```
