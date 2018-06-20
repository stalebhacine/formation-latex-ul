### -*-Makefile-*- pour préparer le paquetage formation-latex-ul
##
## Copyright (C) 2018 Vincent Goulet
##
## 'make pdf' (recette par défaut) compile les documents auxiliaires,
## puis le document principal et les diapositives avec XeLaTeX.
##
## 'make zip' crée l'archive du paquetage conformément aux exigences
## de CTAN.
##
## 'make release' crée une version dans GitHub et téléverse le fichier
## .zip. Il n'y a pas de lien vers cette version dans la page web.
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
README = README.md

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
	notices.tex \
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
	notices-diapos.tex \
		by-sa.pdf \
		by.pdf \
		sa.pdf \
	prerequis-diapos.tex \
	presentation-diapos.tex \
		knuth.jpg \
	bases-diapos.tex \
		exercice_commandes-solution.pdf \
	organisation-diapos.tex \
		section-num.pdf \
		section-non-num.pdf \
	apparence-diapos.tex \
	mathematiques-diapos.tex \
		ponctuation.pdf \
		xyz-emph.pdf \
		xyz-math.pdf \
	ulthese-diapos.tex \
	suite-diapos.tex \
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

## Dépôt GitHub et authentification
REPOSURL = https://api.github.com/repos/vigou3/formation-latex-ul
OAUTHTOKEN = $(shell cat ~/.github/token)


all: pdf

.PHONY: pdf zip clean

pdf: $(AUXDOC) $(MASTER) $(MASTERDIAPOS)

release: zip create-release upload

$(AUXDOC): $(AUXDOC:.pdf=.tex)
	$(TEXI2DVI) $(AUXDOC:.pdf=.tex)

$(MASTER): $(MASTER:.pdf=.tex) $(SOURCEMAIN)
	$(TEXI2DVI) $(MASTER:.pdf=.tex)

$(MASTERDIAPOS): $(MASTERDIAPOS:.pdf=.tex) $(SOURCEDIAPOS)
	$(TEXI2DVI) $(MASTERDIAPOS:.pdf=.tex)

zip: ${SOURCEFILES} ${DOCFILES} ${SYMLINKS} ${README}
	if [ -d ${PACKAGENAME} ]; then ${RM} ${PACKAGENAME}; fi
	mkdir -p ${PACKAGENAME}/source ${PACKAGENAME}/doc
	touch ${PACKAGENAME}/${README} && \
	  awk 'state==0 && /^# / { state=1 }; \
	       /^## Author/ { printf("## Version\n\n%s\n\n", "${VERSION}") } \
	       state' ${README} >> ${PACKAGENAME}/${README}
	cp ${SOURCEFILES} ${PACKAGENAME}/source
	cp ${DOCFILES} ${PACKAGENAME}/doc
	cd ${PACKAGENAME}/doc && \
	  for file in ${SYMLINKS}; do ln -s ../source/$$file $$file; done
	zip --filesync --symlinks -r ${PACKAGENAME}.zip ${PACKAGENAME}
	${RM} ${PACKAGENAME}

create-release :
	@echo ----- Creating release on GitHub...
	@if [ -n "$(shell git status --porcelain | grep -v '^??')" ]; then \
	     echo "uncommitted changes in repository; not creating release"; exit 2; fi
	@if [ -n "$(shell git log origin/master..HEAD)" ]; then \
	    echo "unpushed commits in repository; pushing to origin"; \
	     git push; fi
	if [ -e relnotes.in ]; then rm relnotes.in; fi
	touch relnotes.in
	awk 'BEGIN { ORS = " "; print "{\"tag_name\": \"v${VERSION}\"," } \
	      /^$$/ { next } \
	      /^## Historique/ { state = 1; next } \
              (state == 1) && /^### / { \
		state = 2; \
		out = $$2; \
	        for(i = 3; i <= NF; i++) { out = out" "$$i }; \
	        printf "\"name\": \"Édition %s\", \"body\": \"", out; \
	        next } \
	      (state == 2) && /^### / { exit } \
	      state == 2 { printf "%s\\n", $$0 } \
	      END { print "\", \"draft\": false, \"prerelease\": false}" }' \
	      README.md >> relnotes.in
	curl --data @relnotes.in ${REPOSURL}/releases?access_token=${OAUTHTOKEN}
	rm relnotes.in
	@echo ----- Done creating the release

upload :
	@echo ----- Getting upload URL from GitHub...
	$(eval upload_url=$(shell curl -s ${REPOSURL}/releases/latest \
	 			  | awk -F '[ {]' '/^  \"upload_url\"/ \
	                                    { print substr($$4, 2, length) }'))
	@echo ${upload_url}
	@echo ----- Uploading PDF and archive to GitHub...
	curl -H 'Content-Type: application/zip' \
	     -H 'Authorization: token ${OAUTHTOKEN}' \
	     --upload-file ${PACKAGENAME}.zip \
             -i "${upload_url}?&name=${PACKAGENAME}.zip" -s
	@echo ----- Done uploading files

clean:
	$(RM) *.aux *.log *.blg *.bbl *.out *.ilg *.idx *.ind
