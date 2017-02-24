# Base directory
BD_WEB = webmain
BD_MIXT = mixtures
BD_TEZ = tez

# WEB LOCATION
WEB_LOCAL = /var/www/
WEB_AMA = /media/Synology/home/www/

# PDF RESSOURCES
BD_PAPER = $(HOME)/Desktop/workInProgress/networkofgraphs/papers/personal/relational_models/
PAPERS_NAME = hdp_dynamics.pdf  hdp.pdf  ibp.pdf  lfc_model.pdf  poisson_binomial.pdf  rm_tab.pdf

# Stuff to clean
CLEAN_FILES = webmain/mixtures/html/*.html webmain/tez/html/*.html

# Bin
PANDOC = /usr/bin/pandoc
MDOWNPY = markdown_py
MD2BLOG = webmain/mixtures/md2blog.py
MD2WIKI = webmain/tez/md2wiki.py

#.PHONY: mixtures main
.PHONY: papers bin

# Files to compile
### Make a rule to downlad the content instead
# Dowload the content
TAG := $(wildcard $(BD_WEB)/$(BD_MIXT)/md/*.md) 
TEZ := $(wildcard $(BD_WEB)/$(BD_TEZ)/md/*.md) 
PAPERS := $(foreach file,$(PAPERS_NAME), $(BD_PAPER)/$(file))

# Web files to copy
HTML_FILES_MIXT := css/ js/ images/ html/ index.php menu.php 
HTML_FILES_TEZ  := css/ js/ images/ html/ a.php menu.php papers/ mlss2015/  
HTML_FILES_MAIN := css/ js/ images/ *.html *.php *.py

# Timestamp of files no used !
all: mixtures tez papers web
#rest: bin

local: mixtures tez web_local

# @Debug: nnot up to date !
mixtures:  $(TAG)
	$(info Building Mixtures...)
	$(MD2BLOG)

tez: $(TEZ) papers
	$(info Building tez...)
#$(foreach tez,$(TEZ), $(MDOWNPY) $(tez) > $(tez:.md=.html) ;)
	$(MD2WIKI)

papers:
	$(info copying papers...)
	$(foreach paper,$(PAPERS), /bin/cp -u $(paper) $(BD_WEB)/tez/papers/ ;)

web_local:
	$(info Web Local in $(WEB_LOCAL)) 
	@mkdir -p $(WEB_LOCAL)/$(BD_MIXT)
	@mkdir -p $(WEB_LOCAL)/$(BD_TEZ)
	sudo cp -ruv $(addprefix $(BD_WEB)/mixtures/, $(HTML_FILES_MIXT)) $(WEB_LOCAL)/$(BD_MIXT)
	sudo cp -ruv $(addprefix $(BD_WEB)/tez/, $(HTML_FILES_TEZ)) $(WEB_LOCAL)/$(BD_TEZ)
	sudo cp -ruv $(addprefix $(BD_WEB)/, $(HTML_FILES_MAIN)) $(WEB_LOCAL)

web_ama:
	$(info Web Local in $(WEB_AMA)) 
	@mkdir -p $(WEB_AMA)/$(BD_MIXT)
	@mkdir -p $(WEB_AMA)/$(BD_TEZ)
	@cp -ruv $(addprefix $(BD_WEB)/mixtures/, $(HTML_FILES_MIXT)) $(WEB_AMA)/$(BD_MIXT)
	@cp -ruv $(addprefix $(BD_WEB)/tez/, $(HTML_FILES_TEZ)) $(WEB_AMA)/$(BD_TEZ)
	@cp -ruv $(addprefix $(BD_WEB)/, $(HTML_FILES_MAIN)) $(WEB_AMA)

web: web_ama web_local

BIN_FILES = $(shell cat bin.txt)
bin:
	$(foreach f,$(BIN_FILES), /bin/ln -fs $(f) $(HOME)/bin/$(notdir $(f)) ;)

clean:
	@rm -vf $(CLEAN_FILES)
