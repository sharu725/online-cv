## Process this file with automake to produce Makefile.in

tests:
	@$(MAKE) single
	@$(MAKE) xtchunk

valgrind:
	@echo '## Running the regression tests under Valgrind'
	$(MAKE) CHECKER='libtool --mode=execute valgrind -q --leak-check=full' tests

$(top_builddir)/xsltproc/xsltproc:
	@(cd ../../xsltproc ; $(MAKE) xsltproc)

EXTRA_DIST = README VERSION

CLEANFILES = .memdump

full: tests htmltests xhtmltests fotests

#
# a single tests to check that stuff ain't broken
#
single:
	@echo '## Running single docbook tests'
	@$(MKDIR_P) result/html
	@$(MKDIR_P) result/fo
	@$(MKDIR_P) result/xhtml
	@(echo > .memdump)
	@(for i in $(srcdir)/test/gdp-handbook.xml ; do \
	  out=result/html/`basename $$i .xml`.tst; \
	  html=result/html/`basename $$i .xml`.html; \
	  log=`$(CHECKER) $(top_builddir)/xsltproc/xsltproc --nonet \
		$(srcdir)/html/docbook.xsl $$i > $$out ; \
	    if [ -f $(srcdir)/$$html ] ; then \
		grep -v id < $(srcdir)/$$html > $$html.noid ; \
		grep -v id < $$out > $$out.noid ; \
		diff $$html.noid $$out.noid ; \
		rm -f $$html.noid $$out.noid ; \
	    else \
		mv $$out $(srcdir)/$$html ; \
	    fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true` ; \
	  if [ -n "$$log" ] ; then \
		echo result ; \
		echo "$$log" ; \
	  fi ; \
	  rm -f $$out ; \
	  out=result/fo/`basename $$i .xml`.tst; \
	  fo=result/fo/`basename $$i .xml`.fo; \
	  msg=result/fo/`basename $$i .xml`.msg; \
	  log=`$(CHECKER) $(top_builddir)/xsltproc/xsltproc --nonet \
		$(srcdir)/fo/docbook.xsl $$i > $$out 2> $$msg ; \
	  if [ -f $(srcdir)/$$fo ] ; then \
	      grep -v id < $(srcdir)/$$fo > $$fo.noid ; \
	      grep -v id < $$out > $$out.noid ; \
	      diff $$fo.noid $$out.noid ; \
	      rm -f $$fo.noid $$out.noid ; \
	  else \
		mv $$out $(srcdir)/$$fo ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true` ; \
	  if [ -n "$$log" ] ; then \
		echo result ; \
		echo "$$log" ; \
	  fi ; \
	  rm -f $$out $$msg ; \
	  out=result/xhtml/`basename $$i .xml`.tst; \
	  xhtml=result/xhtml/`basename $$i .xml`.xhtml; \
	  log=`$(CHECKER) $(top_builddir)/xsltproc/xsltproc --nonet \
		$(srcdir)/xhtml/docbook.xsl $$i > $$out ; \
	  if [ -f $(srcdir)/$$xhtml ] ; then \
	      grep -v id < $(srcdir)/$$xhtml > $$xhtml.noid ; \
	      grep -v id < $$out > $$out.noid ; \
	      diff $$xhtml.noid $$out.noid ; \
	      rm -f $$xhtml.noid $$out.noid ; \
	  else \
		mv $$out $(srcdir)/$$xhtml ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true` ; \
	  if [ -n "$$log" ] ; then \
		echo result ; \
		echo "$$log" ; \
	  fi ; \
	  rm -f $$out ; \
	  done )

xtchunk:
	@echo '## Running xtchunk docbook tests'
	@$(MKDIR_P) result/html
	@$(MKDIR_P) result/xtchunk
	@(echo > .memdump)
	@(for i in $(srcdir)/test/gdp-handbook.xml ; do \
	  base=`basename $$i .xml` ; \
	  html=result/html/$$base.html; \
	  log=`$(CHECKER) $(top_builddir)/xsltproc/xsltproc \
		-o result/xtchunk/html/gdp-handbook \
		$(srcdir)/html/xtchunk.xsl $$i 2> $$base.err ; \
	    if [ -f $(srcdir)/result/html/$$base.err ] ; then \
		diff $(srcdir)/result/html/$$base.err $$base.err ; \
		rm $$base.err ; \
	    else \
		mv $$base.err $(srcdir)/result/html/$$base.err ; \
	    fi ; \
	    for html in result/xtchunk/html/*.html ; do \
	      orig=result/xtchunk/html/\`basename $$html .html\`.orig ;\
	      if [ -f $(srcdir)/$$orig ] ; then \
		  grep -v id < $$html > $$html.noid ; \
		  grep -v id < $(srcdir)/$$orig > $$orig.noid ; \
		  diff $$orig.noid $$html.noid ; \
		  rm -f $$html.noid $$orig.noid $$html; \
	      else \
		  mv $$html $(srcdir)/$$orig ; \
		fi ; \
	    done ; \
	    grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true` ; \
	  if [ -n "$$log" ] ; then \
		echo result ; \
		echo "$$log" ; \
	  fi ; \
	  rm -f result/xtchunk/html/gdp-handbook ; \
	  done )

#
# The full set of tests
#
htmltests: $(top_builddir)/xsltproc/xsltproc
	@$(MKDIR_P) result/html
	@(echo > .memdump)
	@echo "##"
	@echo "## HTML stylesheets regression tests"
	@echo "##"
	@(for i in $(srcdir)/test/*.xml ; do \
	  echo $$i ; \
	  out=result/html/`basename $$i .xml`.tst; \
	  html=result/html/`basename $$i .xml`.html; \
	  $(CHECKER) $(top_builddir)/xsltproc/xsltproc --nonet $(srcdir)/html/docbook.xsl $$i > $$out ; \
	  if [ -f $(srcdir)/$$html ] ; then \
	      grep -v id < $(srcdir)/$$html > $$html.noid ; \
	      grep -v id < $$out > $$out.noid ; \
	      diff $$html.noid $$out.noid ; \
	      rm -f $$html.noid $$out.noid ; \
	  else mv $$out $(srcdir)/$$html ; fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true;\
	  rm -f $$out ; done )

fotests: $(top_builddir)/xsltproc/xsltproc
	@$(MKDIR_P) result/fo
	@(echo > .memdump)
	@echo "##"
	@echo "## XSL FO stylesheets regression tests"
	@echo "##"
	@(for i in $(srcdir)/test/*.xml ; do \
	  echo $$i ; \
	  out=result/fo/`basename $$i .xml`.tst; \
	  fo=result/fo/`basename $$i .xml`.fo; \
	  msg=result/fo/`basename $$i .xml`.msg; \
	  $(CHECKER) $(top_builddir)/xsltproc/xsltproc --nonet $(srcdir)/fo/docbook.xsl $$i > $$out  2> $$msg ; \
	  if [ -f $(srcdir)/$$fo ] ; then \
	      grep -v id < $(srcdir)/$$fo > $$fo.noid ; \
	      grep -v id < $$out > $$out.noid ; \
	      diff $$fo.noid $$out.noid ; \
	      rm -f $$fo.noid $$out.noid ; \
	  else mv $$out $(srcdir)/$$fo ; fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true;\
	  rm -f $$out $$msg ; \
	  done )

xhtmltests: $(top_builddir)/xsltproc/xsltproc
	@$(MKDIR_P) result/xhtml
	@(echo > .memdump)
	@echo "##"
	@echo "## XHTML stylesheets regression tests"
	@echo "##"
	@(for i in $(srcdir)/test/*.xml ; do \
	  echo $$i ; \
	  out=result/xhtml/`basename $$i .xml`.tst; \
	  xhtml=result/xhtml/`basename $$i .xml`.xhtml; \
	  $(CHECKER) $(top_builddir)/xsltproc/xsltproc --nonet $(srcdir)/xhtml/docbook.xsl $$i > $$out ; \
	  if [ -f $(srcdir)/$$xhtml ] ; then \
	      grep -v id < $(srcdir)/$$xhtml > $$xhtml.noid ; \
	      grep -v id < $$out > $$out.noid ; \
	      diff $$xhtml.noid $$out.noid ; \
	      rm -f $$xhtml.noid $$out.noid ; \
	  else mv $$out $(srcdir)/$$xhtml ; fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true;\
	  rm -f $$out ; done )

dist-hook:
	@(cd $(srcdir) ; tar -cf - --exclude CVS --exclude .svn common html dtd lib xhtml fo doc images template htmlhelp result test) | (cd $(distdir); tar xf -)
