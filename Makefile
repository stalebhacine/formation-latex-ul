FILES=formation_latex-partie_1.pdf \
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

SOLUTIONS=exercice_commandes-solution.tex \
	exercice_classe+paquetages-solution.tex \
	exercice_sections-solution.tex \
	exercice_renvois-solution.tex \
	exercice_tdm+annexe-solution.tex \
	exercice_complet-solution.tex \
	exercice_ulthese-solution.tex

all : zip

zip :
	zip formation_latex.zip ${FILES} ${SOLUTIONS}
