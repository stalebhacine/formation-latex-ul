### -*-Makefile-*- pour préparer le paquetage formation-latex-ul
##
## Copyright (C) 2017 Vincent Goulet
##
## 'make pdf' (recette par défaut) compile les documents auxiliaires,
## puis le document principal et les diapositives avec XeLaTeX.
##
## 'make zip' crée l'archive du paquetage conformément aux exigences
## de CTAN.
##
## Auteur: Vincent Goulet
##
## Ce fichier fait partie du projet formation-latex-ul
## http://github.com/vigou3/formation-latex-ul


## Nom du paquetage sur CTAN
PACKAGENAME = formation-latex-ul

## Fichiers maîtres
MASTER = formation-latex-ul.pdf
MASTERDIAPOS = formation-latex-ul-diapos.pdf

## Numéro de version et numéro ISBN extraits du fichier maître
YEAR = $(shell grep "newcommand{\\\\year" ${MASTER:.pdf=.tex} \
	| cut -d } -f 2 | tr -d {)
MONTH = $(shell grep "newcommand{\\\\month" ${MASTER:.pdf=.tex} \
	| cut -d } -f 2 | tr -d {)
VERSION = ${YEAR}.${MONTH}
ISBN = $(shell grep "newcommand{\\\\ISBN" ${MASTER:.pdf=.tex} \
	| cut -d } -f 2 | tr -d {)

## Documents auxiliaires insérés dans le document principal (et donc à
## compiler avant)
AUXDOC = \
	exemple-classe-article.pdf \
	exemple-classe-report.pdf \
	exemple-classe-book.pdf \
	exemple-titre.pdf \
	exemple-renvoi.pdf \
	exemple-renvoi-hyperref.pdf \
	exemple-renvoi-autoref.pdf

## Sources du document principal
SOURCEMAIN = \
	couverture-avant.tex \
		Suricata.jpg \
		ul_p.pdf \
	frontispice.tex \
	licence.tex \
		by-sa.pdf \
		by.pdf \
		sa.pdf \
	introduction.tex \
	presentation.tex \
	bases.tex \
		exercice_commandes-solution.pdf \
	organisation.tex \
		exemple-titre.tex \
	apparence.tex \
	boites.tex \
	tableaux+figures.tex \
	mathematiques.tex \
	bibliographie.tex \
		exemple-bibliographie.bib \
		exemple-bibliographie.tex \
		exemple-bibliographie-cropped-1.pdf \
		exemple-bibliographie-cropped-2.pdf \
		exemple-bibliographie-cropped-3.pdf \
		bibtex-texmaker.png \
		bibtex-texshop.png \
		tdm-dans-pdf.pdf \
	commandes.tex \
	trucs+astuces.tex \
	ulthese.tex \
	solutions.tex \
	colophon.tex \
	couverture-arriere.tex \
		codebarre_${ISBN}.pdf \
	formation-latex-ul.bib \
	francais.bst

## Sources des diapositives
SOURCEDIAPOS = \
	couverture-avant-diapos.tex \
		Suricata-diapos.jpg \
		ul_p.pdf \
	frontispice-diapos.tex \
	licence-diapos.tex \
		by-sa.pdf \
		by.pdf \
		sa.pdf \
	prerequis-diapos.tex \
	presentation-diapos.tex \
		knuth.jpg \
		TeXFZoneColor.pdf \
	bases-diapos.tex \
		exercice_commandes-solution.pdf \
	organisation-diapos.tex \
	apparence-diapos.tex \
	mathematiques-diapos.tex \
		ponctuation.pdf \
	ulthese-diapos.tex \
	colophon-diapos.tex \
	couverture-arriere-diapos.tex

## Fichiers des exercices
EXERCICES = \
	exercice_minimal.tex \
	exercice_demo.tex \
	exercice_commandes.tex \
	exercice_classe+paquetages.tex \
	exercice_parties.tex \
	exercice_renvois.tex \
	exercice_complet.tex \
	exercice_ulthese.tex \
		includes/b-a-ba-math.tex \
	exercice_gabarit.tex \
	exercice_include.tex \
		includes/pagetitre.tex \
		includes/rpresentation.tex \
		includes/console-screenshot.pdf \
		includes/emacs.tex \
	exercice_subcaption.tex \
	exercice_demo.tex \
	exercice_mathematiques.tex \
	exercice_trucs.tex

## Fichiers à placer dans le dossier 'source'
SOURCEFILES = \
	${MASTER:.pdf=.tex} \
	${SOURCEMAIN} \
	${MASTERDIAPOS:.pdf=.tex} \
	${SOURCEDIAPOS} \
	${AUXDOC} \
	${AUXDOC:.pdf=.tex}

## Fichiers à placer dans le dossier 'doc'
DOCFILES = \
	${MASTER} \
	${MASTERDIAPOS} \
	${EXERCICES}

## Liens symboliques vers des fichiers de source/ à insérer dans doc/
## (pour éviter les doublons qui ne sont pas tolérés par CTAN)
SYMLINKS = \
	ul_p.pdf \
	formation-latex-ul.bib

# Outils de travail
TEXI2DVI = LATEX=xelatex TEXINDY=makeindex texi2dvi -b
RM = rm -r

.PHONY: pdf zip clean

pdf: $(AUXDOC) $(MASTER) $(MASTERDIAPOS)
#pdf : $(MASTER)

$(AUXDOC): $(AUXDOC:.pdf=.tex)
	$(TEXI2DVI) $(AUXDOC:.pdf=.tex)

$(MASTER): $(MASTER:.pdf=.tex) $(SOURCEMAIN)
	$(TEXI2DVI) $(MASTER:.pdf=.tex)

$(MASTERDIAPOS): $(MASTERDIAPOS:.pdf=.tex) $(SOURCEDIAPOS)
	$(TEXI2DVI) $(MASTERDIAPOS:.pdf=.tex)

zip: ${SOURCEFILES} ${DOCFILES} ${SYMLINKS} README.md
	if [ -d ${PACKAGENAME} ]; then ${RM} ${PACKAGENAME}; fi
	mkdir -p ${PACKAGENAME}/source ${PACKAGENAME}/doc
	touch ${PACKAGENAME}/README.md && \
	  sed 's/<VERSION>/${VERSION}/' README-HEADER.in >> ${PACKAGENAME}/README.md && \
	  awk 'BEGIN { print } /^# / { state=1 } state' README.md >> ${PACKAGENAME}/README.md
	cp ${SOURCEFILES} ${PACKAGENAME}/source
	cp ${DOCFILES} ${PACKAGENAME}/doc
	cd ${PACKAGENAME}/doc && \
	  for file in ${SYMLINKS}; do ln -s ../source/$$file $$file; done
	zip --filesync --symlinks -r ${PACKAGENAME}.zip ${PACKAGENAME}
	${RM} ${PACKAGENAME}

clean:
	$(RM) *.aux *.log *.blg *.bbl *.out *.ilg *.idx *.ind

test:
	if [ -f toto ]; then rm toto; fi
	touch toto
	sed 's/<VERSION>/${VERSION}/' README-HEADER.in >> toto
	awk 'BEGIN { print } /^# / { state=1 } state' README.md >> toto
