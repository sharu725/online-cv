## Process this file with automake to produce Makefile.in

$(top_builddir)/xsltproc/xsltproc:
	@(cd ../../../xsltproc ; $(MAKE) xsltproc)

EXTRA_DIST = 						\
	function.1.out  function.1.xml  function.1.xsl	\
	function.2.out  function.2.xml  function.2.xsl	\
	function.3.out  function.3.xml  function.3.xsl	\
	function.4.out  function.4.xml  function.4.xsl	\
	function.5.out  function.5.xml  function.5.xsl  \
	function.6.out  function.6.xml  function.6.xsl  \
	function.7.out  function.7.xml  function.7.xsl  \
	function.8.out  function.8.xml  function.8.xsl  \
	function.9.out  function.9.xml  function.9.xsl  \
	function.10.out function.10.xml function.10.xsl \
	function.11.out function.11.xml function.11.xsl

CLEANFILES = .memdump

valgrind:
	@echo '## Running the regression tests under Valgrind'
	$(MAKE) CHECKER='libtool --mode=execute valgrind -q --leak-check=full' tests

test tests: $(top_builddir)/xsltproc/xsltproc
	@echo '## Running exslt function tests'
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
	  rm -f $$name.res $$name.bad ; \
	  done)
