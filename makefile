SHELL=/bin/bash
NAME=vectorcharts

update:
	make -B de nl

charts/%.pmtiles:
	URL=https://freenauticalchart.net/vector/$(patsubst charts/%.pmtiles,%.pmtiles,$@); \
	MOD=$$(curl -sI $$URL | grep -i last-modified | sed 's/^[^:]*:[[:space:]]*//') ; \
	REMOTE=$$(date -d "$$MOD" +%s); LOCAL=$$(date -r $@ +%s); \
	if [ ! -f $@ ] || (( $$REMOTE > $$LOCAL )); then \
		wget -O $@- $$URL && mv $@- $@; \
	else \
		echo "$@ is up to date"; \
	fi

de: charts/fnc-de.pmtiles
nl: charts/fnc-nl.pmtiles
us: charts/noaa.pmtiles

build: plugin.json
	rm -rf $(NAME)
	mkdir $(NAME)
	zip -r $(NAME)-$(shell jq -r .version $<).zip $(NAME)

new-version: plugin.json
	jq ".version=\"$(shell date +%Y%m%d)\"" $< > $<-
	mv $<- $<

clean:
	rm -f *.zip

cleaner: clean
	rm -f charts/*.pmtiles
