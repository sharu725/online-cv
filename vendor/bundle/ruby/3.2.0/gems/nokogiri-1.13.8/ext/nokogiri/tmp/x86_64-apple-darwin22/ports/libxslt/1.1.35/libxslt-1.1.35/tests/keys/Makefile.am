## Process this file with automake to produce Makefile.in

$(top_builddir)/xsltproc/xsltproc:
	@(cd ../../xsltproc ; $(MAKE) xsltproc)

EXTRA_DIST = dates.xml month.xml month.xsl month.out

CLEANFILES = .memdump

valgrind:
	@echo '## Running the regression tests under Valgrind'
	$(MAKE) CHECKER='libtool --mode=execute valgrind -q --leak-check=full' tests

test tests: $(top_builddir)/xsltproc/xsltproc
	@echo '## Running keys tests'
	@(echo > .memdump)
	@($(CHECKER) $(top_builddir)/xsltproc/xsltproc $(srcdir)/month.xsl $(srcdir)/dates.xml > month.res ; \
	if [ -r $(srcdir)/month.out ] ; \
	then diff $(srcdir)/month.out month.res ; \
	else mv month.res $(srcdir)/month.out ; fi ; \
	grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true;\
	rm -f month.res)

