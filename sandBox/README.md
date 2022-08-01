# Découverte de la classe sesamanuel

- Je récupère le fichier de classe **sesamanuel.cls** originale de ma TexLive2022
- Je répercute les modifications faites par Christophe POULAIN sur cette classe pour permettre de compiler avec **luaLaTeX**
- Je commence la lecture de la [documentation du paquet sesamanuel](https://distrib-coffee.ipsl.jussieu.fr/pub/mirrors/ctan/macros/latex/contrib/sesamanuel/sesamath-doc-fr.pdf)

## Correctifs

- Lorsqu'on utilise la commande **\newThema** le compteur de chapître n'était pas initialisé, je modifie donc la classe cf [commit 36181c2](https://github.com/slozano54/latexManuels/commit/36181c2adbd5b45d925bc58a936daf7dfc941a00)

# Découverte du paquet profcollege

Tant que la dernière maj n'est pas accessible dans la TexLive, il faut ajouter manuellement le paquet **ProfCollegeNewCAN**

## Ajout manuel à ma distribution latex TexLive2022

Les commandes suivantes s'entendent pour un système sous Linux, sous d'autres systèmes Unix les commandes doivent être approximativement les mêmes.

- On crée l'arborescence **/usr/local/texlive/texmf-local/tex/latex** si elle n'existe pas.

On peut supposer que **/usr/local/texlive** existe si TexLive est en place.

- On crée le dossier pour accueillir le paquet temporaire  **ProfCollegeNewCAN.sty**

```bash
sudo mkdir /usr/local/texlive/texmf-local/tex/latex/ProfCollegeNewCAN
```

- On se place dans le repertoire contenant le paquet temporaire  **ProfCollegeNewCAN.sty**

```bash
sudo cp ProfCollegeNewCAN.sty /usr/local/texlive/texmf-local/tex/latex/ProfCollegeNewCAN/ProfCollegeNewCAN.sty
```

- On met à jour la liste des paquets

```bash
sudo mktexlsr
```


