vpath %.mkd mkd
vpath %.pdf pdf
vpath %.wiki wiki
vpath %.tex tex
vpath %.context pandoc
vpath %.docx msword

SRC_MKD = $(shell cd mkd && ls *.mkd)
OUT_PDF = $(SRC_MKD:%.mkd=%.pdf) 
OUT_WIKI = $(SRC_MKD:%.mkd=%.wiki) 
OUT_DOCX = $(SRC_MKD:%.mkd=%.docx) 

SED=gsed

TEX = context
TEX_OPT = --nonstopmode
PANDOC_TEX_TEMPLATE = pandoc/zh.context
PANDOC_DIR = pandoc
PANDOC_TEX_OPT = -f markdown -t context --template=$(PANDOC_TEX_TEMPLATE) --toc --smart --standalone
PANDOC_WIKI_OPT = -f markdown -t mediawiki --smart --standalone

GIT_REPO = https://raw.githubusercontent.com/weijianwen/hpc-public-docs/master

all: $(OUT_PDF) $(OUT_WIKI) $(OUT_DOCX)

.PHONY : all clean cleanall release pdf wiki

pdf : $(OUT_PDF)

wiki : $(OUT_WIKI)

docx : $(OUT_DOCX)

$(OUT_PDF) : %.pdf : %.tex Makefile
	-cd tex && $(TEX) $* $(TEX_OPT) ; mv $@ ../pdf

$(OUT_WIKI) : %.wiki : %.mkd Makefile
	-pandoc $(PANDOC_WIKI_OPT) $< -o wiki/$@
	-$(SED) -i "s/\[\[Image:figures\//\[\[Image:/g" wiki/$@

$(OUT_DOCX) : %.docx : %.mkd Makefile
	pandoc $< -o msword/$@

%.tex : %.mkd $(PANDOC_TEX_TEMPLATE) Makefile
	pandoc $(PANDOC_TEX_OPT) $< -o tex/$@

clean :
	-cd pdf && context --purge
	-cd tex && context --purge; rm *.tex

update :
	wget -q $(GIT_REPO)/Makefile -O Makefile
	wget -q $(GIT_REPO)/pandoc/zh.context -O pandoc/zh.context

cleanall : clean
	-cd wiki && rm -f $(OUT_WIKI)
	-cd pdf && rm -f $(OUT_PDF)
	-cd msword && rm -f $(OUT_DOCX)

git :
	git push gitlab
	git push github
