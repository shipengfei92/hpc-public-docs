man_SSH  	:= ssh
man_SSH_EN	:= ssh_en
man_LSF  	:= lsf
man_LSF_EN	:= lsf_en
man_VPN  	:= vpn
man_VPN_EN  	:= vpn_en
man_module  	:= module
man_module  	:= module_en
# Document Class
DOCCLASS := hpcmanual
# LATEX_OPT = -xelatex -silent -f
LATEX_OPT = -gg -xelatex -f
PANDOC_DIR := pandoc
PANDOC_TEX := -f markdown -t latex --template=$(DOCCLASS).latex --toc --listings --smart --standalone
PANDOC_WIKI := -f markdown -t mediawiki --smart --standalone
REPOURL = https://raw.github.com/weijianwen/hpc-manual-class/master/pandoc
# pdf viewer: evince/open
VIEWER = open
# version number, which can be specified when calling make like
# make VERSION="0.5.2"
VERSION = 0.5.3

.PHONY : all clean version distclean release
.PRECIOUS : %.tex

all: $(man_SSH).pdf $(man_SSH).wiki $(man_SSH_EN).pdf $(man_SSH_EN).wiki $(man_LSF).pdf $(man_LSF).wiki $(man_LSF_EN).pdf $(man_LSF_EN).wiki $(man_module).pdf $(man_module).wiki 

%.pdf : %.tex $(DOCCLASS).cls $(DOCCLASS).cfg Makefile
	-@latexmk $(LATEX_OPT) $*

%.wiki : %.mkd Makefile
	@pandoc $(PANDOC_WIKI) $*.mkd -o $@

%.tex : $(DOCCLASS).latex %.mkd Makefile
	@pandoc $(PANDOC_TEX) $*.mkd -o $@

$(DOCCLASS).% :
	cp pandoc/$@ ./

clean :
	-@latexmk -f -c $(man_SSH)
	-@rm *.tex *.toc *.aux *.fls *.fdb_latexmk *.out *.cfg *.cls *.latex *.log

update :
	@wget -q $(REPOURL)/$(DOCCLASS).cls -O pandoc/$(DOCCLASS).cls
	@wget -q $(REPOURL)/$(DOCCLASS).cfg -O pandoc/$(DOCCLASS).cfg
	@wget -q $(REPOURL)/$(DOCCLASS).latex -O pandoc/$(DOCCLASS).latex

distclean : clean
	-@rm *.pdf
	-@latexmk -f -C $(man_SSH)

release :
	git push gitlab
	git push github
