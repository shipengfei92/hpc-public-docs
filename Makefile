# Makefile for HPC manual file

SED = gsed

MAIN = manual
DOCCLASS = hpcmanual
# LATEX_OPT = -xelatex -silent -f
LATEX_OPT = -xelatex -f
REPOURL = https://raw.github.com/weijianwen/hpc-manual-class/master
# pdf viewer: evince/open
VIEWER = open
# version number, which can be specified when calling make like
# make VERSION="0.5.2"
VERSION = 0.5.3

.PHONY : all clean version distclean cleantest release

all: $(MAIN).pdf 

%.tex : $(DOCCLASS).latex %.mkd Makefile
	@pandoc -f markdown -t latex --template=$(DOCCLASS).latex --toc -s $*.mkd > $@

%.pdf : %.tex $(DOCCLASS).cls $(DOCCLASS).cfg Makefile
	latexmk $(LATEX_OPT) $*

view : $(MAIN).pdf
	$(VIEWER) $<

clean :
	-@latexmk -c
	-@rm *.tex

update :
	@wget -q $(REPOURL)/$(DOCCLASS).cls -O ./$(DOCCLASS).cls
	@wget -q $(REPOURL)/$(DOCCLASS).cfg -O ./$(DOCCLASS).cfg
	@wget -q $(REPOURL)/$(DOCCLASS).latex -O ./$(DOCCLASS).latex

distclean : clean
	-@rm *.pdf
