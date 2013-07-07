# Makefile for HPC manual file

SED = gsed

MAIN = manual
DOCCLASS = hpcmanual
REPOURL =  https://raw.github.com/weijianwen/hpc-manual-class/master
# pdf viewer: evince/open
VIEWER = open
# version number, which can be specified when calling make like
# make VERSION="0.5.2"
VERSION = 0.5.3

all: $(MAIN).pdf 

.PHONY : all clean version distclean cleantest release

%.cls :
	@wget -q $(REPOURL)/$@ -O ./$@

%.cfg :
	@wget -q $(REPOURL)/$@ -O ./$@ 

%.latex :
	@wget -q $(REPOURL)/$@ -O ./$@
	
%.tex : $(DOCCLASS).latex %.mkd Makefile
	@pandoc -f markdown -t latex --template=$(DOCCLASS).latex --toc -s $*.mkd > $@

%.pdf : %.tex $(DOCCLASS).cls $(DOCCLASS).cfg Makefile
	-@latexmk -silent -f -pdf $*

view : $(MAIN).pdf
	$(VIEWER) $<

clean :
	-@latexmk -c
	-@rm *.tex

distclean : clean
	-@rm -f *.pdf

