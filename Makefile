# Criado por Rafael Lopes em 28 de julho de 2010
SHELL = /bin/sh

TEX = $(shell egrep -l '^[^%]*\\begin\{document\}' *tex)
PDF	= $(TEX:%.tex=%.pdf)

view:pdf
	evince resume_pt_rafael.pdf

pdf: $(PDF)

.tex.dvi:
	latex $*
	if test -f ref.bib; then bibtex $*; latex $*; latex $*; fi 
	rm -f $*.log $*.aux $*.blg

.tex.pdf:
	pdflatex $*
	if test -f ref.bib; then bibtex $*; pdflatex $*; pdflatex $*; fi 
	rm -f $*.log $*.aux $*.blg

.tex.ps:
	pslatex $*
	if test -f ref.bib; then bibtex $*; pslatex $*; pslatex $*; fi 
	rm -f $*.log $*.aux $*.blg

.tex.html:
	latex2html $*.tex
	rm -f $*.log $*.aux $*.bbl $*.blg


clean:
	-@rm *.dvi *.aux *.log *.dvi *.ps *.bbl *.blg *.out *.snm  *.toc *.nav
	-@rm -rf  $(PDF)


.SUFFIXES: .dvi .tex .pdf .ps .html .o .c
.PHONY:clean pdf
