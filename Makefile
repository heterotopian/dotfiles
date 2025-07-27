# Variables

SOURCE        = src
HOMEDIR       = $(shell cd && pwd)
TEMPDIR       = tmp
RSYNC_CMD     = rsync -avP -i --stats
RSYNC_OPTIONS =

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

install: TARGET = $(HOMEDIR)
install: info
	$(RSYNC_CMD) "$(SOURCE)/" "$(TARGET)" $(RSYNC_OPTIONS)

install-test: TARGET = $(TEMPDIR)
install-test: info $(TEMPDIR)
	$(RSYNC_CMD) "$(SOURCE)/" "$(TARGET)" $(RSYNC_OPTIONS)

preview: TARGET = $(HOMEDIR)
preview: RSYNC_OPTIONS = --dry-run
preview: info
	$(RSYNC_CMD) "$(SOURCE)/" "$(TARGET)" $(RSYNC_OPTIONS)

preview-test: TARGET = $(TEMPDIR)
preview-test: RSYNC_OPTIONS = --dry-run
preview-test: info $(TEMPDIR)
	$(RSYNC_CMD) "$(SOURCE)/" "$(TARGET)" $(RSYNC_OPTIONS)

$(TEMPDIR):
	mkdir -p $(TEMPDIR)
