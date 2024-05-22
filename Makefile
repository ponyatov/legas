# var
MODULE = $(notdir $(CURDIR))
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
CURL = curl -L -o
CF   = clang-format -style=file -i

# src
C += $(wildcard src/*.c*)
H += $(wildcard src/*.h*)

# all
.PHONY: all
all:

# format
.PHONY: format
format: tmp/format_cpp
tmp/format_cpp: $(C) $(H)
	$(CF) $? && touch $@

# doc
.PHONY: doc
doc:

# install
.PHONY: install update gz ref
install: doc gz ref
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -uy `cat apt.txt`
gz:
ref:
