ocaml: $(UTOP) $(DUNE) $(OFMT) $(OLSP)

$(UTOP): $(OPAM) $(OCAMLC)
	opam install -y utop && touch $@
$(DUNE): $(OPAM) $(OCAMLC)
	opam install -y dune && touch $@
$(OFMT): $(OPAM) $(OCAMLC)
	opam install -y ocamlformat && touch $@
$(OLSP): $(OPAM) $(OCAMLC)
	opam install -y ocaml-lsp-server && touch $@

$(OCAMLC): $(OPAM)
	$< switch create $(OCAML_VER) && touch $@
$(OPAM):
	bash -c "sh <(curl -fsSL https://opam.ocaml.org/install.sh)"
	$@ init
