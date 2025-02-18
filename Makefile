# =======================================
# This makefile contains targets for
# installing packages and dependencies.
# =======================================

SHELL := /bin/bash

# =======================================
# Variables
# ========================================

CPANM = $(HOME)/perl5/bin/cpanm

LOCAL_BIN    = $(HOME)/.local/bin
LOCAL_CONFIG = $(HOME)/.local/config

# =======================================
# Targets
# ========================================

.PHONY: phony
phony:

setup: phony setup/dirs setup/perl
	@echo 'Setup complete.'

clean: phony clean/perl clean/dirs
	@echo 'Clean complete.'

key/github: phony
	export GITHUB_KEY="github.$$(hostname).$$(date +%F)" \
	    && cd $(HOME)/.ssh \
	    && ssh-keygen -t ed25519 -f $${GITHUB_KEY} -C "$${GITHUB_KEY}" \
	    && ln -s -f $${GITHUB_KEY} github.current \
	    && ln -s -f $${GITHUB_KEY}.pub github.current.pub \
	    && cat $${GITHUB_KEY}.pub


# =======================================
# Common Directories
# ========================================

setup/dirs: $(LOCAL_BIN) $(LOCAL_CONFIG)

clean/dirs:
	rmdir $(LOCAL_BIN) $(LOCAL_CONFIG)

$(LOCAL_BIN):
	mkdir -p $(LOCAL_BIN)

$(LOCAL_CONFIG):
	mkdir -p $(LOCAL_CONFIG)

# =======================================
# Perl Dependencies
# ========================================

setup/perl: $(CPANM) $(HOME)/perl5/cpanm.update

clean/perl:
	rm -rfv $(HOME)/perl5 $(HOME)/.cpan $(HOME)/.cpanm

$(CPANM):
	cpan -I App::cpanminus

$(HOME)/perl5/cpanm.update: $(CPANM) cpanfile
	$(CPANM) --local-lib $(HOME)/perl5 --installdeps .
	touch $(HOME)/perl5/cpanm.update

