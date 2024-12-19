(lang dune 3.11)
(generate_opam_files true)

(package
 (name           legas)
 (authors       "Dmitry Ponyatov <dponyatov@gmail.com>")
 (maintainers   "Dmitry Ponyatov <dponyatov@gmail.com>")
 (license        MIT)
 (source        (github ponyatov/legas))
 (documentation  https://url/to/documentation)
 (synopsis      "legacy software analysis")
 (description   "legacy software analysis")
 (depends        ocaml core dune utop ocamlformat batteries)
 (tags
  (legacy compiler "source code")))
