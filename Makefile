# Variables

SRCDIR       = src.stow
HOMEDIR      = ~
TEMPDIR      = tmp
UNFOLDS      = .atom .config
STOWPACKAGES = atom bash git tmux vim

TARGETDIR    = $(TEMPDIR)
TARGETDIRS   = $(TARGETDIR) $(addprefix $(TARGETDIR)/,$(UNFOLDS))

# Targets

.DEFAULT_GOAL = info

.PHONY: info clean preview install

$(TARGETDIRS):
	mkdir -p $@

info:
	@echo SRCDIR=$(SRCDIR)
	@echo HOMEDIR=$(HOMEDIR)
	@echo TEMPDIR=$(TEMPDIR)
	@echo UNFOLDS=$(UNFOLDS)
	@echo TARGETDIR=$(TARGETDIR)
	@echo TARGETDIRS=$(TARGETDIRS)

clean:
	rm -rf $(TEMPDIR)

preview: $(TARGETDIRS)
	stow -d $(SRCDIR) -t $(TARGETDIR) -v -n $(STOWPACKAGES)

install: $(TARGETDIRS)
	stow -d $(SRCDIR) -t $(TARGETDIR) -v $(STOWPACKAGES)
