# Variables

SOURCE          = src
HOMEDIR         = $(shell cd && pwd)
TEMPDIR         = tmp
RSYNC_COMMAND   = rsync -avP -i --stats
RSYNC_OPTIONS   =
INSTALL_COMMAND = $(RSYNC_COMMAND) "$(SOURCE)/" "$(TARGET)" $(RSYNC_OPTIONS)

# Compound targets

INSTALLS = install install-test
PREVIEWS = preview preview-test

-include Makefile.override

# Targets

.PHONY: clean info $(INSTALLS) $(PREVIEWS)

clean:
	rm -rf $(TEMPDIR)

info:
	@echo SOURCE=$(SOURCE)
	@echo TARGET=$(TARGET)
	@echo INSTALLS=$(INSTALLS)
	@echo PREVIEWS=$(PREVIEWS)
	@echo RSYNC_COMMAND=$(RSYNC_COMMAND)
	@echo RSYNC_OPTIONS=$(RSYNC_OPTIONS)
	@echo INSTALL_COMMAND=$(INSTALL_COMMAND)
	@echo DOINSTALLPARTIAL_COMMAND=$(DOINSTALLPARTIAL_COMMAND)
	@echo 

$(TEMPDIR):
	mkdir -p $(TEMPDIR)

## Install into homedir

install: TARGET = $(HOMEDIR)
install: info
	$(INSTALL_COMMAND)

## Install into homedir (preview)

preview: TARGET        = $(HOMEDIR)
preview: RSYNC_OPTIONS = --dry-run
preview: info
	$(INSTALL_COMMAND)

## Install into tempdir

install-test: TARGET = $(TEMPDIR)
install-test: info $(TEMPDIR)
	$(INSTALL_COMMAND)

## Install into tempdir (preview)

preview-test: TARGET        = $(TEMPDIR)
preview-test: RSYNC_OPTIONS = --dry-run
preview-test: info $(TEMPDIR)
	$(INSTALL_COMMAND)
