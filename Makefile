## Prendre le numéro de version dans le fichier Makeconf
include ./Makeconf

## Nom du paquetage sur CTAN
PACKAGENAME = formation-latex-ul

## Fichiers maîtres
MASTER = formation-latex-ul.pdf
MASTERDIAPOS = formation-latex-ul-diapos.pdf

## Liste des autres fichiers source du document principal
TEXFILES = licence.tex \
	introduction.tex     \
	modedemploi.tex      \
	include.tex          \
	boites.tex           \
	tableaux+figures.tex \
	mathematiques.tex    \
	bibliographie.tex    \
	commandes.tex        \
	trucs.tex            \
	solutions.tex        \
	colophon.tex

## Liste des autres fichiers source des diapositives
TEXFILESDIAPOS = licence-diapos.tex \
	colophon-diapos.tex

## Liste des fichiers à inclure dans l'archive pour les exercices du
## document principal
FILES = ${MASTER} \
	ul_p.pdf \
	exercice_gabarit.tex \
	exercice_include.tex \
		includes/pagetitre.tex \
		includes/presentation.tex \
		includes/console-screenshot.pdf \
		includes/emacs.tex \
	exercice_subcaption.tex \
	exercice_demo.tex \
	exercice_mathematiques.tex \
	exercice_trucs.tex \
	formation-latex-ul.bib

## Liste des fichiers à inclure dans l'archive pour les exercices de
## la formation en classe
FILESDIAPOS = ${MASTERDIAPOS} \
	exercice_minimal.tex \
	exercice_demo.tex \
	exercice_commandes.tex \
	exercice_classe+paquetages.tex \
	exercice_parties.tex \
	exercice_renvois.tex \
	exercice_complet.tex \
	exercice_ulthese.tex \
		includes/mathematiques.tex \
	formation-latex-ul.bib

SOLUTIONSDIAPOS = \
	exercice_commandes-solution.tex \
	exercice_classe+paquetages-solution.tex \
	exercice_parties-solution.tex \
	exercice_renvois-solution.tex \
	exercice_complet-solution.tex \
	exercice_ulthese-solution.tex

# Outils de travail
TEXI2DVI = LATEX=xelatex TEXINDY=makeindex texi2dvi -b
RM = rm -r

.PHONY: pdf zip clean

pdf : $(MASTER) $(MASTERDIAPOS)

$(MASTER): $(MASTER:.pdf=.tex) $(TEXFILES)
	$(TEXI2DVI) $(MASTER:.pdf=.tex)

$(MASTERDIAPOS): $(MASTERDIAPOS:.pdf=.tex) $(TEXFILESDIAPOS)
	$(TEXI2DVI) $(MASTERDIAPOS:.pdf=.tex)

zip : ${FILES} ${SOLUTIONS} ${FILESDIAPOS} ${SOLUTIONSDIAPOS}
	if [ -d ${PACKAGENAME} ]; then ${RM} ${PACKAGENAME}; fi
	mkdir ${PACKAGENAME}
	sed -e 's/<VERSION>/${VERSION}/g' README.in > README
	cp README ${FILES} ${SOLUTIONS} ${FILESDIAPOS} ${SOLUTIONSDIAPOS} ${PACKAGENAME}
	zip --filesync -r ${PACKAGENAME}.zip ${PACKAGENAME}
	${RM} ${PACKAGENAME}

clean:
	$(RM) *.aux *.log *.blg *.bbl *.out *.ilg *.idx *.ind
