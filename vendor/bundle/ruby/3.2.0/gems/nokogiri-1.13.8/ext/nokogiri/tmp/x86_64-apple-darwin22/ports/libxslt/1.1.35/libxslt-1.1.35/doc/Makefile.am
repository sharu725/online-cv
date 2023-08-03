## Process this file with automake to produce Makefile.in

SUBDIRS = devhelp EXSLT/devhelp

# The top-level SGML file.
DOC_MAIN_XML_FILE=libxslt.xml

# The directory containing the source code (if it contains documentation).
DOC_SOURCE_DIR=..

# A file in win32 depends upon two of the doc files
WIN32_DIR=$(top_srcdir)/win32

PAGES=   API.html bugs.html contribs.html FAQ.html docs.html \
         downloads.html help.html index.html intro.html news.html \
	 xsltproc2.html

EPAGES=	 EXSLT/bugs.html EXSLT/docs.html EXSLT/downloads.html \
	 EXSLT/help.html EXSLT/index.html EXSLT/intro.html

APIPAGES=APIconstructors.html APIfiles.html APIfunctions.html \
	 APIsymbols.html APIchunk0.html search.templ

EAPIPAGES=EXSLT/APIconstructors.html EXSLT/APIfiles.html \
	 EXSLT/APIfunctions.html EXSLT/APIsymbols.html EXSLT/APIchunk0.html

EXTRA_DIST =				\
	$(PAGES)			\
	$(EPAGES)			\
	$(EAPIPAGES)			\
	APIchunk0.html			\
	APIchunk1.html			\
	APIchunk2.html			\
	APIchunk3.html			\
	APIchunk4.html			\
	APIchunk5.html			\
	APIchunk6.html			\
	APIchunk7.html			\
	APIchunk8.html			\
	APIchunk9.html			\
	APIchunk10.html			\
	APIchunk11.html			\
	APIchunk12.html			\
	APIconstructors.html		\
	APIfiles.html			\
	APIfunctions.html		\
	APIsymbols.html			\
	EXSLT/exslt.html		\
	EXSLT/html/book1.html		\
	EXSLT/html/home.png		\
	EXSLT/html/index.html		\
	EXSLT/html/left.png		\
	EXSLT/html/libexslt-exslt.html	\
	EXSLT/html/libexslt-exsltexports.html \
	EXSLT/html/libexslt-lib.html	\
	EXSLT/html/right.png		\
	EXSLT/html/up.png		\
	EXSLT/libexslt-api.xml		\
	EXSLT/libexslt-refs.xml		\
	Libxslt-Logo-180x168.gif	\
	Libxslt-Logo-90x34.gif		\
	api.xsl				\
	apibuild.py			\
	checkapisym.xsl			\
	contexts.gif			\
	docbook.html			\
	duck.png			\
	epatents.png			\
	extensions.html			\
	gnome2.png			\
	html/book1.html			\
	html/home.png			\
	html/index.html			\
	html/left.png			\
	html/libxslt-attributes.html	\
	html/libxslt-documents.html	\
	html/libxslt-extensions.html	\
	html/libxslt-extra.html		\
	html/libxslt-functions.html	\
	html/libxslt-imports.html	\
	html/libxslt-keys.html		\
	html/libxslt-lib.html		\
	html/libxslt-namespaces.html	\
	html/libxslt-numbersInternals.html \
	html/libxslt-pattern.html	\
	html/libxslt-preproc.html	\
	html/libxslt-security.html	\
	html/libxslt-templates.html	\
	html/libxslt-transform.html	\
	html/libxslt-variables.html	\
	html/libxslt-xslt.html		\
	html/libxslt-xsltInternals.html	\
	html/libxslt-xsltexports.html	\
	html/libxslt-xsltlocale.html	\
	html/libxslt-xsltutils.html	\
	html/right.png			\
	html/up.png			\
	images/callouts/1.png		\
	images/callouts/10.png		\
	images/callouts/2.png		\
	images/callouts/3.png		\
	images/callouts/4.png		\
	images/callouts/5.png		\
	images/callouts/6.png		\
	images/callouts/7.png		\
	images/callouts/8.png		\
	images/callouts/9.png		\
	internals.html			\
	libxslt-api.xml			\
	libxslt-refs.xml		\
	libxslt.xsa			\
	newapi.xsl			\
	news.xsl			\
	node.gif			\
	object.gif			\
	processing.gif			\
	python.html			\
	redhat.gif			\
	search.xml			\
	site.xsl			\
	smallfootonly.gif		\
	stylesheet.gif			\
	symbols.xml			\
	syms.xsl			\
	templates.gif			\
	tutorial/libxslt_tutorial.c	\
	tutorial/libxslttutorial.html	\
	tutorial/libxslttutorial.xml	\
	tutorial2/libxslt_pipes.c	\
	tutorial2/libxslt_pipes.html	\
	tutorial2/libxslt_pipes.xml	\
	w3c.png				\
	xsa.xsl				\
	xslt.html			\
	xsltproc.1			\
	xsltproc.html			\
	xsltproc.xml

man_MANS = xsltproc.1

if REBUILD_DOCS

all-local:	web ../NEWS libxslt.xsa $(man_MANS) xsltproc.html

api:	libxslt-api.xml libxslt-refs.xml $(APIPAGES) search.php \
        html/index.html $(WIN32_DIR)/libxslt.def.src

eapi:	EXSLT/libexslt-api.xml EXSLT/libexslt-refs.xml $(EAPIPAGES) \
	EXSLT/html/index.html $(WIN32_DIR)/libexslt.def.src

web: $(PAGES) $(EPAGES)

$(PAGES): $(srcdir)/xslt.html $(srcdir)/site.xsl
	-@(if [ -x $(XSLTPROC) ] ; then \
	  echo "Rebuilding the HTML Web pages from xslt.html" ; \
	  $(XSLTPROC) --nonet --html $(srcdir)/site.xsl \
	    $(srcdir)/xslt.html > index.html ; fi )
	-@(if [ -x $(XMLLINT) ] ; then \
	  echo "Validating the HTML Web pages" ; \
	  $(XMLLINT) --nonet --valid --noout $(PAGES) ; fi );

$(EPAGES): $(srcdir)/EXSLT/exslt.html $(srcdir)/site.xsl
	 -@(if [ ! -d EXSLT/html ] ; then \
	   mkdir -p EXSLT/html ; fi )
	 -@(if [ -x $(XSLTPROC) ] ; then \
	   echo "Rebuilding the HTML Web pages from exslt.html" ; \
	   $(XSLTPROC) --nonet --html \
		--stringparam dirname EXSLT/ \
		--stringparam libname libexslt \
		--stringparam logo_base ../ \
		$(srcdir)/site.xsl \
		$(srcdir)/EXSLT/exslt.html > EXSLT/index.html ; fi )
	 -@(if [ -x $(XMLLINT) ] ; then \
	   echo "Validating the HTML Web pages" ; \
	   $(XMLLINT) --nonet --valid --noout $(EPAGES) ; fi );

../NEWS: $(srcdir)/news.xsl $(srcdir)/news.html
	-@(if [ -x $(XSLTPROC) ] ; then \
	  $(XSLTPROC) --nonet $(srcdir)/news.xsl \
	    $(srcdir)/news.html > ../NEWS ; fi );

libxslt.xsa: $(srcdir)/xsa.xsl $(srcdir)/news.html
	-@(if [ -x $(XSLTPROC) ] ; then \
	  $(XSLTPROC) --nonet $(srcdir)/xsa.xsl \
	    news.html > libxslt.xsa ; fi );

$(APIPAGES): libxslt-refs.xml site.xsl api.xsl $(srcdir)/site.xsl \
	     $(srcdir)/api.xsl
	-@(if [ -x $(XSLTPROC) ] ; then \
	  echo "Rebuilding the HTML API pages from libxslt-refs.xml" ; \
	  $(XSLTPROC) --nonet --html \
			     $(srcdir)/api.xsl \
			     $(srcdir)/xslt.html ; fi );
	-@(if [ -x $(XMLLINT) ] ; then \
	  echo "Validating the HTML API pages" ; \
	  $(XMLLINT) --nonet --valid --noout API*.html; fi );

$(EAPIPAGES): EXSLT/libexslt-refs.xml site.xsl api.xsl
	-@(if [ -x $(XSLTPROC) ] ; then \
	  echo "Rebuilding the HTML API pages from libexslt-refs.xml" ; \
	  $(XSLTPROC) --nonet --html --output EXSLT/ \
			     --stringparam libname libexslt \
			     --stringparam dirname EXSLT/ \
			     --stringparam logo_base ../ \
			     $(srcdir)/api.xsl \
			     $(srcdir)/EXSLT/exslt.html ; fi );

html/index.html: libxslt-api.xml $(srcdir)/newapi.xsl
	-@(if [ -x $(XSLTPROC) ] ; then \
	  echo "Rebuilding the HTML pages from the XSLT API" ; \
	  $(XSLTPROC) --nonet \
			     $(srcdir)/newapi.xsl $(srcdir)/libxslt-api.xml ; fi );
	-@(if [ -x $(XMLLINT) ] ; then \
	  echo "Validating the resulting XHTML pages" ; \
	  $(XMLLINT) --nonet --valid --noout html/*.html ; fi );

wiki: libxslt-api.xml $(srcdir)/wiki.xsl
	-@(if [ -x $(XSLTPROC) ] ; then \
		echo "Rebuilding the wiki HTML pages from the XSLT API" ; \
		$(XSLTPROC) --nonet $(srcdir)/wiki.xsl $(srcdir)/libxslt-api.xml; fi )

EXSLT/html/index.html: EXSLT/libexslt-api.xml \
	$(srcdir)/newapi.xsl
	-@(if [ -x $(XSLTPROC) ] ; then \
	  echo "Rebuilding the HTML pages from the EXSLT API" ; \
	  $(XSLTPROC) --nonet --output EXSLT/ \
			     --stringparam libname libexslt \
			     --stringparam dirname EXSLT/ \
			     --stringparam logo_base ../../ \
			     $(srcdir)/newapi.xsl \
			     $(srcdir)/EXSLT/libexslt-api.xml ; fi );
	-@(if [ -x $(XMLLINT) ] ; then \
	  echo "Validating the resulting XHTML pages" ; \
	  $(XMLLINT) --nonet --valid --noout EXSLT/html/*.html ; fi );


libxslt-api.xml libxslt-refs.xml EXSLT/libexslt-api.xml \
  EXSLT/libexslt-refs.xml ../libxslt/libxslt.syms : $(srcdir)/apibuild.py $(top_srcdir)/libxslt/*.h \
		$(top_srcdir)/libxslt/*.c $(top_srcdir)/libexslt/*.h \
		$(top_srcdir)/libexslt/*.c
	-(cd $(srcdir) && ./apibuild.py)
	($(XSLTPROC) $(srcdir)/checkapisym.xsl $(srcdir)/libxslt-api.xml)
	($(XSLTPROC) -o ../libxslt/libxslt.syms $(srcdir)/syms.xsl $(srcdir)/symbols.xml)

xsltproc.html: xsltproc.xml
	-@($(XSLTPROC) --nonet -o $@ http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl xsltproc.xml)

xsltproc.1: $(srcdir)/xsltproc.xml
	-@(if [ -x $(XSLTPROC) ] ; then \
	   echo "Rebuilding the man pages from the xml" ; \
	   $(XSLTPROC) --nonet $(srcdir)/xsltproc.xml ; fi)

# Note that in the following, xmllint output is piped to xsltproc
search.php: $(srcdir)/api.xsl $(srcdir)/site.xsl $(srcdir)/search.templ \
            $(srcdir)/search.xml $(srcdir)/search.php.inc
	-@(if test -x $(XMLLINT) -a -x $(XSLTPROC); then \
	   echo "Rebuilding search.php" ; \
	   $(XMLLINT) --xinclude --nonet \
	                      $(srcdir)/search.xml | \
	   $(XSLTPROC) --nonet - search.templ \
			      > search.php ; else \
	   echo "Unable to find xmllint or xsltproc in $(bindir)" ; fi)

$(WIN32_DIR)/libxslt.def.src: libxslt-api.xml
	-@(if [ -x $(XSLTPROC) ] ; then \
	  $(XSLTPROC) -o $(WIN32_DIR)/libxslt.def.src \
	  --nonet $(WIN32_DIR)/defgen.xsl $(srcdir)/libxslt-api.xml ; fi )

$(WIN32_DIR)/libexslt.def.src: EXSLT/libexslt-api.xml
	-@(if [ -x $(XSLTPROC) ] ; then \
	  $(XSLTPROC) -o $(WIN32_DIR)/libexslt.def.src \
	  --nonet $(WIN32_DIR)/defgen.xsl $(srcdir)/EXSLT/libexslt-api.xml ; fi )

clean-local:
	rm -f *~ *.1 *.bak *.hierarchy *.signals *-unused.txt

distclean-local:
	if test ! -r Makefile.am ; then \
		rm -f *.html *.templ *.xsa ; \
		rm -rf EXSLT html ; \
	fi

rebuild: api eapi all

wildcards =			\
	*.1			\
	*.gif			\
	*.html			\
	*.png			\
	*.xsl			\
	EXSLT/*.html		\
	EXSLT/html/*.html	\
	EXSLT/html/*.png	\
	html/*.html		\
	html/*.png		\
	images/callouts/*.png	\
	tutorial*/libxslt*

# This target verifies that EXTRA_DIST contains all the files matched by
# the above list of wildcards. Note that this will only work properly when
# srcdir = builddir.
#
check-extra-dist:
	@for a in $(wildcards) ; do \
		if test ! -f "$$a" ; then \
			echo "not found: $$a" ; \
			continue ; \
		fi ; \
		present= ; \
		for b in $(EXTRA_DIST) ; do \
			test "$$a" = "$$b" && present=1 && break ; \
		done ; \
		test -n "$$present" || echo "not in EXTRA_DIST: $$a" ; \
	done

endif

install-data-local:
	$(MKDIR_P) $(DESTDIR)$(HTML_DIR)
	-$(INSTALL) -m 0644 $(srcdir)/*.html $(DESTDIR)$(HTML_DIR)
	-$(INSTALL) -m 0644 $(srcdir)/*.gif $(DESTDIR)$(HTML_DIR)
	$(MKDIR_P) $(DESTDIR)$(HTML_DIR)/html
	-$(INSTALL) -m 0644 $(srcdir)/html/*.html $(DESTDIR)$(HTML_DIR)/html
	-$(INSTALL) -m 0644 $(srcdir)/html/*.png $(DESTDIR)$(HTML_DIR)/html
	$(MKDIR_P) $(DESTDIR)$(HTML_DIR)/EXSLT
	-$(INSTALL) -m 0644 $(srcdir)/EXSLT/*.html $(DESTDIR)$(HTML_DIR)/EXSLT
	$(MKDIR_P) $(DESTDIR)$(HTML_DIR)/tutorial
	-$(INSTALL) -m 0644 $(srcdir)/tutorial/* $(DESTDIR)$(HTML_DIR)/tutorial
	$(MKDIR_P) $(DESTDIR)$(HTML_DIR)/tutorial2
	-$(INSTALL) -m 0644 $(srcdir)/tutorial2/* $(DESTDIR)$(HTML_DIR)/tutorial2

uninstall-local:
	rm -rf $(DESTDIR)$(HTML_DIR)

.PHONY : api eapi web wiki rebuild check-extra-dist
