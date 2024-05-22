# var
MODULE = $(notdir $(CURDIR))
NOW    = $(shell date +%d%m%y)
REL    = $(shell git rev-parse --short=4 HEAD)
BRANCH = $(shell git rev-parse --abbrev-ref HEAD)

# config
HW = qemu386
include   hw/$(HW).mk
include  cpu/$(CPU).mk
include arch/$(ARCH).mk

# dirs
CWD = $(CURDIR)
BIN = $(CWD)/bin
DOC = $(CWD)/doc
SRC = $(CWD)/src
TMP = $(CWD)/tmp

# tool
CURL = curl -L -o
CF   = clang-format -style=file -i
CC   = $(TARGET)-gcc
CXX  = $(TARGET)-g++
AS   = $(TARGET)-as
LD   = $(TARGET)-ld
OD   = $(TARGET)-objdump

# src
C += $(wildcard src/*.c*)
H += $(wildcard inc/*.h*)

# pkg
OBJ  = $(subst src/,bin/,$(subst .cpp,.o,$(C)))
DUMP = $(OBJ)

# all
.PHONY: all
all: fw/$(MODULE).kernel
	$(QEMU) $(QEMU_CFG) -kernel
fw/$(MODULE).kernel: $(OBJ)
	$(CXX) -o $@ $^

# format
.PHONY: format
format: tmp/format_cpp
tmp/format_cpp: $(C) $(H)
	$(CF) $? && touch $@

# rule
bin/%.o: src/%.cpp $(H)
	$(CXX) $(CFLAGS) -o $@ -c $<
tmp/%.objdump: bin/%.o
	$(OD) -x $< > $@

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
