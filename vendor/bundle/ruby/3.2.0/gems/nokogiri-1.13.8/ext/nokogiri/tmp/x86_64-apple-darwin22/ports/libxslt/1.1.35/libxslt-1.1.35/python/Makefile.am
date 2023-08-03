# Makefile for libxml2 python library
AUTOMAKE_OPTIONS = 1.4 foreign

SUBDIRS= . tests

AM_CFLAGS = $(LIBXML_CFLAGS)

DOCS_DIR = $(datadir)/doc/libxslt-python-$(LIBXSLT_VERSION)
# libxsltclass.txt is generated
DOCS=

EXTRA_DIST = 			\
	libxslt.c		\
	types.c			\
	generator.py		\
	libxml_wrap.h		\
	libxslt_wrap.h		\
	libxsl.py		\
	libxslt-python-api.xml	\
	$(DOCS)

libxsltmod_la_LDFLAGS =  -module -avoid-version

if WITH_PYTHON
mylibs = \
	$(top_builddir)/libxslt/libxslt.la \
	$(top_builddir)/libexslt/libexslt.la

all-local: libxslt.py

python_LTLIBRARIES = libxsltmod.la

libxsltmod_la_CPPFLAGS = \
	-I$(PYTHON_INCLUDES) \
	-I$(top_srcdir)/libxslt \
	-I$(top_srcdir) \
	-I../libexslt
libxsltmod_la_SOURCES = libxslt.c types.c
nodist_libxsltmod_la_SOURCES = libxslt-py.c
libxsltmod_la_LIBADD = $(mylibs) $(PYTHON_LIBS)

libxslt.py: $(srcdir)/libxsl.py libxsltclass.py
	cat $(srcdir)/libxsl.py libxsltclass.py > $@

install-data-local:
	$(MKDIR_P) $(DESTDIR)$(pythondir)
	$(INSTALL) -m 0644 libxslt.py $(DESTDIR)$(pythondir)
	$(MKDIR_P) $(DESTDIR)$(DOCS_DIR)
	@(for doc in $(DOCS) ; \
	   do $(INSTALL) -m 0644 $(srcdir)/$$doc $(DESTDIR)$(DOCS_DIR) ; done)

uninstall-local:
	rm -f $(DESTDIR)$(pythondir)/libxslt.py
	rm -rf $(DESTDIR)$(DOCS_DIR)

GENERATE = generator.py
API_DESC = $(top_srcdir)/doc/libxslt-api.xml $(srcdir)/libxslt-python-api.xml
GENERATED= libxsltclass.py \
	   libxslt-export.c \
	   libxslt-py.c \
	   libxslt-py.h \
	   libxsltclass.txt

$(GENERATED): gen_prog

gen_prog:  $(srcdir)/$(GENERATE) $(API_DESC)
	SRCDIR=$(srcdir) $(PYTHON) $(srcdir)/$(GENERATE)
	touch gen_prog

$(libxsltmod_la_OBJECTS): $(GENERATED)

endif

tests test: all
	cd tests && $(MAKE) tests

CLEANFILES= $(GENERATED) *.o libxslt.so *.pyc libxslt.py gen_prog
