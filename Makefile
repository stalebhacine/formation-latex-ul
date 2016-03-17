BASENAME = formation_latex_UL

MASTER1 = ${BASENAME}-partie_1.pdf
MASTER2 = ${BASENAME}-partie_2.pdf

TEXFILES1 = licence-partie_1.tex \
	colophon-partie_1.tex

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

FILES1 = ${MASTER1} \
	exercice_minimal.tex \
	exercice_demo.tex \
	exercice_commandes.tex \
	exercice_classe+paquetages.tex \
	exercice_parties.tex \
	exercice_renvois.tex \
	exercice_complet.tex \
	exercice_tdm+annexe.tex \
	exercice_ulthese.tex \
		includes/mathematiques.tex \
	formation_latex_UL.bib

SOLUTIONS1 = \
	exercice_commandes-solution.tex \
	exercice_classe+paquetages-solution.tex \
	exercice_parties-solution.tex \
	exercice_renvois-solution.tex \
	exercice_tdm+annexe-solution.tex \
	exercice_complet-solution.tex \
	exercice_ulthese-solution.tex

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

zip :
	if [ -d ${BASENAME} ]; then ${RM} ${BASENAME}; fi
	mkdir ${BASENAME}
	cp README ${FILES1} ${SOLUTIONS1} ${FILES2} ${SOLUTIONS2} ${BASENAME}
	zip -r ${BASENAME}.zip ${BASENAME}
	${RM} ${BASENAME}

clean:
	$(RM) *.aux *.log *.blg *.bbl *.out *.ilg *.idx *.ind
