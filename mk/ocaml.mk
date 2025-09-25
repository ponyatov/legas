ocaml: $(UTOP) $(DUNE)
$(UTOP): $(OPAM) $(OCAMLC)
	$< install -y utop && touch $@
$(DUNE): $(OPAM) $(OCAMLC)
	$< install -y dune && touch $@
$(OCAMLC): $(OPAM)
	$< switch create $(OCAML_VER) && touch $@
$(OPAM):
	bash -c "sh <(curl -fsSL https://opam.ocaml.org/install.sh)"
	$@ init
