## Process this file with automake to produce Makefile.in

$(top_builddir)/xsltproc/xsltproc:
	@(cd ../../xsltproc ; $(MAKE) xsltproc)

EXTRA_DIST = \
    extra.xml extra.xsl extra.out \
    extra2.xml extra2.xsl extra2.out extra2.err\
    tst.xml tst.xsl tst.out \
    tst2.xml tst2.xsl tst2.out \
    tst3.xml tst3.xsl tst3.out \
    tst4.xml tst4.xsl tst4.out \
    tst5.xml tst5.xsl tst5.out \
    tst6.xml tst6.xsl tst6.out \
    tst7.xml tst7.xsl tst7.out \
    tst8.xml tst8.xsl tst8.out \
    tst9.xml tst9.xsl tst9.out

CLEANFILES = .memdump

valgrind:
	@echo '## Running the regression tests under Valgrind'
	$(MAKE) CHECKER='libtool --mode=execute valgrind -q --leak-check=full' tests

test tests: $(top_builddir)/xsltproc/xsltproc
	@echo '## Running namespaces tests'
	@(echo > .memdump)
	-@(for i in $(srcdir)/*.xml ; do \
	  if [ -d $$i ] ; then continue ; fi ; \
	  doc=`basename $$i .xml` ; \
	  j=$(srcdir)/$$doc.xsl ; \
	  if [ ! -f $$j ] ; then continue ; fi ; \
	  if [ -d $$j ] ; then continue ; fi ; \
	  name=`basename $$j .xsl`; \
	  out=$(srcdir)/"$$name".out; \
	  err=$(srcdir)/"$$name".err; \
	  log=`$(CHECKER) $(top_builddir)/xsltproc/xsltproc $$j $$i \
	  	> result.$$name 2>err.$$name; \
	  if [ ! -f $$out ] ; then \
	  	cp result.$$name $$out ; \
		if [ -s err.$$name ] ; then \
			cp err.$$name $$err ; \
		fi ; \
	  else \
	  	diff $$out result.$$name; \
		if [ -s $$err ] ; then \
	  		diff $$err err.$$name; \
		else \
			diff /dev/null err.$$name; \
		fi ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`;\
	  if [ -n "$$log" ] ; then \
	  	echo $$name result ; \
		echo "$$log" ; \
	  fi ; \
	  rm -f result.$$name err.$$name; \
	  done)

