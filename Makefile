INCLUDE=$(wildcard include/*.tex)
SOURCES= \
	main.tex \
	jsbook_mod.cls \
	titling.sty \
	sieicej.bst \
	ref.bib

GRAPHS_NO_SRC= \
	graphs/ueclogo.png \

FIGURES=graphs/*.png \

CREATE_TITLELIST=utils/create_titlelist.pl
all: main.pdf

main.pdf: main.dvi $(GRAPHS_NO_SRC)
	dvipdfmx $<

main.dvi: $(SOURCES) $(GRAPHS_NO_SRC) $(INCLUDE)
	extractbb $(FIGURES)
	platex $<
	pbibtex main.aux
	$(CREATE_TITLELIST) main.toc > generated/include/titlelist.tex
	platex $<
	platex $<

allclean:
	rm -f *.aux *.log *.lof *.lot *.toc *.pdf *.dvi *.blg *.bbl
	rm -f include/*.aux include/*.log include/*.tmp

clean:
	rm -f *.aux *.log *.lof *.lot *.toc *.pdf *.dvi *.blg *.bbl
	rm -f include/*.aux include/*.log include/*.tmp
