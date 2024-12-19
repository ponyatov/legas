# var
MODULE = $(notdir $(CURDIR))

# dir
CWD = $(CURDIR)

# tool
CURL = curl -L -o

# src
M += $(wildcard lib/*.ml*) $(wildcard src/*.ml*)
MS = $(M) dune-project $(MODULE).opam

# all
.PHONY: all run ocaml
all: ocaml
run: $(M)
	dune run

# merge
MERGE += README.md Makefile apt.Debian
MERGE += .gitignore .clang-format
MERGE += .vscode lib src tmp
MERGE += $(MS)
