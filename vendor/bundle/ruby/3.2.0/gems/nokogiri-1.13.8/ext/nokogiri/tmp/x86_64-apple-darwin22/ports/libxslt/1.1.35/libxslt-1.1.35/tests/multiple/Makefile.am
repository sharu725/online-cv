## Process this file with automake to produce Makefile.in

$(top_builddir)/xsltproc/xsltproc:
	@(cd ../../xsltproc ; $(MAKE) xsltproc)

EXTRA_DIST = dict.dtd  dict.xml  dict.xsl result.xml \
    out/lettera.orig out/letterb.orig \
    out/letterc.orig out/letterd.orig \
    out/lettere.orig out/letterf.orig \
    out/letterg.orig out/letterh.orig \
    out/letterij.orig out/letterk.orig \
    out/letterl.orig out/letterm.orig \
    out/lettern.orig out/lettero.orig \
    out/letterp.orig out/letterq.orig \
    out/letterr.orig out/letters.orig \
    out/lettert.orig out/letteruv.orig \
    out/letterw.orig out/letterx.orig \
    out/lettery.orig out/letterz.orig \
    out/titlepage.orig


GENERATED = \
	out/lettera.html out/letterb.html out/letterc.html out/letterd.html \
	out/lettere.html out/letterf.html out/letterg.html out/letterh.html \
	out/letterij.html out/letterk.html out/letterl.html out/letterm.html \
	out/lettern.html out/lettero.html out/letterp.html out/letterq.html \
	out/letterr.html out/letters.html out/lettert.html out/letteruv.html \
	out/letterw.html out/letterx.html out/lettery.html out/letterz.html \
	out/titlepage.html

CLEANFILES = .memdump

valgrind:
	@echo '## Running the regression tests under Valgrind'
	$(MAKE) CHECKER='libtool --mode=execute valgrind -q --leak-check=full' tests

test tests: $(top_builddir)/xsltproc/xsltproc
	@echo '## Running multiple tests'
	@(echo > .memdump)
	@($(CHECKER) $(top_builddir)/xsltproc/xsltproc $(srcdir)/dict.xsl $(srcdir)/dict.xml > dict.res ; \
	diff $(srcdir)/result.xml dict.res; \
	for i in out/letter*.html out/titlepage.html ; do \
	  orig=$(srcdir)/out/`basename $$i .html`.orig ; \
	  if [ -f $$orig ] ; then \
	    diff $$orig $$i ; \
	  else \
	    echo "new $$orig" ; cp $$i $$orig ; \
	  fi ; done ; \
	grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true;\
	rm -f dict.res $(GENERATED))


