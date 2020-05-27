# Parameters
HOMEDIR = $(shell cd && pwd)
TEMPDIR = tmp

# Targets
INSTALLS = install-rsync install-symlink
COMMANDS = $(INSTALLS) import uninstall
TESTS    = $(addprefix test-,$(COMMANDS))

.PHONY: clean install $(COMMANDS) test $(TESTS)

clean:
	rm -rf $(TEMPDIR)

$(TEMPDIR):
	mkdir -p $(TEMPDIR)

# Commands

install: install-rsync

install-rsync:
	bin/install-rsync src $(HOMEDIR)

install-symlink:

import:
	bin/foreach-installed src $(HOMEDIR) 'cp -ra $$1 $$0/'

uninstall:
	bin/foreach-installed src $(HOMEDIR) 'echo rm -r $$1'

# Tests

test: test-install-rsync

test-install-rsync: clean $(TEMPDIR)
	bin/install-rsync src $(TEMPDIR)

test-install-symlink:

test-import: clean $(TEMPDIR)
	cp -ra src/. $(TEMPDIR)
	bin/foreach-installed src $(HOMEDIR) 'cp -ra $$1 $(TEMPDIR)/'

test-uninstall:
