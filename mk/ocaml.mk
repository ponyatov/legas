ocaml:
	sudo apt install -yt opam ocaml dune
	opam init
	opam switch create 5.3.0
# 	opam switch create $(OCAML_VER)
	opam install utop
# 	bash -c "sh <(curl -fsSL https://opam.ocaml.org/install.sh)"
