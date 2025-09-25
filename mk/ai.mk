.PHONY: ai tmp/$(APP).ai.md
ai: tmp/$(APP).ai.md
tmp/$(APP).ai.md:
	echo "# $(APP)\n" > $@
	cat README.md $(HOME)/metadoc/$(APP)/*.md doc/*.md $(C) $(H) $(R) $(S) >> $@
