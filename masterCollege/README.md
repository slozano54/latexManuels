Ce dossier contient un master pour la réalisation d'un manuel de college avec la classe [sesamanuel de l'association sesamath](https://www.ctan.org/pkg/sesamanuel) en incluant le paquet [ProfCollege de Christophe POULAIN](https://ctan.org/pkg/profcollege).

> Le mode de compilation à utiliser est exclusivement LuaLaTeX pour l'utilisation de certaines commandes du paquet **ProfCollege**.

# Objectifs

- Parametrages de la classe dans le fichier **0persoConfigClasseSesamanuel.tex**.
- Commandes personnelles et paquets supplémentaires dans le fichier **0persoCommandes.tex**.
- Un document global compilable avec tous les chapitres.
- Chaque chapitre doit être compilable séparément.
- Code source commenté.

# Remarques 

- Compilation obligatoire en mode luaLaTeX
- Après modification des contenus et avant compilation, il faudra vider les dossiers corrections/
- Lorsque le manuel est complet, dans chaque chapitre incChapitre*.tex mettre à jour le numéro de page ad hoc 
en modifiant la valeur de n dans la commande \setcounter{page}{n}.
- Dans chaque grand thème, il y a un chapitre témoin à copier/coller pour ajouter d'autres chapitres.
    - Penser à modifier la commande \def\currentpath{./N1} de façon ad hoc