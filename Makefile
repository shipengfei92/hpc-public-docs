vpath %.mkd mkd
vpath %.pdf pdf
vpath %.wiki wiki
vpath %.tex tex
vpath %.cls tex
vpath %.cfg tex
vpath %.latex pandoc

SRC_MKD = $(shell cd mkd && ls *.mkd)
OUT_PDF = $(SRC_MKD:%.mkd=%.pdf) 
OUT_WIKI = $(SRC_MKD:%.mkd=%.wiki) 

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

all: pdf wiki

.PHONY : all clean cleanall release pdf wiki

pdf : $(OUT_PDF)

wiki : $(OUT_WIKI)

$(OUT_PDF) : %.pdf : %.tex $(DOCCLASS).cls $(DOCCLASS).cfg Makefile
	-cd tex && latexmk $(LATEX_OPT) $*

$(OUT_WIKI) : %.wiki : %.mkd Makefile
	pandoc $(PANDOC_WIKI_OPT) mkd/$*.mkd -o wiki/$@

%.tex : $(DOCCLASS).latex %.mkd Makefile
	pandoc $(PANDOC_TEX_OPT) mkd/$*.mkd -o tex/$@

clean :
	-cd pdf && rm -f *.tex *.toc *.aux *.fls *.fdb_latexmk *.out  *.latex *.log
	-cd tex && rm -f *.tex *.toc *.aux *.fls *.fdb_latexmk *.out  *.latex *.log

update :
	wget -q $(REPOURL)/$(DOCCLASS).cls -O tex/$(DOCCLASS).cls
	wget -q $(REPOURL)/$(DOCCLASS).cfg -O tex/$(DOCCLASS).cfg
	wget -q $(REPOURL)/$(DOCCLASS).latex -O pandoc/$(DOCCLASS).latex

cleanall : clean
	-cd wiki && rm -f $(OUT_WIKI)
	-cd pdf && rm -f $(OUT_PDF)

git :
	git push gitlab
	git push github
