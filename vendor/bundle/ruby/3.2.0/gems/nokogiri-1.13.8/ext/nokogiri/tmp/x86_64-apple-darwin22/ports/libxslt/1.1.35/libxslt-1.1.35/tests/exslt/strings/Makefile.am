## Process this file with automake to produce Makefile.in

$(top_builddir)/xsltproc/xsltproc:
	@(cd ../../../xsltproc ; $(MAKE) xsltproc)

EXTRA_DIST = 						\
	align.1.xml align.1.xsl align.1.out		\
	padding.1.xml padding.1.xsl padding.1.out	\
	replace.1.xml replace.1.xsl replace.1.out	\
	split.1.xml split.1.xsl split.1.out		\
	tokenize.1.xml tokenize.1.xsl tokenize.1.out	\
	tokenize.2.xml tokenize.2.xsl tokenize.2.out	\
	tokenize.3.xml tokenize.3.xsl tokenize.3.out	\
	uri.xml uri.xsl uri.out

CLEANFILES = .memdump

valgrind:
	@echo '## Running the regression tests under Valgrind'
	$(MAKE) CHECKER='libtool --mode=execute valgrind -q --leak-check=full' tests

test tests: $(top_builddir)/xsltproc/xsltproc
	@echo '## Running exslt string tests'
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
