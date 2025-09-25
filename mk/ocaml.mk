ocaml: $(UTOP)
$(UTOP): $(OCAMLC)
	opam install -y utop
$(OCAMLC): $(OPAM)
	opam switch create 5.3.0
$(OPAM):
	sudo apt install -yt opam dune
	opam init
# 	opam switch create $(OCAML_VER)
# 	bash -c "sh <(curl -fsSL https://opam.ocaml.org/install.sh)"
