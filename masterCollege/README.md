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
- ~~Lorsque le manuel est complet, dans chaque chapitre incChapitre*.tex mettre à jour le numéro de page ad hoc en modifiant la valeur de n dans la commande \setcounter{page}{n}.~~
- Dans chaque grand thème, il y a un chapitre témoin à copier/coller pour ajouter d'autres chapitres. Penser à :
    - Modifier la commande \def\currentpath{./N1} de façon ad hoc
    - ~~Supprimer l'ajout à la table des matière du bandeau qui ne doit être présent que dans le premier chapitre d'un thème. (fix interaction include et toc)~~
- Pour un chapitre, le contenu de chaque sous-partie, prerequis, activités, cours, exercices, TP ... est découpé dans des fichiers distincts. Par exemple pour le cours, on inclut les fichiers coursSection001.tex, coursSection002.tex , ... On peut rendre les noms plus explicites !
- Chaque chapitre est compilable séparément dans son dossier via le fichier **MasterCollegeChapitreComplet.tex**. Une fois finalisé, il suffit de l'ajouter au fichier du manuel complet.