## Prendre le numéro de version dans le fichier Makeconf
include ./Makeconf

## Nom du paquetage sur CTAN
PACKAGENAME = formation-latex-ul

## Fichiers maîtres
MASTER = formation-latex-ul.pdf
MASTERDIAPOS = formation-latex-ul-diapos.pdf

## Liste des fichiers source du document principal
TEXFILES = couverture-avant.tex \
	frontispice.tex \
	licence.tex \
	introduction.tex \
	presentation.tex \
	bases.tex \
	organisation.tex \
	apparence.tex \
	boites.tex \
	tableaux+figures.tex \
	mathematiques.tex \
	bibliographie.tex \
	commandes.tex \
	trucs.tex \
	ulthese.tex \
	solutions.tex \
	colophon.tex \
	couverture-arriere.tex

## Liste des documents auxiliaires à compiler avant le document
## principal
AUXDOC = exemple-classe-article.pdf \
	exemple-classe-report.pdf \
	exemple-classe-book.pdf \
	exemple-titre.pdf \
	exemple-renvoi.pdf \
	exemple-renvoi-hyperref.pdf \
	exemple-renvoi-autoref.pdf

## Liste des fichiers source des diapositives
TEXFILESDIAPOS = couverture-avant-diapos.tex \
	frontispice-diapos.tex \
	licence-diapos.tex \
	prerequis-diapos.tex \
	presentation-diapos.tex \
	bases-diapos.tex \
	organisation-diapos.tex \
	apparence-diapos.tex \
	mathematiques-diapos.tex \
	ulthese-diapos.tex \
	colophon-diapos.tex \
	couverture-arriere-diapos.tex

## Liste des fichiers à inclure dans l'archive
FILES = ${MASTER} ${MASTERDIAPOS} \
	ul_p.pdf \
	exercice_minimal.tex \
	exercice_demo.tex \
	exercice_commandes.tex \
	exercice_classe+paquetages.tex \
	exercice_parties.tex \
	exercice_renvois.tex \
	exercice_complet.tex \
	exercice_ulthese.tex \
		includes/mathematiques.tex \
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

# Outils de travail
TEXI2DVI = LATEX=xelatex TEXINDY=makeindex texi2dvi -b
RM = rm -r

.PHONY: pdf zip clean

pdf: $(MASTER) $(MASTERDIAPOS)
#pdf : $(MASTER)

$(MASTER): $(MASTER:.pdf=.tex) $(TEXFILES) $(AUXDOC)
	$(TEXI2DVI) $(MASTER:.pdf=.tex)

$(MASTERDIAPOS): $(MASTERDIAPOS:.pdf=.tex) $(TEXFILESDIAPOS) $(AUXDOC)
	$(TEXI2DVI) $(MASTERDIAPOS:.pdf=.tex)

zip : ${FILES} README.in
	if [ -d ${PACKAGENAME} ]; then ${RM} ${PACKAGENAME}; fi
	mkdir ${PACKAGENAME}
	sed -e 's/<VERSION>/${VERSION}/g' README.in > README
	cp README ${FILES} ${PACKAGENAME}
	zip --filesync -r ${PACKAGENAME}.zip ${PACKAGENAME}
	${RM} ${PACKAGENAME}

clean:
	$(RM) *.aux *.log *.blg *.bbl *.out *.ilg *.idx *.ind
