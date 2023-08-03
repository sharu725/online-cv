devhelpdir = $(datadir)/gtk-doc/html/libexslt

dist_devhelp_DATA =			\
	libexslt.devhelp2		\
	$(HTML_FILES)			\
	$(EXTRA_FORMAT)

HTML_FILES =				\
	general.html			\
	index.html			\
	$(HTML_MODULES)

HTML_MODULES=				\
	libexslt-exsltexports.html	\
	libexslt-exslt.html

EXTRA_FORMAT=				\
	home.png			\
	left.png			\
	right.png			\
	up.png				\
	style.css

EXTRA_DIST = devhelp2.xsl html.xsl

if REBUILD_DOCS

rebuild: libexslt.devhelp2
.PHONY: rebuild

$(HTML_FILES): libexslt.devhelp2

libexslt.devhelp2: devhelp2.xsl html.xsl $(top_srcdir)/doc/EXSLT/libexslt-api.xml
	-@(if [ -x $(XSLTPROC) ] ; then \
	  echo Rebuilding devhelp2 files ; \
	  $(XSLTPROC) --nonet -o $(srcdir)/libexslt.devhelp2 $(srcdir)/devhelp2.xsl $(top_srcdir)/doc/EXSLT/libexslt-api.xml ; fi );

endif
