SOURCE  = src
HOMEDIR = $(shell cd && pwd)
TEMPDIR = tmp

INSTALLS = install install-test

.PHONY: clean $(INSTALLS)

clean:
	rm -rf $(TEMPDIR)

$(TEMPDIR):
	mkdir -p $(TEMPDIR)

install:
	rsync -avP "$(SOURCE)/" "$(HOMEDIR)"

install-test: $(TEMPDIR)
	rsync -avP "$(SOURCE)/" "$(TEMPDIR)"
