> Ceci est le fichier `README.md` du paquetage LaTeX
> `formation-latex-ul`. Les noms de répertoires ci-dessous sont ceux
> du paquetage et non ceux du dépôt.
>
> Le paquetage est distribué via
> [CTAN](https://www.ctan.org/pkg/formation-latex-ul).
>
> La
> [page du projet](https://vigou3.github.io/formation-latex-ul)
> fournit de l'information plus détaillée sur le paquetage.

# formation-latex-ul

Package **formation-latex-ul** contains the supporting documentation,
slides, exercise files and templates for an introductory LaTeX course
(in French) prepared for Université Laval, Québec, Canada.

## License

Creative Commons Attribution-ShareAlike 4.0 International.

## Author

Vincent Goulet <vincent.goulet@act.ulaval.ca>

> The rest of this file is in French for the target audience.

# formation-latex-ul

Le paquetage **formation-latex-ul** propose une formation à
l'utilisation de LaTeX développée pour la Bibliothèque de
l'[Université Laval](https://www.ulaval.ca).

La formation est formée des éléments suivants:

1. *Rédaction avec LaTeX*, un document de référence de près de
   200 pages; voir le fichier `doc/formation-latex-ul.pdf`;

2. des diapositives pour une formation en classe couvrant grosso modo
   les quatre premiers chapitres du document de référence; voir le
   fichier `doc/formation-latex-ul-diapos.pdf`;

3. les fichiers nécessaires pour compléter certains exercices, ainsi
   qu'un gabarit pour composer les solutions des autres exercices; voir
   le dossier `doc/`.

Les quatre premiers chapitres du document de référence couverts par
les diapositives traitent des concepts de base pour un nouvel
utilisateur de LaTeX: processus d'édition, compilation, visualisation;
séparation du contenu et de l'apparence du texte; mise en forme du
texte; séparation du document en parties; rudiments du mode
mathématique.

Les six autres chapitres du document de référence visent à rendre
l'utilisateur de LaTeX débutant ou intermédiaire autonome dans la
rédaction de documents relativement complexes comportant des tableaux,
des figures, des équations mathématiques élaborées, une bibliographie,
etc.

## Composition des documents

Le dossier `source/` contient tous les fichiers nécessaires pour
composer le document principal et les diapositives avec XeLaTeX. Ceci
requiert toutefois les polices de caractères suivantes:

  Lucida Bright OT
  Lucida Bright Math
  Lucida Grande Mono DK
  Adobe Myriad Pro
  Font Awesome

Les trois polices Lucida sont payantes et distribuées par le TeX Users
Group: https://tug.org/lucida. La police Myriad Pro est livrée avec
Acrobat Reader. La police Font Awesome est disponible gratuitement
dans le site http://fontawesome.io. Prendre soin d'utiliser la version
TrueType pour éviter que les symboles ne soient redimensionnés à
l'écran ou à l'impression.

## Historique des versions

### (en développement)

#### Diapositives

Révision des diapositives suite à une formation avec la version
2018.03-0. Il y avait toujours un peu trop de matériel. Les
changements par rapport à la version officielle précédente (2016.11-3)
sont donc:

- Diapositives complètement révisées en vue d'une formation de 120
  minutes plutôt que 180.
- Diapositives dans le thème Metropolis et en format 16 x 10.
- Nouvelles diapositives sur les tableaux.
- Nouvelles diapositives sur la programmation lettrée avec Sweave.
- Exercice sur les mathématiques.

### 2018.03-0 (2018-03-20)

> Version «bêta» (d'où le -0) uniquement publiée dans GitHub pour une
> formation à l'École d'actuariat.

#### Document de référence

- Sections 1.2 et 1.3 inversées.
- Correction de la ligature des tirets dans le premier paragraphe de
  la section 10.2.

#### Diapositives

- Diapositives complètement révisées en vue d'une formation plus
  courte: 90 minutes au lieu de 180.
- Diapositives dans le thème Metropolis et en format 16 x 10.
- Nouvelles diapositives sur les tableaux.
- Nouvelles diapositives sur la programmation lettrée avec Sweave.

### 2016.11-3

- Liens vers le code source modifiés suite au déplacement du projet
  vers [Github](https://github.com/vigou3/formation-latex-ul).
- Correction du numéro de version dans les documents PDF.

### 2016.11-2

- Incorporation des sources du document principal et des diapositives
  dans la distribution tel que requis par TeX Live.
- Retouches au fichier `README`.

### 2016.11-1

- Mise à jour des URL vers les vidéos dans YouTube. Celles-ci ont été
  refaites avec le nouveau visuel de couverture.
- Ajout d'un exercice au chapitre 1 tiré des pré-requis de la
  formation, soit composer un document simple de type «Hello, World!».
  Liens vers les vidéos explicatives dans YouTube.

### 2016.11

- Importante refonte de la documentation en un document unique. Les
  diapositives ne sont plus qu'un support visuel pour la formation qui
  couvre grosso modo les quatre premiers chapitre de l'ouvrage de
  référence.
- Nouveau visuel des couvertures. Trop cuuuute.
- Nouveau mode de numérotation des versions.

### 2016-04-04

- Fichier `exercice_demo.tex`: utilisation du style de bibliographie
  `plainnat` puisque le paquetage **francais-bst** ne fait pas partie de la
  distribution standard de TeX Live 2015.
- Fichiers d'exercices: utilisation systématique des options `og` et
  `fg` dans `\frenchbsetup`.

### 2016-03-24

- Partie I: révision des diapositives pour baser davantage la
  présentation sur des exemples de code source.
- Partie I: ajout d'images dans les diapos.
- Partie I: correction du fichier `exemple_demo.tex` qui ne compilait
  pas correctement.
- Partie II: ajout d'une introduction au chapitre 7 (tous les autres
  en avaient une) ainsi qu'une nouvelle section 7.1 sur le contrôle
  des sauts de ligne, sauts de page et coupures de mots.
- Partie II: corrections mineures à l'index.
- Fichiers d'exercices et gabarits: langue déclarée comme `french`
  plutôt que `francais` et dans `\documentclass` plutôt que dans
  `\usepackage`.
- Fichiers d'exercices et gabarits: chargement du paquetage icomma
  déplacé vers la fin de la liste, plus particulièrement après
  fontspec.

### 2015-03-18

- Première publication sur CTAN.
