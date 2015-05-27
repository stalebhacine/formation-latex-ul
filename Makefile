FILES1=formation_latex-partie_1.pdf \
	exercice_minimal.tex \
	exercice_demo.tex \
	exercice_commandes.tex \
	exercice_classe+paquetages.tex \
	exercice_sections.tex \
	exercice_renvois.tex \
	exercice_tdm+annexe.tex \
	exercice_complet.tex \
	exercice_ulthese.tex \
	mathematiques.tex \
	formation_latex.bib

SOLUTIONS1=\
	exercice_commandes-solution.tex \
	exercice_classe+paquetages-solution.tex \
	exercice_sections-solution.tex \
	exercice_renvois-solution.tex \
	exercice_tdm+annexe-solution.tex \
	exercice_complet-solution.tex \
	exercice_ulthese-solution.tex

FILES2=formation_latex-partie_2.pdf \
	ul_p.pdf \
	exercice_gabarit.tex
	exercice_include.tex
	exercice_subcaptions.tex
	exercice_demo.tex

SOLUTIONS2=

all : zip

zip :
	zip formation_latex.zip ${FILES1} ${SOLUTIONS1} ${FILES2} ${SOLUTIONS2}
