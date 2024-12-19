# var
MODULE = $(notdir $(CURDIR))

# dir
CWD = $(CURDIR)

# tool
CURL = curl -L -o

# src
M += $(wildcard lib/*.ml*)
D += $(wildcard lib/dune)
MS = $(M) $(D) dune-project $(MODULE).opam

# all
.PHONY: all run ocaml
all: ocaml
run: $(M)
	dune run

# format
.PHONY: format
format: tmp/format_ml

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

# merge
MERGE += README.md Makefile apt.Debian
MERGE += .gitignore .clang-format
MERGE += .vscode lib src tmp
MERGE += $(MS)
