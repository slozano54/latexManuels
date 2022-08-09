# Découverte de la classe sesamanuel

- Je récupère le fichier de classe **sesamanuel.cls** originale de ma TexLive2022
- Je répercute les modifications faites par Christophe POULAIN sur cette classe pour permettre de compiler avec **luaLaTeX**
- Je commence la lecture de la [documentation du paquet sesamanuel](https://distrib-coffee.ipsl.jussieu.fr/pub/mirrors/ctan/macros/latex/contrib/sesamanuel/sesamath-doc-fr.pdf)

## Correctifs

- Lorsqu'on utilise la commande **\newThema** le compteur de chapitre n'était pas initialisé, je modifie donc la classe cf [commit 36181c2](https://github.com/slozano54/latexManuels/commit/36181c2adbd5b45d925bc58a936daf7dfc941a00)

- Les fonts étaient différentes lors d'une compilation lualatex, cf [commit 10a97e9](https://github.com/slozano54/latexManuels/commit/10a97e90fe3772c65146946fff29a5cd6b640eed)

- Fix problème de nom de variable dans des boucles
    - ChoixQCM cf [commit b379a6f](https://github.com/slozano54/latexManuels/commit/b379a6f8dd92194172176bd0f636a4381cbd7689)    
    - \DeclareColItemize et \DeclareColEnumerate cf [commit 96b25f4](https://github.com/slozano54/latexManuels/commit/96b25f4f8fcadbf8ada9fd1ebf692856174af66a)

- Prise en compte de la numérotation des corrigés des enigmes cf [commit 9b07eef](https://github.com/slozano54/latexManuels/commit/9b07eef0262a0510217ee1f1ce54ab0d94bf390b)

- Fix Problème de compilation lualatex avec la commande \pdfstrcmp cf [commit ff60cd8](https://github.com/slozano54/latexManuels/commit/ff60cd8d1fe36199fd1cc87f5afa0108279f4674)

# Découverte du paquet profcollege

- Mise à jour du paquet le 3 aout 2022 donc mise à jour locale avec :
```bash
tlmgr update profcollege

mktexlsr # juste pour être sûr !
```
