## Process this file with automake to produce Makefile.in

$(top_builddir)/xsltproc/xsltproc:
	@(cd ../../xsltproc ; $(MAKE) xsltproc)

EXTRA_DIST = \
    bredfort.css bredfort.xsl doc_file.xml docfile.xml \
    fragment2.xml fragment.result fragment.xml fragment.xsl \
    index.xml menu.xml message.result message.xml message.xsl \
    result.xhtml system.xml test_bad.err test_bad.result \
    test_bad.xml test.result test.xml test.xsl worklog.xml

CLEANFILES = .memdump

valgrind:
	@echo '## Running the regression tests under Valgrind'
	$(MAKE) CHECKER='libtool --mode=execute valgrind -q --leak-check=full' tests

test tests: $(top_builddir)/xsltproc/xsltproc
	@(echo > .memdump)
	@($(CHECKER) $(top_builddir)/xsltproc/xsltproc $(srcdir)/bredfort.xsl $(srcdir)/index.xml > result ; \
	diff $(srcdir)/result.xhtml result; \
	grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true;\
	rm -f result)
	@($(CHECKER) $(top_builddir)/xsltproc/xsltproc $(srcdir)/test.xsl $(srcdir)/test.xml > result ; \
	diff $(srcdir)/test.result result; \
	grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true;\
	rm -f result)
	@($(CHECKER) $(top_builddir)/xsltproc/xsltproc $(srcdir)/test.xsl $(srcdir)/test_bad.xml > result 2>err ; \
	diff $(srcdir)/test_bad.result result; \
	diff $(srcdir)/test_bad.err err; \
	grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true;\
	rm -f result err)
	@($(CHECKER) $(top_builddir)/xsltproc/xsltproc $(srcdir)/message.xsl $(srcdir)/message.xml > result 2>&1 ; \
	diff $(srcdir)/message.result result; \
	grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true;\
	rm -f result)
	@($(CHECKER) $(top_builddir)/xsltproc/xsltproc $(srcdir)/fragment.xsl $(srcdir)/fragment.xml > result 2>&1 ; \
	diff $(srcdir)/fragment.result result; \
	grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true;\
	rm -f result)

