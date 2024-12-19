(lang dune 3.16)

(name legas)

(generate_opam_files true)

(source
 (github ponyatov/legas))

(authors "Dmitry Ponyatov <dponyatov@gmail.com>")

(maintainers "Dmitry Ponyatov <dponyatov@gmail.com>")

(license MIT)

(documentation https://url/to/documentation)

(package
 (name legas)
 (synopsis "legacy software analysis")
 (description "legacy software analysis")
 (depends ocaml dune ocamlfmt)
 (tags
  (legacy compiler "source code")))
