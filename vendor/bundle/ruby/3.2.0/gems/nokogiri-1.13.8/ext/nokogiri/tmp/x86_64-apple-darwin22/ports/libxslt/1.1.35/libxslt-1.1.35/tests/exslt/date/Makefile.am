## Process this file with automake to produce Makefile.in

$(top_builddir)/xsltproc/xsltproc:
	@(cd ../../../xsltproc ; $(MAKE) xsltproc)

EXTRA_DIST = 						\
	                              current.xsl	\
	date.1.out	date.1.xml	date.1.xsl	\
	date.2.out	date.2.xml	date.2.xsl	\
	datetime.1.out	datetime.1.xml	datetime.1.xsl	\
	datetime.2.out	datetime.2.xml	datetime.2.xsl	\
	gday.1.out	gday.1.xml	gday.1.xsl	\
	gday.2.out	gday.2.xml	gday.2.xsl	\
	gmonth.1.out	gmonth.1.xml	gmonth.1.xsl	\
	gmonth.2.out	gmonth.2.xml	gmonth.2.xsl	\
	gmonthday.1.out	gmonthday.1.xml	gmonthday.1.xsl	\
	gmonthday.2.out	gmonthday.2.xml	gmonthday.2.xsl	\
	gyear.1.out	gyear.1.xml	gyear.1.xsl	\
	gyear.2.out	gyear.2.xml	gyear.2.xsl	\
	gyearmonth.1.out gyearmonth.1.xml gyearmonth.1.xsl	\
	gyearmonth.2.out gyearmonth.2.xml gyearmonth.2.xsl	\
	time.1.out	time.1.xml	time.1.xsl	\
	time.2.out	time.2.xml	time.2.xsl	\
	add.1.out	add.1.xml	add.1.xsl	\
	add.2.out	add.2.xml	add.2.xsl	\
	add-duration.1.out add-duration.1.xml add-duration.1.xsl \
	add-duration.2.out add-duration.2.xml add-duration.2.xsl \
	sum.1.out	sum.1.xml	sum.1.xsl	\
	sum.2.out	sum.2.xml	sum.2.xsl	sum.2.err	\
	difference.1.out difference.1.xml difference.1.xsl	\
	difference.2.out difference.2.xml difference.2.xsl	\
	duration.1.out	duration.1.xml	duration.1.xsl	\
	duration.2.out	duration.2.xml	duration.2.xsl	\
	seconds.1.out	seconds.1.xml	seconds.1.xsl	\
	seconds.2.out	seconds.2.xml	seconds.2.xsl

CLEANFILES = .memdump

test-current:
	@(echo > .memdump)
	@(if [ -z "$$CI" ]; then \
	    echo \<doc/\> >current.xml ; \
	    echo "#" ; \
	    echo "# Inspect the following for correctness" ; \
	    echo "#" ; \
	    for i in $(srcdir)/current.xsl ; do \
	      name=`basename $$i .xsl` ; \
	      if [ ! -f $(srcdir)/$$name.xml ] ; then continue ; fi ; \
	      $(top_builddir)/xsltproc/xsltproc $(srcdir)/$$name.xsl $(srcdir)/$$name.xml;\
	      grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true;\
	    done ; \
	    rm -f current.xml ; \
	  fi)

test tests: $(top_builddir)/xsltproc/xsltproc test-current
	@echo '## Running exslt date tests'
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
