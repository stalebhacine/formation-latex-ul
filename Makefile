MASTER1 = formation_latex-partie_1.pdf
MASTER2 = formation_latex-partie_2.pdf

TEXFILES = licence-partie_2.tex \
	introduction.tex     \
	include.tex          \
	boites.tex           \
	tableaux+figures.tex \
	mathematiques.tex    \
	bibliographie.tex    \
	commandes.tex        \
	trucs.tex            \
	solutions.tex        \

FILES1 = formation_latex-partie_1.pdf \
	exercice_minimal.tex \
	exercice_demo.tex \
	exercice_commandes.tex \
	exercice_classe+paquetages.tex \
	exercice_sections.tex \
	exercice_renvois.tex \
	exercice_tdm+annexe.tex \
	exercice_complet.tex \
	exercice_ulthese.tex \
		includes/mathematiques.tex \
	formation_latex.bib

SOLUTIONS1 = \
	exercice_commandes-solution.tex \
	exercice_classe+paquetages-solution.tex \
	exercice_sections-solution.tex \
	exercice_renvois-solution.tex \
	exercice_tdm+annexe-solution.tex \
	exercice_complet-solution.tex \
	exercice_ulthese-solution.tex

FILES2 = formation_latex-partie_2.pdf \
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
	formation_latex.bib

SOLUTIONS2 =

# Outils de travail
TEXI2DVI = LATEX=xelatex TEXINDY=makeindex texi2dvi -b
RM = rm -rf

.PHONY: pdf zip clean

pdf : $(MASTER1) $(MASTER2)

$(MASTER1):
	$(TEXI2DVI) $(MASTER1:.pdf=.tex)

$(MASTER2): $(TEXFILES) #couvertures.pdf
	$(TEXI2DVI) $(MASTER2:.pdf=.tex)

zip :
	zip -j formation_latex.zip ${FILES1} ${SOLUTIONS1} ${FILES2} ${SOLUTIONS2}

clean:
	$(RM) *.aux *.log *.blg *.bbl *.out *.ilg *.idx *.ind
