#
# Makefile for feupteses/feupthesis
#
# Version:   Sat May 17 22:36:50 2008
# Written by JCL
#

## programs
LATEX=latex
PDFLATEX=pdflatex
BIBTEX=bibtex
MKIDX=makeindex

## Basename for result in PT
TARGET=tese
## Basename for result in EN
#TARGET=thesis

## .tex files
TEXFILES=$(wildcard *.tex **/*.tex)

## BibTeX files
BIB=$(wildcard *.bib)

## paper
PAPERSIZE=a4

#we prefer pdflatex for bibtex
LATEXBIB=$(PDFLATEX)

main:	$(TARGET).pdf

index:
	$(MKIDX) $(TARGET)

biblio:
	$(BIBTEX) $(TARGET)

.tex.pdf:
	rm -f $(TARGET).pdf
	$(PDFLATEX) $< $@ || { rm -f $*.aux $*.idx && false ; }
	if grep 'There were undefined references' $*.log ; then \
	  $(BIBTEX) $(TARGET); $(PDFLATEX) $< $@; fi
	while grep 'Rerun to get cross-references right.' $*.log ; do \
	  $(PDFLATEX) $< $@ || { rm -f $*.aux $*.idx && false ; } ; done

.bib.bbl:
# in case we don't already have a .aux file listing citations
	$(LATEXBIB) $(TARGET).tex
# get the citations out of the bibliography
	$(BIBTEX) $(TARGET)
# do it again in case there are out-of-order cross-references
	$(LATEXBIB) $(TARGET).tex
	$(BIBTEX) $(TARGET)

$(TARGET).pdf:	  $(TEXFILES)

## Extensions
EXTS=aux toc idx ind ilg log out lof lot lol bbl blg brf

##clean
clean:
	for EXT in ${EXTS}; do \
	  find `pwd` -name \*\.$${EXT} -exec rm -v \{\} \; ; done

##show PDF
display: $(TARGET).pdf
	acroread $(TARGET).pdf &

### misc
.SUFFIXES: .tex .aux .toc .lof .lot .log .pdf .bib .bbl .brf
