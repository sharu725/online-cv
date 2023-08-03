## Process this file with automake to produce Makefile.in

$(top_builddir)/xsltproc/xsltproc:
	@(cd ../../xsltproc ; $(MAKE) xsltproc)

EXTRA_DIST = data.xml vrml.xsl vrml.xml svg.xsl svg.xml	html.xsl html.xml

CLEANFILES = .memdump

valgrind:
	@echo '## Running the regression tests under Valgrind'
	$(MAKE) CHECKER='libtool --mode=execute valgrind -q --leak-check=full' tests

# Just 3 specific files tested, they either work or don't!
test tests: $(top_builddir)/xsltproc/xsltproc
	@echo '## Running REC2 tests'
	@(echo > .memdump)
	@($(CHECKER) $(top_builddir)/xsltproc/xsltproc $(srcdir)/vrml.xsl $(srcdir)/data.xml > vrml.res ; \
	diff $(srcdir)/vrml.xml vrml.res ; \
	grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true;\
	rm -f vrml.res)
	@($(CHECKER) $(top_builddir)/xsltproc/xsltproc $(srcdir)/svg.xsl $(srcdir)/data.xml > svg.res ; \
	diff $(srcdir)/svg.xml svg.res ; \
	grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true;\
	rm -f svg.res)
	@($(CHECKER) $(top_builddir)/xsltproc/xsltproc $(srcdir)/html.xsl $(srcdir)/data.xml > html.res ; \
	diff $(srcdir)/html.xml html.res ; \
	grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true;\
	rm -f html.res)

