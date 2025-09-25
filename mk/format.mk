.PHONY: format
format: tmp/format_cpp tmp/format_py tmp/format_fsh

tmp/format_cpp: $(C) $(H)
	$(CF) $? && touch $@

tmp/format_py: $(P)
	$(PEP) $? && touch $@

tmp/format_fsh: $(F)
	dotnet fantomas --force $? && touch $@
