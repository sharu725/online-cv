## Process this file with automake to produce Makefile.in

$(top_builddir)/xsltproc/xsltproc:
	@(cd ../../xsltproc ; $(MAKE) xsltproc)

EXTRA_DIST = \
    evaluate.xml evaluate.xsl evaluate.out \
    module.xml module.xsl module.out \
    list.xml list.xsl list.out

CLEANFILES = .memdump

valgrind:
	@echo '## Running the regression tests under Valgrind'
	$(MAKE) CHECKER='libtool --mode=execute valgrind -q --leak-check=full' tests

test tests: $(top_builddir)/xsltproc/xsltproc
	@echo '## Running extensions tests'
	@(echo > .memdump)
	-@(for i in $(srcdir)/*.xml ; do \
	  if [ -d $$i ] ; then continue ; fi ; \
	  doc=`basename $$i .xml` ; \
	  j=$(srcdir)/$$doc*.xsl ; \
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

