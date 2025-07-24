# Variables

SOURCE      = src
HOMEDIR     = $(shell cd && pwd)
TEMPDIR     = tmp
INSTALL_CMD = rsync -avP -i --stats "$(SOURCE)/" "$(TARGET)"

-include Makefile.override

# Targets

INSTALLS = install install-test
PREVIEWS = preview preview-test

.PHONY: clean $(INSTALLS) $(PREVIEWS)

clean:
	rm -rf $(TEMPDIR)

install: TARGET = $(HOMEDIR)
install:
	$(INSTALL_CMD)

install-test: TARGET = $(TEMPDIR)
install-test: $(TEMPDIR)
	$(INSTALL_CMD)

preview: TARGET = $(HOMEDIR)
preview:
	$(INSTALL_CMD) --dry-run

preview-test: TARGET = $(TEMPDIR)
preview-test: $(TEMPDIR)
	$(INSTALL_CMD) --dry-run

$(TEMPDIR):
	mkdir -p $(TEMPDIR)
