# Makefile for HPC manual file

SED = gsed

MAIN = manual
DOCCLASS = hpcmanual
# pdf viewer: evince/open
VIEWER = open
# version number, which can be specified when calling make like
# make VERSION="0.5.2"
VERSION = 0.5.3

all: $(MAIN).pdf 

.PHONY : all clean version distclean cleantest release $(DOCCLASS).cls $(DOCCLASS).cfg $(DOCCLASS).latex

$(DOCCLASS).cls :
	@wget -q https://raw.github.com/weijianwen/hpc-manual-class/master/$@ -O ./$@

$(DOCCLASS).cfg :
	@wget -q https://raw.github.com/weijianwen/hpc-manual-class/master/$@ -O ./$@ 

$(DOCCLASS).latex :
	@wget -q https://raw.github.com/weijianwen/hpc-manual-class/master/$@ -O ./$@ 
	
$(MAIN).tex : $(DOCCLASS).cls $(DOCCLASS).cfg $(DOCCLASS).latex $(MAIN).mkd
	@pandoc -f markdown -t latex --template=$(DOCCLASS).latex --toc -s $*.mkd > $@

$(MAIN).pdf : $(MAIN).tex $(DOCCLASS).cls $(DOCCLASS).cfg
	-@latexmk -silent -f -pdf $*

view : $(MAIN).pdf
	$(VIEWER) $<

clean :
	-@latexmk -C
	-@rm *.tex

distclean : clean
	-@rm -f *.pdf

