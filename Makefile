# var
MODULE = $(notdir $(CURDIR))
module = $(shell echo $(MODULE) | tr A-Z a-z)
OS     = $(shell uname -o|tr / _)
NOW    = $(shell date +%d%m%y)
REL    = $(shell git rev-parse --short=4 HEAD)
BRANCH = $(shell git rev-parse --abbrev-ref HEAD)

# dirs
CWD = $(CURDIR)
BIN = $(CWD)/bin
DOC = $(CWD)/doc
SRC = $(CWD)/src
TMP = $(CWD)/tmp

# tool
CURL   = curl -L -o
CF     = clang-format

# src
J += $(shell find src -type f -regex '.+.java$$')
S += $(J) pom.xml
F += $(shell find lib -type f -regex '.+.ini$$')
S += $(F)

# cfg
CP += -cp target/classes

# all
.PHONY: all
all:
	mvn compile exec:java \
		-Dexec.mainClass="dponyatov.App" \
		-Dexec.args=$(F)

# format
.PHONY: format
format: tmp/format_java
tmp/format_java: $(J)
	$(CF) -style=file -i $? && touch $@

# doc
.PHONY: doc
doc:

# install
.PHONY: install update updev
install: $(OS)_install doc gz
	$(MAKE) update
update:  $(OS)_update
updev:   update $(OS)_updev

.PHONY: GNU_Linux_install GNU_Linux_update GNU_Linux_updev
GNU_Linux_install:
GNU_Linux_update:
ifneq (,$(shell which apt))
	sudo apt update
	sudo apt install -u `cat apt.txt`
endif
# Debian 10
ifeq ($(shell lsb_release -cs),buster)
#	sudo apt install -t buster-backports kicad
endif
GNU_Linux_updev:
	sudo apt install -yu `cat apt.dev`

.PHONY: gz
gz: src/main/antlr4/JavaLexer.g4 src/main/antlr4/JavaParser.g4 \
	lib/JCad/README.md

lib/JCad/README.md:
	git clone https://github.com/andreia-oca/JCad.git lib/JCad

src/main/antlr4/JavaLexer.g4:
	$(CURL) $@ https://github.com/antlr/grammars-v4/raw/master/java/java/JavaLexer.g4
src/main/antlr4/JavaParser.g4:
	$(CURL) $@ https://github.com/antlr/grammars-v4/raw/master/java/java/JavaParser.g4

# merge
MERGE += README.md Makefile .gitignore apt.txt apt.dev LICENSE $(S)
MERGE += .vscode bin doc inc src tmp vscode

.PHONY: dev
dev:
	git push -v
	git checkout $@
	git pull -v
	git checkout shadow -- $(MERGE)

.PHONY: shadow
shadow:
	git push -v
	git checkout $@
	git pull -v

.PHONY: release
release:
	git tag $(NOW)-$(REL)
	git push -v && git push -v --tags
	$(MAKE) shadow

.PHONY: zip
zip:
	git archive \
		--format zip \
		--output $(TMP)/$(MODULE)_$(NOW)_$(REL).src.zip \
	HEAD

# maven
.PHONY: new
new:
	mvn archetype:generate \
		-DgroupId=dponyatov \
		-DartifactId=$(MODULE) \
		-DarchetypeArtifactId=maven-archetype-quickstart \
		-DinteractiveMode=false

.PHONY: version
version:
	mvn versions:set \
		-DgenerateBackupPoms=false -DnewVersion=$(BRANCH)-$(REL)
