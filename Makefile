# var
MODULE = $(notdir $(CURDIR))
NOW    = $(shell date +%d%m%y)
REL    = $(shell git rev-parse --short=4 HEAD)
BRANCH = $(shell git rev-parse --abbrev-ref HEAD)

TRIPLET = i686-unknown-none

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
CAR = $(HOME)/.cargo

# tool
CURL   = curl -L -o
CF     = clang-format -style=file -i
ST     = /opt/Sourcetrail/bin/sourcetrail
CC     = $(TARGET)-gcc
CXX    = $(TARGET)-g++
AS     = $(TARGET)-as
LD     = $(TARGET)-ld
OD     = $(TARGET)-objdump
RUSTUP = $(CAR)/bin/rustup
CARGO  = $(CAR)/bin/cargo

# src
C += $(wildcard src/*.c*)
H += $(wildcard inc/*.h*)
R += $(wildcard src/*.rs*)

# package
LINUX     = linux-$(LINUX_VER)
LINUX_GZ  = $(LINUX).tar.xz
LINUX_URL = https://cdn.kernel.org/pub/linux/kernel/v6.x

STRAIL_VER = 2021.4.19
STRAIL     = Sourcetrail_$(STRAIL_VER)
STRAIL_GZ  = $(subst .,_,$(STRAIL))_Linux_64bit.tar.gz
STRAIL_URL = https://github.com/CoatiSoftware/Sourcetrail/releases/download

NEWLIB_VER = 4.4.0.20231231
NEWLIB     = newlib-$(NEWLIB_VER)
NEWLIB_GZ  = $(NEWLIB).tar.gz
NEWLIB_URL = ftp://sourceware.org/pub/newlib

# cfg
GCCFLAGS += -nostdlib
CFLAGS   += -Iinc -Itmp -march=$(CPU) -ffreestanding
LDFLAGS  += -T lib/$(HW).ld

# all
OBJ  = $(subst src/,bin/,$(addsuffix .o,$(basename $(C))))
DUMP = $(subst bin/,tmp/,$(subst .o,.objdump,$(OBJ))) tmp/$(MODULE).objdump
OBJ  = bin/multiboot bin/$(MODULE)

.PHONY: all run
all: fw/$(MODULE).kernel $(DUMP)
run: fw/$(MODULE).kernel $(DUMP)
	$(QEMU) $(QEMU_CPU) $(QEMU_RAM) $(QEMU_CFG) -kernel $<

.PHONY: mb1 mb2
mb1: bin/multiboot1 tmp/multiboot1.objdump
	$(QEMU) $(QEMU_CFG) -kernel $<
mb2: fw/$(MODULE).iso tmp/multiboot2.objdump
	$(QEMU) $(QEMU_CFG) -cdrom $<
fw/$(MODULE).iso: bin/multiboot1 bin/multiboot2 bin/boot/grub/grub.cfg Makefile
	grub-file --is-x86-multiboot  bin/multiboot1
	grub-file --is-x86-multiboot2 bin/multiboot2
	rm -f $@ ; grub-mkrescue -o $@ bin

.PHONY: st
st: $(ST)
	$^ $(MODULE).srctrlprj &

.PHONY: qemu
qemu: bin/$(MODULE).boot rust
	grub-file --is-x86-multiboot $<
	$(QEMU) $(QEMU_CFG) -kernel $<

.PHONY: rust
rust: tmp/$(MODULE).objdump
# tmp/$(MODULE).boot.objdump tmp/multiboot.objdump tmp/kernel.objdump
bin/$(MODULE).boot: src/$(ARCH).ld $(OBJ)
	$(LD) -z noexecstack -T $< -z noexecstack -o $@ $(OBJ)

bin/$(MODULE): $(CARGO) $(R)
	clear ; $(CARGO) build --out-dir=$(dir $@) -Z unstable-options

# format
.PHONY: format
format: tmp/format_cpp tmp/format_rs
tmp/format_cpp: $(C) $(H)
	$(CF) $? && touch $@
tmp/format_rs: $(R)
	$(CARGO) fmt && touch $@

# rule
bin/%: tmp/%.o src/i386.ld
	$(LD) -n -T src/i386.ld -o $@ $<
tmp/%.o: src/%.nasm
	nasm -f elf32 -o $@ $<

bin/%.o: src/%.cpp $(H)
	$(CXX) $(CFLAGS) $(GCCFLAGS) -o $@ -c $<
bin/%.o: src/%.c $(H)
	$(CC)  $(CFLAGS) $(GCCFLAGS) -o $@ -c $<
fw/$(MODULE).kernel: $(OBJ) lib/$(HW).ld
	$(LD) $(LDFLAGS) $(GCCFLAGS) -o $@ $(OBJ)

tmp/%.objdump: bin/%.o
	$(OD) -x $< > $@
tmp/%.objdump: bin/%
	$(OD) -x $< > $@
tmp/%.objdump: fw/%.kernel
	$(OD) -x $< > $@

ref/%/README: $(GZ)/%.tar.xz
	tar -C ref -xf $< && touch $@
ref/%/README: $(GZ)/%.tar.gz
	tar -C ref -xf $< && touch $@

# doc
.PHONY: doc
doc: \
	doc/libc.pdf doc/libm.pdf doc/engler95exokernel.pdf

doc/libc.pdf:
	$(CURL) $@ ftp://sourceware.org/pub/newlib/libc.pdf
doc/libm.pdf:
	$(CURL) $@ ftp://sourceware.org/pub/newlib/libm.pdf
doc/engler95exokernel.pdf:
	$(CURL) $@ https://pdos.csail.mit.edu/6.828/2008/readings/engler95exokernel.pdf

.PHONY: doxy
doxy: .doxygen
	rm -rf docs ; doxygen $< 1>/dev/null
	rm -rf docs/$(MODULE) ; cargo doc
	cp -r target/$(TRIPLET)/doc docs/rust

# install
.PHONY: install update gz ref
install: doc gz ref $(RUSTUP)
	$(MAKE) update
	$(RUSTUP) component add rustfmt
	$(RUSTUP) target add x86_64-unknown-none

update:
	sudo apt update
	sudo apt install -uy `cat apt.txt`
gz: $(ST) \
	$(GZ)/$(LINUX_GZ) $(GZ)/$(NEWLIB_GZ)
ref: \
	ref/$(LINUX)/README ref/$(NEWLIB)/README ref/syslinux/README \
	ref/multiboot/README.md

$(GZ)/$(LINUX_GZ):
	$(CURL) $@ $(LINUX_URL)/$(LINUX_GZ)

$(ST): $(GZ)/$(STRAIL_GZ)
	cd /opt ; sudo tar zx < $< && touch $@
$(GZ)/$(STRAIL_GZ):
	$(CURL) $@ $(STRAIL_URL)/$(STRAIL_VER)/$(STRAIL_GZ)

$(GZ)/$(NEWLIB_GZ):
	$(CURL) $@ $(NEWLIB_URL)/$(NEWLIB_GZ)

ref/syslinux/README:
	git clone --depth 1 http://repo.or.cz/syslinux.git ref/syslinux

ref/multiboot/README.md:
	git clone --depth 1 https://github.com/gz/rust-multiboot.git ref/multiboot

$(RUSTUP) $(CARGO):
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
