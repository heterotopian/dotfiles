HOMEDIR = $(shell cd && pwd)
TEMPDIR = tmp

.PHONY: clean install install-rsync import test test-install-rsync

clean:
	rm -rf $(TEMPDIR)

install: install-rsync

install-rsync:
	bin/install-rsync src $(HOMEDIR)

import:

test: test-install-rsync

test-install-rsync: clean
	mkdir -p $(TEMPDIR)
	bin/install-rsync src $(TEMPDIR)
