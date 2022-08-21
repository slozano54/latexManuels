Ce dossier contient un master pour la réalisation d'un manuel de college avec la classe [sesamanuel de l'association sesamath](https://www.ctan.org/pkg/sesamanuel) en incluant le paquet [ProfCollege de Christophe POULAIN](https://ctan.org/pkg/profcollege).

> Le mode de compilation à utiliser est exclusivement LuaLaTeX pour l'utilisation de certaines commandes du paquet **ProfCollege**.

# Objectifs

- Parametrages de la classe dans le fichier **0persoConfigClasseSesamanuel.tex**.
- Commandes personnelles et paquets supplémentaires dans le fichier **0persoCommandes.tex**.
- Un document global compilable avec tous les chapitres.
- Chaque chapitre doit être compilable séparément.
- Un chapitre témoin pour chaque thème reprenant toutes les possibilités de la classe
- Code source commenté.

# Remarques 

- J'ai essayé d'utiliser un maximum de commandes mais il est toujours judicieux de consulter les documentations :
    - De la classe [sesamuel](https://texlive.mycozy.space/macros/latex/contrib/sesamanuel/sesamath-doc-fr.pdf)
    - Du paquet [ProfCollege](https://ctan.mines-albi.fr/macros/latex/contrib/profcollege/doc/ProfCollege-doc.pdf)
- Compilation obligatoire en mode luaLaTeX
- Après modification des contenus et avant compilation, il faudra vider les dossiers corrections/
- Dans chaque grand thème, il y a un chapitre témoin à copier/coller pour ajouter d'autres chapitres.
- Pour un chapitre, le contenu de chaque sous-partie, prerequis, activités, cours, exercices, TP ... est découpé dans des fichiers distincts. Par exemple pour le cours, on inclut les fichiers coursSection001.tex, coursSection002.tex , ... On peut rendre les noms plus explicites !
- Chaque chapitre est compilable séparément dans son dossier via le fichier **MasterCollegeChapitreComplet.tex**. Une fois finalisé, il suffit de l'ajouter au fichier du manuel complet.
- Annexes
    - Interdictions a priori :
        - L'environnement "corrige" --> en déhors de certains envirronnements
        - La commande \partie en dehors d'un exercice
    - On peut changer les couleurs des annexes avec \ChangeAnnexe{}{}{}{} :
        - Attention il faut mettre cette commande avant le premier appel à \annexe{} sinon ça change toutes les annexes sauf la première !
        - L'appel par défaut est \ChangeAnnexe{G3}{A1}{G1}{Blanc}

# Arborescence
> Lancer la commande tree dans le répertoire pour récupérer l'arborescence et la copier ici.

## Fichiers du dépot

```bash
├── documentations                  # No comment
├── images                          # No comment
├── masterCollege                   # Dossier du masterCollege
│   ├── A1                          # Chapitre témoin d'Algorithmique
│   │   ├── A1                      # Pour regrouper les fichiers de structure du chapitre
│   │   │   ├── images              # No comment
│   │   │   └── inc                 # Pour regrouper les fichiers du chapitre
│   │   └── corrections             # Pour récupérer les fichiers de correction générés du chapitre
│   ├── corrections                 # Pour récupérer les fichiers de correction générés du manuel complet
│   ├── couverture                  # No comment
│   │   └── images                  # No comment
│   ├── D1                          # Chapitre témoin de Gestion de données
│   │   ├── corrections
│   │   └── D1
│   │       ├── images
│   │       └── inc
│   ├── dedicaces                   # Fichiers pour les dédicaces
│   ├── G1                          # Chapitre témoin de Géométrie
│   │   ├── corrections
│   │   └── G1
│   │       ├── images
│   │       └── inc
│   ├── glossaireProprietes         # Fichiers pour le glossaire de propriétés
│   │   └── glossaireProprietes
│   │       ├── images
│   │       └── inc
│   ├── images                      # No comment
│   ├── introduction                # Fichiers pour le chapitre d'introduction
│   │   └── introduction
│   ├── lexique                     # Fichiers pour le lexique
│   │   └── lexique
│   ├── M1                          # Chapitre témoin de Mesures et grandeurs
│   │   ├── corrections
│   │   └── M1
│   │       ├── images
│   │       └── inc
│   ├── N1                          # Chapitre témoin de Numérique
│   │   ├── corrections
│   │   └── N1
│   │       ├── images
│   │       └── inc
│   ├── remerciements               # Fichiers pour les remerciements
│   ├── resume                      # Fichiers pour le résumé
│   └── tocs                        # Fichiers pour le sommaire
└── sandBox                         # Dossier Bac à sable, ne sert pas pour un manuel
    ├── corrections
    ├── fixCorrigeEnigmeCorrections
    └── images
```

## Fichiers du dossier masterCollege
Pour faire un nouveau manuel, il suffit de copier ce dossier et de modifier/ajouter le/du contenu.

### Arborescence

```bash
./masterCollege
├── A1                          # Chapitre témoin d'Algorithmique
│   ├── A1                      # Pour regrouper les fichiers de structure du chapitre
│   │   ├── images              # No comment
│   │   └── inc                 # Pour regrouper les fichiers du chapitre
│   └── corrections             # Pour récupérer les fichiers de correction générés du chapitre
├── corrections                 # Pour récupérer les fichiers de correction générés du manuel complet
├── couverture                  # No comment
│   └── images                  # No comment
├── D1                          # Chapitre témoin de Gestion de données
│   ├── corrections
│   └── D1
│       ├── images
│       └── inc
├── dedicaces                   # Fichiers pour les dédicaces
├── G1                          # Chapitre témoin de Géométrie
│   ├── corrections
│   └── G1
│       ├── images
│       └── inc
├── glossaireProprietes         # Fichiers pour le glossaire de propriétés
│   └── glossaireProprietes
│       ├── images
│       └── inc
├── images                      # No comment
├── introduction                # Fichiers pour le chapitre d'introduction
│   └── introduction
├── lexique                     # Fichiers pour le lexique
│   └── lexique
├── M1                          # Chapitre témoin de Mesures et grandeurs
│   ├── corrections
│   └── M1
│       ├── images
│       └── inc
├── N1                          # Chapitre témoin de Numérique
│   ├── corrections
│   └── N1
│       ├── images
│       └── inc
├── remerciements               # Fichiers pour les remerciements
├── resume                      # Fichiers pour le résumé
└── tocs                        # Fichiers pour le sommaire
```

### Détails pour un chapitre
Pour chaque chapitre, la structure est la même, le détail pour le chaptire témoin A1.

```bash
.A1
├── A1                                                  # Pour regrouper les fichiers de structure du chapitre 
│   ├── images                                          # No comment                    
│   ├── inc                                             # Pour regrouper les fichiers du chapitre
│   │   ├── activite001.tex
│   │   ├── activite002.tex
│   │   ├── activite003.tex
│   │   ├── activite004.tex
│   │   ├── activite005.tex
│   │   ├── annexe001.tex
│   │   ├── annexe002.tex
│   │   ├── annexe003.tex
│   │   ├── autoeval001.tex
│   │   ├── autoeval002.tex
│   │   ├── connaissancesAcquis001.tex
│   │   ├── connaissancesGpre001EnonceCommun.tex
│   │   ├── connaissancesGpre001Exo001.tex
│   │   ├── connaissancesGpre001Exo002.tex
│   │   ├── connaissancesGpre001Exo003.tex
│   │   ├── connaissancesGpre001Exo004.tex
│   │   ├── connaissancesGpre002EnonceCommun.tex
│   │   ├── connaissancesGpre002Exo001.tex
│   │   ├── connaissancesGpre002Exo002.tex
│   │   ├── connaissancesGpre002Exo003.tex
│   │   ├── connaissancesGpre002Exo004.tex
│   │   ├── coursSection001.tex
│   │   ├── coursSection002.tex
│   │   ├── exosAppr001.tex
│   │   ├── exosAppr002.tex
│   │   ├── exosAppr003.tex
│   │   ├── exosAppr004.tex
│   │   ├── exosAppr005.tex
│   │   ├── exosAppr006.tex
│   │   ├── exosBase001.tex
│   │   ├── exosBase002.tex
│   │   ├── exosBase003.tex
│   │   ├── exosBase004.tex
│   │   ├── exosBase005.tex
│   │   ├── exosBase006.tex
│   │   ├── exosEnigme001.tex
│   │   ├── exosEnigme002.tex
│   │   ├── exosEnigmePostTP001.tex
│   │   ├── exosEnigmePostTP002.tex
│   │   ├── prerequis001.tex
│   │   ├── travauxPratiques001.tex
│   │   ├── travauxPratiques002.tex
│   │   └── travauxPratiques003.tex
│   ├── incActivites.tex                                # Pour les appels des fichiers d'activités
│   ├── incAnnexes.tex                                  # Pour les appels des fichiers d'annexe
│   ├── incChapitre.aux                                 # Généré à la compilation pour les fichiers appelés via \include{}
│   ├── incChapitre.tex                                 # Pour les appels des fichiers du chapitre
│   ├── incConnaissances.tex                            # Pour les appels des fichiers de tests de connaissances, QCM ...
│   ├── incCours.tex                                    # Pour les appels des fichiers de cours
│   ├── incExosApprofondissement.tex                    # Pour les appels des fichiers d'exos d'approfondissement
│   ├── incExosBase.tex                                 # Pour les appels des fichiers d'exos de base    
│   ├── incPrerequis.tex                                # Pour les appels des fichiers de prérequis
│   ├── incRecreationPostTP.tex                         # Pour les appels des fichiers de récréation post TP
│   ├── incRecreation.tex                               # Pour les appels des fichiers de récréation
│   └── incTravauxPratiques.tex                         # Pour les appels des fichiers de TP
├── corrections                                         # Dossier contenant les corrections générées automatiquement à la compilation
│   ├── corr-AE-A1-1.tex
│   ├── corr-AE-A1-2.tex
│   ├── corr-ExoAppr-A1-12.tex
│   ├── corr-ExoAppr-A1-8.tex
│   ├── corr-ExoBase-A1-2.tex
│   ├── corr-ExoBase-A1-6.tex
│   ├── corr-QCM-A1-15.tex
│   ├── corr-QCM-A1-16.tex
│   ├── corr-QCM-A1-17.tex
│   ├── corr-QCM-A1-18.tex
│   ├── corr-QCM-A1-19.tex
│   ├── corr-QCM-A1-20.tex
│   ├── corr-QCM-A1-21.tex
│   ├── corr-QCM-A1-22.tex
│   ├── corr-Recreation-A1-13.tex
│   ├── corr-Recreation-A1-14.tex
│   └── emptyFile.txt                                   # Fichier vide pour que le dossier corrections existe sur GitHub
├── masterCollegeA1Complet.aux                          # Fichier de compilation
├── masterCollegeA1Complet.cor                          # Fichier de compilation
├── masterCollegeA1Complet.fdb_latexmk                  # Fichier de compilation
├── masterCollegeA1Complet.fls                          # Fichier de compilation
├── masterCollegeA1Complet.log                          # Fichier de compilation
├── masterCollegeA1Complet.loma                         # Fichier de compilation
├── masterCollegeA1Complet.out                          # Fichier de compilation
├── masterCollegeA1Complet.pdf                          # Fichier PDF
├── masterCollegeA1Complet.synctex.gz                   # Fichier de compilation
└── masterCollegeA1Complet.tex                          # Fichier source
```

# Aide-mémoire, tentative de tutos
## Ajouter un nouveau chapitre avant inclusion au manuel complet

Consulter la vidéo `./documentations/masterCollegeAjouterUnChapitre.mp4`.

Ou suivre ces instructions, on note **nouveauChapitre** le nom du nouveau chapitre :
- Copier/Coller un dossier du même thème.
- Renommer les dossiers en fonction, **ancienChapitre** devient **nouveauChapitre**. 
- Renommer les inclusions faisant référence au chapitre dans :
    - `./nouveauChapitre/nouveauChapitre/incChapitre.tex`
    - `./nouveauChapitre/masterCollegeNouveauChapitreComplet.tex`
- Supprimer le contenu du dossier `./nouveauChapitre/corrections` sauf `emptyFile.txt`
- Supprimer tous les fichiers de compilation y compris le pdf.
- Compiler le fichier `./nouveauChapitre/masterCollegeNouveauChapitreComplet.tex` en mode lualatex
- Modifier le contenu du nouveau chapitre !

## Ajouter un nouveau chapitre au manuel complet

Consulter la vidéo `./documentations/masterCollegeAjouterUnChapitreAuManuelComplet.mp4`.

Ou suivre ces instructions, on note **nouveauChapitre** le nom du nouveau chapitre  :
- Ouvrir le fichier `./masterCollegeComplet.tex`
- Dans la zone du thème du nouveau chapitre ajouter ces deux lignes :

```tex
    \def\currentpath{./nouveauChapitre/nouveauChapitre}   % On définit le répertoire courant    
    \include{\currentpath/incChapitre.tex}                % On inclut le chapitre nouveauChapitre
```
- Compiler le fichier `./masterCollegeComplet.tex` en mode lualatex.