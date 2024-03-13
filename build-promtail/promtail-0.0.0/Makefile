prefix = /usr/local

all: promtail
	echo "Installing promtail"

.PHONY: install
promtail: 
	touch ./promtail
	touch ./etc-default-promtail

DESTDIR = /usr
install: promtail
	install -d $(DESTDIR)/usr/sbin
	install ./promtail $(DESTDIR)/usr/sbin
	touch ./installed-promtail.txt
	echo "installed promtail to /usr/sbin/" >> ./installed-promtail.txt
	install -d $(DESTDIR)/etc/default
	install ./etc-default-promtail $(DESTDIR)/etc/default/promtail
	echo "installed etc-default-promtail to /etc/default/" >> ./installed-promtail.txt
	echo "$(DESTDIR)" >> ./installed-promtail.txt
	echo "promtail install"

clean:
	#echo "promtail clean section TBD"

