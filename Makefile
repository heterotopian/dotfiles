# Variables

STOW_DIR      = src.stow
STOW_TARGET   = tmp.stow
STOW_PACKAGES = atom bash git tmux vim
UNFOLD_DIRS   = .atom .config

# Compound targets

TARGET_DIRS = $(STOW_TARGET) $(addprefix $(STOW_TARGET)/,$(UNFOLD_DIRS))

# Targets

.DEFAULT_GOAL = info

.PHONY: info clean preview install

$(TARGET_DIRS):
	mkdir -p $@

info:
	@echo STOW_DIR=$(STOW_DIR)
	@echo STOW_TARGET=$(STOW_TARGET)
	@echo STOW_PACKAGES=$(STOW_PACKAGES)
	@echo UNFOLD_DIRS=$(UNFOLD_DIRS)
	@echo TARGET_DIRS=$(TARGET_DIRS)

clean:
	rm -rf $(STOW_TARGET)

preview: $(TARGET_DIRS)
	stow -n -v -d $(STOW_DIR) -t $(STOW_TARGET) $(STOW_PACKAGES)

install: $(TARGET_DIRS)
	stow -v -d $(STOW_DIR) -t $(STOW_TARGET) $(STOW_PACKAGES)
