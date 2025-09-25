# var
MODULE = $(notdir $(CURDIR))

# dir
CWD = $(CURDIR)

# tool
CURL = curl -L -o
CF   = clang-format -style=file -i

# src
M += $(wildcard lib/*.ml*)
D += $(wildcard lib/dune)
MS = $(M) $(D) dune-project $(MODULE).opam

C += $(wildcard src/*.c*)
H += $(wildcard inc/*.h*)

# cfg
CFLAGS += -Iinc -Itmp -O0 -g3

# all
.PHONY: all run ocaml
all: bin/$(MODULE)
run: bin/$(MODULE)
	$^

# format
.PHONY: format
format: tmp/format_cpp tmp/format_ml

tmp/format_cpp: $(C) $(H)
	$(CF) $? && touch $@
tmp/format_ml: $(M) $(D) .ocamlformat
	dune build @fmt && touch $@

.ocamlformat:
	echo "version=`ocamlformat --version`"  > $@
	echo "profile=default"                 >> $@
	echo "margin=80"                       >> $@
	echo "line-endings=lf"                 >> $@
	echo "break-cases=all"                 >> $@
	echo "wrap-comments=true"              >> $@
	echo "break-string-literals=never"     >> $@

# rule
bin/$(MODULE): $(C) $(H)
	$(CXX) $(CFLAGS) -o $@ $(C) $(L)

# include
.PHONY: install update ref gz
install: ref gz
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -uy `cat apt.$(shell lsb_release -si)`
ref:
gz:

# merge
MERGE += README.md Makefile apt.Debian
MERGE += .gitignore .clang-format
MERGE += .vscode lib src tmp
MERGE += $(MS)
