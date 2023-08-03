LIBXSLT_LIBS = $(top_builddir)/libxslt/libxslt.la \
               $(top_builddir)/libexslt/libexslt.la

EXTRA_PROGRAMS = xpath xslt
check_PROGRAMS = testTargets
EXTRA_DIST = xpath.dict xpath.xml xslt.dict xslt.xml seed
CLEANFILES = $(EXTRA_PROGRAMS)
AM_CPPFLAGS = -I$(top_srcdir)
AM_CFLAGS = $(LIBXML_CFLAGS)
DEPENDENCIES = $(LIBXSLT_LIBS)
LDADD = $(LIBXSLT_LIBS) \
        $(LIBGCRYPT_LIBS) $(LIBXML_LIBS) $(EXTRA_LIBS) $(M_LIBS)

xpath_SOURCES = xpath.c fuzz.c fuzz.h
xpath_LDFLAGS = -fsanitize=fuzzer

xslt_SOURCES = xslt.c fuzz.c fuzz.h
xslt_LDFLAGS = -fsanitize=fuzzer

testTargets_SOURCES = testTargets.c fuzz.c fuzz.h

$(top_builddir)/libxslt/libxslt.la:
	cd $(top_builddir)/libxslt && $(MAKE) libxslt.la

$(top_builddir)/libexslt/libexslt.la: $(top_builddir)/libxslt/libxslt.la
	cd $(top_builddir)/libexslt && $(MAKE) libexslt.la

.PHONY: tests fuzz-xpath fuzz-xslt

tests:

fuzz: $(check_PROGRAMS)
	@echo '## Running fuzz target tests'
	@./testTargets $(srcdir)

fuzz-xpath: xpath$(EXEEXT)
	@mkdir -p corpus/xpath
	./xpath$(EXEEXT) \
            -max_len=256 \
            -dict=$(srcdir)/xpath.dict \
	    corpus/xpath $(srcdir)/seed/xpath

fuzz-xslt: xslt$(EXEEXT)
	@mkdir -p corpus/xslt
	./xslt$(EXEEXT) \
            -dict=$(srcdir)/xslt.dict \
	    corpus/xslt $(srcdir)/seed/xslt

