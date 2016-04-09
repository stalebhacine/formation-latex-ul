## Prendre le numéro de version dans le fichier Makeconf
include ./Makeconf

## Nom du paquetage sur CTAN
PACKAGENAME = formation-latex-ul

## Fichiers maîtres
MASTER1 = formation-latex-ul-diapos.pdf
MASTER2 = formation-latex-ul.pdf

## Liste des autres fichiers source de la partie I
TEXFILES1 = licence-partie_1.tex \
	colophon-partie_1.tex

## Liste des autres fichiers source de la partie II
TEXFILES2 = licence-partie_2.tex \
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
	colophon-partie_2.tex

## Liste des fichiers à inclure dans l'archive pour la partie I
FILES1 = ${MASTER1} \
	exercice_minimal.tex \
	exercice_demo.tex \
	exercice_commandes.tex \
	exercice_classe+paquetages.tex \
	exercice_parties.tex \
	exercice_renvois.tex \
	exercice_complet.tex \
	exercice_ulthese.tex \
		includes/mathematiques.tex \
	formation_latex_UL.bib

SOLUTIONS1 = \
	exercice_commandes-solution.tex \
	exercice_classe+paquetages-solution.tex \
	exercice_parties-solution.tex \
	exercice_renvois-solution.tex \
	exercice_complet-solution.tex \
	exercice_ulthese-solution.tex

## Liste des fichiers à inclure dans l'archive pour la partie II
FILES2 = ${MASTER2} \
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
	formation_latex_UL.bib

SOLUTIONS2 =

# Outils de travail
TEXI2DVI = LATEX=xelatex TEXINDY=makeindex texi2dvi -b
RM = rm -r

.PHONY: pdf zip clean

pdf : $(MASTER1) $(MASTER2)

$(MASTER1): $(MASTER1:.pdf=.tex) $(TEXFILES1)
	$(TEXI2DVI) $(MASTER1:.pdf=.tex)

$(MASTER2): $(MASTER2:.pdf=.tex) $(TEXFILES2)
	$(TEXI2DVI) $(MASTER2:.pdf=.tex)

zip : ${FILES1} ${SOLUTIONS1} ${FILES2} ${SOLUTIONS2}
	if [ -d ${PACKAGENAME} ]; then ${RM} ${PACKAGENAME}; fi
	mkdir ${PACKAGENAME}
	sed -e 's/<VERSION>/${VERSION}/g' README.in > README
	cp README ${FILES1} ${SOLUTIONS1} ${FILES2} ${SOLUTIONS2} ${PACKAGENAME}
	zip --filesync -r ${PACKAGENAME}.zip ${PACKAGENAME}
	${RM} ${PACKAGENAME}

clean:
	$(RM) *.aux *.log *.blg *.bbl *.out *.ilg *.idx *.ind
