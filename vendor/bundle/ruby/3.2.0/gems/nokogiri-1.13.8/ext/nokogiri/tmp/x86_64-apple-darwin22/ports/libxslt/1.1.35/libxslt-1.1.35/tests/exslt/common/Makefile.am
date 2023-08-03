## Process this file with automake to produce Makefile.in

$(top_builddir)/xsltproc/xsltproc:
	@(cd ../../../xsltproc ; $(MAKE) xsltproc)

EXTRA_DIST = 						\
	node-set.1.xml node-set.1.xsl node-set.1.out	\
	node-set.2.xml node-set.2.xsl node-set.2.out	\
	node-set.3.xml node-set.3.xsl node-set.3.out	\
	node-set.4.xml node-set.4.xsl node-set.4.out	\
	node-set.5.xml node-set.5.xsl node-set.5.out	\
	node-set.6.xml node-set.6.xsl node-set.6.out	\
	node-set.7.xml node-set.7.xsl node-set.7.out	\
	node-set.8.xml node-set.8.xsl node-set.8.out	\
	object-type.1.xml object-type.1.xsl object-type.1.out \
	import-test1a.imp import-test1b.imp import-test1.out \
	import-test1.xml import-test1.xsl

CLEANFILES = .memdump

valgrind:
	@echo '## Running the regression tests under Valgrind'
	$(MAKE) CHECKER='libtool --mode=execute valgrind -q --leak-check=full' tests

test tests: $(top_builddir)/xsltproc/xsltproc
	@echo '## Running exslt common tests'
	@(echo > .memdump)
	@(for i in $(srcdir)/*.xsl ; do \
	  name=`basename $$i .xsl` ; \
	  if [ ! -f $(srcdir)/$$name.xml ] ; then continue ; fi ; \
	  log=`$(CHECKER) $(top_builddir)/xsltproc/xsltproc \
		$(srcdir)/$$name.xsl $(srcdir)/$$name.xml > $$name.res 2>$$name.bad;\
	  if [ ! -f $(srcdir)/$$name.out ] ; then \
		cp $$name.res $(srcdir)/$$name.out ; \
		if [ -s $$name.bad ] ; then \
			mv $$name.bad $(srcdir)/$$name.err ; \
		fi ; \
	  else \
		if  [ ! -s $$name.res ] ; then \
			echo "Fatal error, no $$name.res\n" ; \
	  	else \
			diff $(srcdir)/$$name.out $$name.res ; \
			if [ -s $(srcdir)/$$name.err ] ; then \
	  			diff $(srcdir)/$$name.err $$name.bad; \
			else \
				diff /dev/null $$name.bad; \
			fi ; \
		fi ; \
	  fi; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`;\
	  if [ -n "$$log" ] ; then \
	  	echo $$name result ; \
		echo "$$log" ; \
	  fi ; \
	  rm -f $$name.res $$name.bad; \
	  done)
