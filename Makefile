CURDIR := $(shell pwd)
USER := $(shell whoami)
HOME := $(shell echo "${HOME}")
MUNKIPKG := /usr/local/bin/munkipkg
PKG_ROOT := $(CURDIR)/pkg/FinderServerFavourites/payload
PKG_BUILD := $(CURDIR)/pkg/FinderServerFavourites/build
PYTHON := python3
PYTHON_VERSION := 3.10.2
PYTHON_INSTALLER_SCRIPT := $(HOME)/sourcecode/relocatable-python/make_relocatable_python_framework.py
PYTHON_REQUIREMENTS := $(CURDIR)/requirements_python3.txt

all: build

.PHONY : build
build: 
	@echo "Copying FinderServerFavourites.py into /Library/Management/FinderServerFavourites"
	mkdir -p "$(PKG_ROOT)/Library/Management/FinderServerFavourites"
	cp "$(CURDIR)/FinderServerFavourites.py" "$(PKG_ROOT)/Library/Management/FinderServerFavourites/FinderServerFavourites.py"

	@echo "Copying launcher.sh into /Library/Management/FinderServerFavourites"
	cp "$(CURDIR)/launcher.sh" "$(PKG_ROOT)/Library/Management/FinderServerFavourites/launcher.sh"
	chmod 755 "$(PKG_ROOT)/Library/Management/FinderServerFavourites/launcher.sh"

	@echo "Installing Python into /Library/Management/FinderServerFavourites"
	$(PYTHON) "$(PYTHON_INSTALLER_SCRIPT)" --destination "$(PKG_ROOT)/Library/Management/FinderServerFavourites/" --python-version=$(PYTHON_VERSION) --os-version 11 --pip-requirements="$(PYTHON_REQUIREMENTS)" --upgrade-pip

	@echo "Making package in $(PKG_BUILD) directory"
	cd $(CURDIR)/pkg && python3 $(MUNKIPKG) FinderServerFavourites
	open $(PKG_BUILD)


.PHONY : clean
clean :
	@echo "Cleaning up package root"
	rm -Rf "$(PKG_ROOT)/Library/Management/FinderServerFavourites/"* ||:
	rm $(PKG_BUILD)/*.pkg ||:
