## Process this file with automake to produce Makefile.in

$(top_builddir)/xsltproc/xsltproc:
	@(cd ../../../xsltproc ; $(MAKE) xsltproc)

EXTRA_DIST = plugin.out	plugin.xml plugin.xsl

AM_CPPFLAGS = -I$(top_srcdir) -I../../libxslt

CLEANFILES = *.res

if WITH_MODULES

noinst_LTLIBRARIES = xmlsoft_org_xslt_testplugin.la

# our rpath is a rather unorthodox location as we 
# don't want to pollute $(DESTDIR) with the test plugin

plugindir = $(abs_builddir)/.libs

xmlsoft_org_xslt_testplugin_la_CFLAGS = -DMODULE_COMPILE $(LIBXML_CFLAGS) $(LIBXSLT_CFLAGS)
xmlsoft_org_xslt_testplugin_la_SOURCES = testplugin.c
xmlsoft_org_xslt_testplugin_la_LIBADD = $(top_builddir)/libxslt/libxslt.la $(EXTRA_LIBS)
xmlsoft_org_xslt_testplugin_la_LDFLAGS = -module -avoid-version -rpath $(plugindir)

test-logall:
	@echo '## Running plugin tests'

test tests: $(top_builddir)/xsltproc/xsltproc test-logall $(noinst_LTLIBRARIES)
	@LD_LIBRARY_PATH=$(plugindir):$(top_builddir)/libxslt/.libs:$(LD_LIBRARY_PATH) \
	 LIBXSLT_PLUGINS_PATH=$(plugindir) \
	 $(top_builddir)/xsltproc/xsltproc plugin.xsl plugin.xml > plugin.res
	@diff plugin.out plugin.res
	@rm plugin.res

else

test tests:
	@echo Skipping the plugin tests.

endif

