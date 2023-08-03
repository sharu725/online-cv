## Process this file with automake to produce Makefile.in

$(top_builddir)/xsltproc/xsltproc:
	@(cd ../../xsltproc ; $(MAKE) xsltproc)

EXTRA_DIST = doc.xsl doc.xml doc.dtd result.xml

CLEANFILES = .memdump

valgrind:
	@echo '## Running the regression tests under Valgrind'
	$(MAKE) CHECKER='libtool --mode=execute valgrind -q --leak-check=full' tests

# No special stuff here, just a single test that either works or doesn't!
test tests: $(top_builddir)/xsltproc/xsltproc
	@echo '## Running REC1 tests'
	@(echo > .memdump)
	@($(CHECKER) $(top_builddir)/xsltproc/xsltproc \
	  $(srcdir)/doc.xsl $(srcdir)/doc.xml > doc.res ; \
	diff $(srcdir)/result.xml doc.res ; \
	grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true; \
	rm -f doc.res)

