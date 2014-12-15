# -*- coding: utf-8 -*-
# :Progetto:  password-manager -- main bootstrap file
# :Creato:    ven 12 dic 2014 13:03:43 CET
# :Autore:    Alberto Berti <alberto@metapensiero.it>
# :Licenza:   GNU General Public License version 3 or later
#

export TOPDIR := $(CURDIR)
export SHELL := /bin/bash
export VENVDIR := $(TOPDIR)/env
export PYTHON := $(VENVDIR)/bin/python
export SYS_PYTHON := /usr/bin/python2.7
export DOIT := $(VENVDIR)/bin/doit

VENV_VER = 1.11.6
VENV_SETUP := https://pypi.python.org/packages/source/v/virtualenv/virtualenv-$(VENV_VER).tar.gz
PIP := $(VENVDIR)/bin/pip
PIP_SETUP := https://raw.github.com/pypa/pip/master/contrib/get-pip.py
REQUIREMENTS_TIMESTAMP := $(VENVDIR)/requirements.timestamp
WGET := wget --quiet --no-check-certificate

# This is the default target, when no target is specified on the command line
.PHONY: all
all:: virtualenv doit

## virtual env rules

.PHONY: virtualenv
virtualenv: $(VENVDIR) requirements

$(VENVDIR):
	@echo "Bootstrapping Python 2.7 virtualenv..."
	@$(WGET) $(VENV_SETUP) -O venv.tgz
	@tar -xzf venv.tgz
	@-cd virtualenv-$(VENV_VER) && $(SYS_PYTHON) virtualenv.py ../env
	@-rm -rf $(TOPDIR)/virtualenv-* $(TOPDIR)/venv.tgz

.PHONY: requirements
requirements: $(REQUIREMENTS_TIMESTAMP)

$(REQUIREMENTS_TIMESTAMP): requirements.txt
	@echo "Installing pre-requirements..."
	@PATH=$(TOPDIR)/bin:$(PATH) $(PIP) install  -r requirements.txt | grep --line-buffered -v '^   '
	@touch $@

.PHONY: doit
doit: requirements
	@echo "Running doit in auto mode, just modify and save files to trigger recompilations..."
	@$(DOIT) auto
