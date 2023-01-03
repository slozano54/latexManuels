<!--
*** To avoid retyping too much info. Do a search and replace for the following:
*** github_username, repo_name, twitter_handle, email, project_title, project_description
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/slozano54/latexManuels">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">MANUELS</h3>

  <p align="center">
    Des essais avec la classe <a href="https://www.ctan.org/pkg/sesamanuel">sesamanuel</a>, avec le paquet <a href="https://www.ctan.org/pkg/profcollege">profcollege</a> .
    <br />
    Une trame vide pour démarrer.
    <br />
    Proposition d'un partage de mes cours dans un format "manuels" pour le collège.
    <br />
    <a href="https://github.com/slozano54/latexManuels"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/slozano54/latexManuels/issues">Report Bug</a>
    ·
    <a href="https://github.com/slozano54/latexManuels/issues">Request Feature</a>
  </p>
</p>

<!-- DOSSIER masterCollege -->
## Dossier ./masterCollege
Proposition de maquette vide pour un manuel de college
<a href="https://github.com/slozano54/latexManuels/blob/master/masterCollege/README.md">README.md du dossier ./masterCollege</a>

Ce dossier peu être copier et son contenu adapté pour la réalisation d'un nouveau manuel. 

Consulter le <a href="https://github.com/slozano54/latexManuels/blob/master/masterCollege/README.md">README.md</a> du dossier pour plus d'informations.

<!-- DOSSIER mloz3e2022 -->
## Dossier ./mloz3e2022
Dossier du manuel de 3e
<!-- DOSSIER mloz4e2022 -->
## Dossier ./mloz4e2022
Dossier du manuel de 4e
## Découverte de la classe sesamanuel

- Je récupère le fichier de classe **sesamanuel.cls** originale de ma TexLive2022
- Je répercute les modifications de Christophe POULAIN sur cette classe pour permettre de compiler avec **luaLaTeX**
- Je commence la lecture de la [documentation du paquet sesamanuel](https://distrib-coffee.ipsl.jussieu.fr/pub/mirrors/ctan/macros/latex/contrib/sesamanuel/sesamath-doc-fr.pdf)

### Correctifs et ajouts

- Pour rechercher les ajouts et modifications dans le fichier de classe sesamanuel faire une recherche avec **AjoutSeb** dans le fichier **sesamanuel.cls**

- Lorsqu'on utilise la commande **\newThema** le compteur de chapitre n'était pas initialisé, je modifie donc la classe cf [commit 36181c2](https://github.com/slozano54/latexManuels/commit/36181c2adbd5b45d925bc58a936daf7dfc941a00)

- Les fonts étaient différentes lors d'une compilation lualatex, cf [commit 10a97e9](https://github.com/slozano54/latexManuels/commit/10a97e90fe3772c65146946fff29a5cd6b640eed)

- Fix problème de nom de variable dans des boucles
    - ChoixQCM cf [commit b379a6f](https://github.com/slozano54/latexManuels/commit/b379a6f8dd92194172176bd0f636a4381cbd7689)    
    - \DeclareColItemize et \DeclareColEnumerate cf [commit 96b25f4](https://github.com/slozano54/latexManuels/commit/96b25f4f8fcadbf8ada9fd1ebf692856174af66a)

- Prise en compte de la numérotation des corrigés des enigmes cf [commit 9b07eef](https://github.com/slozano54/latexManuels/commit/9b07eef0262a0510217ee1f1ce54ab0d94bf390b)

- Fix Problème de compilation lualatex avec la commande \pdfstrcmp cf [commit ff60cd8](https://github.com/slozano54/latexManuels/commit/ff60cd8d1fe36199fd1cc87f5afa0108279f4674)

- Compilation LuaTeX obligatoire cf [commit 5215698](https://github.com/slozano54/latexManuels/commit/5215698bf9c59378ff75c69f7b2fef8462818dfc)

## Découverte du paquet profcollege

Initialement dans le dossier **sandBox**, le paquet est très pratique et Christophe POULAIN fait des mises à jour régulièrment.

Pour mettre à jour uniquement ce paquet de votre TexLive via tlmgr :
```bash
sudo tlmgr update profcollege
```

Pour lister tous les paquets de votre TexLive pouvant être mis à jour via tlmgr :
```bash
tlmgr update -list
```


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- LICENSE -->
## License

Distributed under the CC BY-NC-SA 4.0 License. See `LICENSE` for more information.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/slozano54/latexManuels.svg?style=for-the-badge
[contributors-url]: https://github.com/slozano54/latexManuels/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/slozano54/latexManuels.svg?style=for-the-badge
[forks-url]: https://github.com/slozano54/latexManuels/network/members
[stars-shield]: https://img.shields.io/github/stars/slozano54/latexManuels.svg?style=for-the-badge
[stars-url]: https://github.com/slozano54/latexManuels/stargazers
[issues-shield]: https://img.shields.io/github/issues/slozano54/latexManuels.svg?style=for-the-badge
[issues-url]: https://github.com/slozano54/latexManuels/issues
[license-shield]: https://img.shields.io/github/license/slozano54/latexManuels?style=for-the-badge
[license-url]: https://github.com/slozano54/latexManuels/blob/master/LICENSE.txt
