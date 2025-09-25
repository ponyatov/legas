.PHONY: doc
doc:

.PHONY: doxy
doxy: .doxygen doc/DoxygenLayout.xml doc/logo.png
	rm -rf doc/html ; doxygen $< 1>/dev/null

REF += doc/compiler/Appel_compiling-with-continuations.pdf
doc/compiler/Appel_compiling-with-continuations.pdf:
	$(CURL) $@ https://scispace.com/pdf/compiling-with-continuations-16ejf5h952.pdf

REF += doc/compiler/Nguyen_OCaml_LLVM.pdf
doc/compiler/Nguyen_OCaml_LLVM.pdf:
	$(CURL) $@ https://www.theseus.fi/bitstream/handle/10024/166119/Nguyen_Anh%20.pdf

REF += doc/compiler/Sestoft_PLC.pdf
doc/compiler/Sestoft_PLC.pdf:
	$(CURL) $@ http://ijevanlib.ysu.am/wp-content/uploads/2017/12/plcsd-1-2.pdf

REF += doc/OCaml/Minsky_Madhavapeddy_Hickey_ru.pdf
doc/OCaml/Minsky_Madhavapeddy_Hickey_ru.pdf:
	$(CURL) $@ http://khizha.dp.ua/library/Minsky_Madhavapeddy_Hickey_-_Real_World_OCaml_-_2013_ru.pdf
