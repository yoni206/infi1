# בונה את src/exN.tex אל ../exN.pdf
SRC := $(wildcard ex*.tex)
PDF := $(patsubst %.tex,../%.pdf,$(SRC))

all: $(PDF)

../%.pdf: %.tex infi-ex.cls axioms.tex
	latexmk -lualatex -interaction=nonstopmode -halt-on-error -outdir=build $<
	cp build/$*.pdf $@

clean:
	rm -rf build

.PHONY: all clean
