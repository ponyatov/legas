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

# version
LINUX_VER = 6.6.31

# dirs
CWD = $(CURDIR)
BIN = $(CWD)/bin
DOC = $(CWD)/doc
SRC = $(CWD)/src
TMP = $(CWD)/tmp
GZ  = $(HOME)/gz

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

# package
LINUX    = linux-$(LINUX_VER)
LINUX_GZ = $(LINUX).tar.xz

# cfg
LDFLAGS += -T lib/$(HW).ld

# all
OBJ  = $(subst src/,bin/,$(subst .cpp,.o,$(C)))
DUMP = $(subst bin/,tmp/,$(subst .o,.objdump,$(OBJ))) tmp/$(MODULE).objdump

.PHONY: all
all: fw/$(MODULE).kernel $(DUMP)
	$(QEMU) $(QEMU_CPU) $(QEMU_RAM) $(QEMU_CFG) -kernel $<
fw/$(MODULE).kernel: $(OBJ)
	$(LD) $(LDFLAGS) -o $@ $^

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
tmp/%.objdump: fw/%.kernel
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
gz: \
	$(GZ)/$(LINUX_GZ)
ref:

$(GZ)/$(LINUX_GZ):
	$(CURL) $@ https://cdn.kernel.org/pub/linux/kernel/v6.x/$(LINUX_GZ)
