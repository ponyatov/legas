.PHONY: format
format: tmp/format_cpp tmp/format_ml

tmp/format_cpp: $(C) $(H)
	$(CF) $? && touch $@

tmp/format_py: $(P)
	$(PEP) $? && touch $@

tmp/format_ml: $(O) .ocamlformat
	$(OFMT) -i $(O) && touch $@
