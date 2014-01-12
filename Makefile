vpath %.mkd mkd
vpath %.pdf pdf
vpath %.wiki wiki
vpath %.tex tex
vpath %.cls tex
vpath %.cfg tex
vpath %.latex pandoc

SRC = $(wildcard *.mkd)
SRC_NAME = $(SRC:%.mkd=)
OUT_PDF = $(SRC:%.mkd=%.pdf) 
OUT_WIKI = $(SRC:%.mkd=%.wiki) 

# Document Class
DOCCLASS := hpcmanual
# LATEX_OPT = -xelatex -silent -f
LATEX_OPT = -gg -xelatex -f -outdir=../pdf
PANDOC_DIR := pandoc
PANDOC_TEX_OPT := -f markdown -t latex --template=pandoc/$(DOCCLASS).latex --toc --listings --smart --standalone
PANDOC_WIKI_OPT := -f markdown -t mediawiki --smart --standalone
REPOURL = https://raw.github.com/weijianwen/hpc-manual-class/master/pandoc
# pdf viewer: evince/open
VIEWER = open

.PHONY : all clean distclean release
.PRECIOUS : %.tex

all: $(OUT_PDF) $(OUT_WIKI)

%.pdf : %.tex $(DOCCLASS).cls $(DOCCLASS).cfg Makefile
	-@cd tex; latexmk $(LATEX_OPT) $*

%.wiki : %.mkd Makefile
	@pandoc $(PANDOC_WIKI_OPT) mkd/$*.mkd -o wiki/$@

%.tex : $(DOCCLASS).latex %.mkd Makefile
	@pandoc $(PANDOC_TEX_OPT) mkd/$*.mkd -o tex/$@

clean :
	-@cd pdf; rm *.tex *.toc *.aux *.fls *.fdb_latexmk *.out *.cfg *.latex *.log
	-@cd tex; rm *.tex *.toc *.aux *.fls *.fdb_latexmk *.out *.cfg *.latex *.log

update :
	@wget -q $(REPOURL)/$(DOCCLASS).cls -O tex/$(DOCCLASS).cls
	@wget -q $(REPOURL)/$(DOCCLASS).cfg -O tex/$(DOCCLASS).cfg
	@wget -q $(REPOURL)/$(DOCCLASS).latex -O pandoc/$(DOCCLASS).latex

distclean : clean
	-@rm $(OUT_WIKI) $(OUT_PDF)

release :
	git push gitlab
	git push github
