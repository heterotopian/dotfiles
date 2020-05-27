HOMEDIR = $(shell cd && pwd)
TEMPDIR = tmp

.PHONY: clean install install-rsync import test test-install-rsync test-import

clean:
	rm -rf $(TEMPDIR)

$(TEMPDIR):
	mkdir -p $(TEMPDIR)

install: install-rsync

install-rsync:
	bin/install-rsync src $(HOMEDIR)

import:
	bin/foreach-installed src $(HOMEDIR) 'cp -ra $$1 $$0/'

test: test-install-rsync

test-install-rsync: clean $(TEMPDIR)
	bin/install-rsync src $(TEMPDIR)

test-import: clean $(TEMPDIR)
	cp -ra src/. $(TEMPDIR)
	bin/foreach-installed src $(HOMEDIR) 'cp -ra $$1 $(TEMPDIR)/'
