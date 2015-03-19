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
	formation_latex.bib \

all : zip

zip :
	zip formation_latex.zip ${FILES}
