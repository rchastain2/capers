#
# capers - Graphical Checker Board
# Don Dez 25 12:28:57 CET 2014
#
VERSION=1.0

# install paths
DESTDIR=/usr/local
BIN_DIR=$(DESTDIR)/bin
APP_DIR=$(DESTDIR)/lib/capers
LIB_DIR=$(APP_DIR)/lib
SHR_DIR=$(APP_DIR)/share
GMZ_DIR=$(APP_DIR)/games

# installed files
BIN=capers
LIB=cliche/dama.so cliche/simplech.so cake/cake.so

# TARGETS
all: subdirs

# subdirs
SUBDIRS=cliche cake
.PHONY: subdirs $(SUBDIRS)
subdirs: $(SUBDIRS)

$(SUBDIRS):
	@for d in $(SUBDIRS); do \
		(cd $$d && $(MAKE) DB___DIR=$(LIB_DIR)) \
	done

clean:
	@for d in $(SUBDIRS); do \
		(cd $$d && make clean) \
	done
	rm -f *.o *.out *~ tags *.pdn *-stamp
	find . -name "*~" -o -name "*.bak" | xargs rm -f
	find . -name "*.pyc" -o -name "*.pyo"  | xargs rm -f
	rm -f cliche/dama.so cliche/simplech.so cake/cake.so
	rm -f doc/capers.html cake/cake.dll cliche/cliche
	rm -rf debian/capers

bak: clean
	pydoc -w share/capers.py 
	mv capers.html doc
	(cd .. && tar cvfz capers-beta$(BETA).tar.gz capers)

install: $(SUBDIRS)
	python3 -m compileall share
	install -d $(APP_DIR)
	install capers $(APP_DIR)
	install -d $(BIN_DIR)
	ln -srf $(APP_DIR)/$(BIN) $(BIN_DIR)/$(BIN)
	install -d $(SHR_DIR)
	install share/capers.py $(SHR_DIR)
	install -m 644 share/capers.ui $(SHR_DIR)
	install -m 644 share/capers.xpm $(SHR_DIR)
	install -m 644 share/scene.xpm $(SHR_DIR)
	install -m 644 share/small.xpm $(SHR_DIR)
	install -m 644 share/stars.xpm $(SHR_DIR)
	install -m 644 share/red.xpm $(SHR_DIR)
	install -m 644 share/white.xpm $(SHR_DIR)
	install -m 644 share/capers.svg $(SHR_DIR)
	install -m 644 share/capers.png $(SHR_DIR)
	install -d $(LIB_DIR)
	install -s $(LIB) $(LIB_DIR)
	install -m 644 cake/xbook.bin $(LIB_DIR)
	install -m 644 cake/db.ini $(LIB_DIR)
	install -m 644 cake/db4 $(LIB_DIR)
	install -m 644 cake/db4.idx $(LIB_DIR)
	install -d $(GMZ_DIR)
	install -m 644 games/* $(GMZ_DIR)

.PHONY: clean bak install

profile:
	./profile
poke:
	GTK_MODULES=gail:atk-bridge

# DEBIAN PACKAGE
dpkg: clean
	fakeroot debian/rules binary
	echo rm -rf debian/capers
