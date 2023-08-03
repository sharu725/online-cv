
SHELL = /bin/sh

# V=0 quiet, V=1 verbose.  other values don't work.
V = 0
V0 = $(V:0=)
Q1 = $(V:1=)
Q = $(Q1:0=@)
ECHO1 = $(V:1=@ :)
ECHO = $(ECHO1:0=@ echo)
NULLCMD = :

#### Start of system configuration section. ####

srcdir = .
topdir = /usr/local/Cellar/ruby/3.2.2_1/include/ruby-3.2.0
hdrdir = $(topdir)
arch_hdrdir = /usr/local/Cellar/ruby/3.2.2_1/include/ruby-3.2.0/x86_64-darwin22
PATH_SEPARATOR = :
VPATH = $(srcdir):$(arch_hdrdir)/ruby:$(hdrdir)/ruby
prefix = $(DESTDIR)/usr/local/Cellar/ruby/3.2.2_1
rubysitearchprefix = $(rubylibprefix)/$(sitearch)
rubyarchprefix = $(rubylibprefix)/$(arch)
rubylibprefix = $(libdir)/$(RUBY_BASE_NAME)
exec_prefix = $(prefix)
vendorarchhdrdir = $(vendorhdrdir)/$(sitearch)
sitearchhdrdir = $(sitehdrdir)/$(sitearch)
rubyarchhdrdir = $(rubyhdrdir)/$(arch)
vendorhdrdir = $(rubyhdrdir)/vendor_ruby
sitehdrdir = $(rubyhdrdir)/site_ruby
rubyhdrdir = $(includedir)/$(RUBY_VERSION_NAME)
vendorarchdir = $(vendorlibdir)/$(sitearch)
vendorlibdir = $(vendordir)/$(ruby_version)
vendordir = $(DESTDIR)/usr/local/lib/ruby/vendor_ruby
sitearchdir = $(sitelibdir)/$(sitearch)
sitelibdir = $(sitedir)/$(ruby_version)
sitedir = $(DESTDIR)/usr/local/lib/ruby/site_ruby
rubyarchdir = $(rubylibdir)/$(arch)
rubylibdir = $(rubylibprefix)/$(ruby_version)
sitearchincludedir = $(includedir)/$(sitearch)
archincludedir = $(includedir)/$(arch)
sitearchlibdir = $(libdir)/$(sitearch)
archlibdir = $(libdir)/$(arch)
ridir = $(datarootdir)/$(RI_BASE_NAME)
mandir = $(datarootdir)/man
localedir = $(datarootdir)/locale
libdir = $(exec_prefix)/lib
psdir = $(docdir)
pdfdir = $(docdir)
dvidir = $(docdir)
htmldir = $(docdir)
infodir = $(datarootdir)/info
docdir = $(datarootdir)/doc/$(PACKAGE)
oldincludedir = $(DESTDIR)/usr/include
includedir = $(prefix)/include
runstatedir = $(localstatedir)/run
localstatedir = $(prefix)/var
sharedstatedir = $(prefix)/com
sysconfdir = $(prefix)/etc
datadir = $(datarootdir)
datarootdir = $(prefix)/share
libexecdir = $(exec_prefix)/libexec
sbindir = $(exec_prefix)/sbin
bindir = $(exec_prefix)/bin
archdir = $(rubyarchdir)


CC_WRAPPER = 
CC = clang
CXX = clang++
LIBRUBY = $(LIBRUBY_SO)
LIBRUBY_A = lib$(RUBY_SO_NAME)-static.a
LIBRUBYARG_SHARED = -l$(RUBY_SO_NAME)
LIBRUBYARG_STATIC = -l$(RUBY_SO_NAME)-static -framework CoreFoundation $(MAINLIBS)
empty =
OUTFLAG = -o $(empty)
COUTFLAG = -o $(empty)
CSRCFLAG = $(empty)

RUBY_EXTCONF_H = 
cflags   = -fdeclspec $(optflags) $(debugflags) $(warnflags)
cxxflags = 
optflags = -O3 -fno-fast-math
debugflags = -ggdb3
warnflags = -Wall -Wextra -Wextra-tokens -Wdeprecated-declarations -Wdivision-by-zero -Wdiv-by-zero -Wimplicit-function-declaration -Wimplicit-int -Wmisleading-indentation -Wpointer-arith -Wshorten-64-to-32 -Wwrite-strings -Wold-style-definition -Wmissing-noreturn -Wno-cast-function-type -Wno-constant-logical-operand -Wno-long-long -Wno-missing-field-initializers -Wno-overlength-strings -Wno-parentheses-equality -Wno-self-assign -Wno-tautological-compare -Wno-unused-parameter -Wno-unused-value -Wunused-variable -Wundef
cppflags = 
CCDLFLAGS = -fno-common
CFLAGS   = $(CCDLFLAGS) $(cflags)  -fno-common -pipe $(ARCH_FLAG)
INCFLAGS = -I. -I$(arch_hdrdir) -I$(hdrdir)/ruby/backward -I$(hdrdir) -I$(srcdir)
DEFS     = 
CPPFLAGS = -DHAVE_ICONV_H -DHAVE_XMLPARSEDOC -DHAVE_XSLTPARSESTYLESHEETDOC -DHAVE_EXSLTFUNCREGISTER -DHAVE_GUMBO_PARSE_WITH_OPTIONS -DHAVE_XMLHASFEATURE -DHAVE_XMLFIRSTELEMENTCHILD -DHAVE_XMLRELAXNGSETPARSERSTRUCTUREDERRORS -DHAVE_XMLRELAXNGSETVALIDSTRUCTUREDERRORS -DHAVE_XMLSCHEMASETVALIDSTRUCTUREDERRORS -DHAVE_XMLSCHEMASETPARSERSTRUCTUREDERRORS -DHAVE_RB_GC_LOCATION -DHAVE_RB_CATEGORY_WARNING -DHAVE_VASPRINTF -I/Users/adonnell/Desktop/resume/vendor/bundle/ruby/3.2.0/gems/nokogiri-1.13.8/ports/x86_64-darwin22/libxml2/2.9.14/include/libxml2 -I/Users/adonnell/Desktop/resume/vendor/bundle/ruby/3.2.0/gems/nokogiri-1.13.8/ports/x86_64-darwin22/libxslt/1.1.35/include -I/Users/adonnell/Desktop/resume/vendor/bundle/ruby/3.2.0/gems/nokogiri-1.13.8/ports/x86_64-darwin22/libxml2/2.9.14/include/libxml2 -I/usr/local/opt/libyaml/include -I/usr/local/opt/openssl@3/include -I/usr/local/opt/readline/include -D_XOPEN_SOURCE -D_DARWIN_C_SOURCE -D_DARWIN_UNLIMITED_SELECT -D_REENTRANT $(DEFS) $(cppflags)
CXXFLAGS = $(CCDLFLAGS) -fdeclspec $(ARCH_FLAG)
ldflags  = -L. -fstack-protector-strong -L/usr/local/opt/libyaml/lib -L/usr/local/opt/openssl@3/lib -L/usr/local/opt/readline/lib
dldflags = -L/usr/local/opt/libyaml/lib -L/usr/local/opt/openssl@3/lib -L/usr/local/opt/readline/lib -Wl,-multiply_defined,suppress -Wl,-undefined,dynamic_lookup $(LIBRUBYARG_SHARED)
ARCH_FLAG = 
DLDFLAGS = $(ldflags) $(dldflags) $(ARCH_FLAG)
LDSHARED = $(CC) -dynamic -bundle
LDSHAREDXX = $(CXX) -dynamic -bundle
AR = ar
EXEEXT = 

RUBY_INSTALL_NAME = $(RUBY_BASE_NAME)
RUBY_SO_NAME = ruby.3.2
RUBYW_INSTALL_NAME = 
RUBY_VERSION_NAME = $(RUBY_BASE_NAME)-$(ruby_version)
RUBYW_BASE_NAME = rubyw
RUBY_BASE_NAME = ruby

arch = x86_64-darwin22
sitearch = $(arch)
ruby_version = 3.2.0
ruby = $(bindir)/$(RUBY_BASE_NAME)
RUBY = $(ruby)
BUILTRUBY = $(bindir)/$(RUBY_BASE_NAME)
ruby_headers = $(hdrdir)/ruby.h $(hdrdir)/ruby/backward.h $(hdrdir)/ruby/ruby.h $(hdrdir)/ruby/defines.h $(hdrdir)/ruby/missing.h $(hdrdir)/ruby/intern.h $(hdrdir)/ruby/st.h $(hdrdir)/ruby/subst.h $(arch_hdrdir)/ruby/config.h

RM = rm -f
RM_RF = rm -fr
RMDIRS = rmdir -p
MAKEDIRS = mkdir -p
INSTALL = /usr/bin/install -c
INSTALL_PROG = $(INSTALL) -m 0755
INSTALL_DATA = $(INSTALL) -m 644
COPY = cp
TOUCH = exit >

#### End of system configuration section. ####

preload = 
libpath = . $(libdir) /Users/adonnell/Desktop/resume/vendor/bundle/ruby/3.2.0/gems/nokogiri-1.13.8/ports/x86_64-darwin22/libxml2/2.9.14/lib /Users/adonnell/Desktop/resume/vendor/bundle/ruby/3.2.0/gems/nokogiri-1.13.8/ports/x86_64-darwin22/libxslt/1.1.35/lib /usr/local/opt/libyaml/lib /usr/local/opt/openssl@3/lib /usr/local/opt/readline/lib /usr/local/Cellar/xz/5.4.3/lib /Users/adonnell/Desktop/resume/vendor/bundle/ruby/3.2.0/gems/nokogiri-1.13.8/ext/nokogiri/ports/x86_64-darwin22/libgumbo/1.0.0-nokogiri/lib
LIBPATH =  -L. -L$(libdir) -L/Users/adonnell/Desktop/resume/vendor/bundle/ruby/3.2.0/gems/nokogiri-1.13.8/ports/x86_64-darwin22/libxml2/2.9.14/lib -L/Users/adonnell/Desktop/resume/vendor/bundle/ruby/3.2.0/gems/nokogiri-1.13.8/ports/x86_64-darwin22/libxslt/1.1.35/lib -L/usr/local/opt/libyaml/lib -L/usr/local/opt/openssl@3/lib -L/usr/local/opt/readline/lib -L/usr/local/Cellar/xz/5.4.3/lib -L/Users/adonnell/Desktop/resume/vendor/bundle/ruby/3.2.0/gems/nokogiri-1.13.8/ext/nokogiri/ports/x86_64-darwin22/libgumbo/1.0.0-nokogiri/lib
DEFFILE = 

CLEANFILES = mkmf.log
DISTCLEANFILES = 
DISTCLEANDIRS = 

extout = 
extout_prefix = 
target_prefix = /nokogiri
LOCAL_LIBS = 
LIBS = $(LIBRUBYARG_SHARED) /Users/adonnell/Desktop/resume/vendor/bundle/ruby/3.2.0/gems/nokogiri-1.13.8/ports/x86_64-darwin22/libxslt/1.1.35/lib/libexslt.a -lm -liconv -lpthread -llzma -lz /Users/adonnell/Desktop/resume/vendor/bundle/ruby/3.2.0/gems/nokogiri-1.13.8/ports/x86_64-darwin22/libxml2/2.9.14/lib/libxml2.a /Users/adonnell/Desktop/resume/vendor/bundle/ruby/3.2.0/gems/nokogiri-1.13.8/ports/x86_64-darwin22/libxslt/1.1.35/lib/libxslt.a -lm -liconv -lpthread -llzma -lz /Users/adonnell/Desktop/resume/vendor/bundle/ruby/3.2.0/gems/nokogiri-1.13.8/ports/x86_64-darwin22/libxml2/2.9.14/lib/libxml2.a -llzma /Users/adonnell/Desktop/resume/vendor/bundle/ruby/3.2.0/gems/nokogiri-1.13.8/ext/nokogiri/ports/x86_64-darwin22/libgumbo/1.0.0-nokogiri/lib/libgumbo.a -lpthread  
ORIG_SRCS = gumbo.c html4_document.c html4_element_description.c html4_entity_lookup.c html4_sax_parser_context.c html4_sax_push_parser.c libxml2_backwards_compat.c nokogiri.c test_global_handlers.c xml_attr.c xml_attribute_decl.c xml_cdata.c xml_comment.c xml_document.c xml_document_fragment.c xml_dtd.c xml_element_content.c xml_element_decl.c xml_encoding_handler.c xml_entity_decl.c xml_entity_reference.c xml_namespace.c xml_node.c xml_node_set.c xml_processing_instruction.c xml_reader.c xml_relax_ng.c xml_sax_parser.c xml_sax_parser_context.c xml_sax_push_parser.c xml_schema.c xml_syntax_error.c xml_text.c xml_xpath_context.c xslt_stylesheet.c
SRCS = $(ORIG_SRCS) 
OBJS = gumbo.o html4_document.o html4_element_description.o html4_entity_lookup.o html4_sax_parser_context.o html4_sax_push_parser.o libxml2_backwards_compat.o nokogiri.o test_global_handlers.o xml_attr.o xml_attribute_decl.o xml_cdata.o xml_comment.o xml_document.o xml_document_fragment.o xml_dtd.o xml_element_content.o xml_element_decl.o xml_encoding_handler.o xml_entity_decl.o xml_entity_reference.o xml_namespace.o xml_node.o xml_node_set.o xml_processing_instruction.o xml_reader.o xml_relax_ng.o xml_sax_parser.o xml_sax_parser_context.o xml_sax_push_parser.o xml_schema.o xml_syntax_error.o xml_text.o xml_xpath_context.o xslt_stylesheet.o
HDRS = $(srcdir)/nokogiri.h
LOCAL_HDRS = 
TARGET = nokogiri
TARGET_NAME = nokogiri
TARGET_ENTRY = Init_$(TARGET_NAME)
DLLIB = $(TARGET).bundle
EXTSTATIC = 
STATIC_LIB = 

TIMESTAMP_DIR = .
BINDIR        = $(bindir)
RUBYCOMMONDIR = $(sitedir)$(target_prefix)
RUBYLIBDIR    = $(sitelibdir)$(target_prefix)
RUBYARCHDIR   = $(sitearchdir)$(target_prefix)
HDRDIR        = $(sitehdrdir)$(target_prefix)
ARCHHDRDIR    = $(sitearchhdrdir)$(target_prefix)
TARGET_SO_DIR =
TARGET_SO     = $(TARGET_SO_DIR)$(DLLIB)
CLEANLIBS     = $(TARGET_SO) $(TARGET_SO).dSYM
CLEANOBJS     = $(OBJS) *.bak
TARGET_SO_DIR_TIMESTAMP = $(TIMESTAMP_DIR)/.sitearchdir.-.nokogiri.time

all:    $(DLLIB)
static: $(STATIC_LIB)
.PHONY: all install static install-so install-rb
.PHONY: clean clean-so clean-static clean-rb

clean-static::
clean-rb-default::
clean-rb::
clean-so::
clean: clean-so clean-static clean-rb-default clean-rb
		-$(Q)$(RM_RF) $(CLEANLIBS) $(CLEANOBJS) $(CLEANFILES) .*.time

distclean-rb-default::
distclean-rb::
distclean-so::
distclean-static::
distclean: clean distclean-so distclean-static distclean-rb-default distclean-rb
		-$(Q)$(RM) Makefile $(RUBY_EXTCONF_H) conftest.* mkmf.log
		-$(Q)$(RM) core ruby$(EXEEXT) *~ $(DISTCLEANFILES)
		-$(Q)$(RMDIRS) $(DISTCLEANDIRS) 2> /dev/null || true

realclean: distclean
install: install-so install-rb

install-so: $(DLLIB) $(TARGET_SO_DIR_TIMESTAMP)
	$(INSTALL_PROG) $(DLLIB) $(RUBYARCHDIR)
clean-static::
	-$(Q)$(RM) $(STATIC_LIB)
install-rb: pre-install-rb do-install-rb install-rb-default
install-rb-default: pre-install-rb-default do-install-rb-default
pre-install-rb: Makefile
pre-install-rb-default: Makefile
do-install-rb:
do-install-rb-default:
pre-install-rb-default:
	@$(NULLCMD)
pre-install-rb: $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libexslt.time
do-install-rb: $(RUBYLIBDIR)/include/libexslt/exslt.h
$(RUBYLIBDIR)/include/libexslt/exslt.h: $(srcdir)/include/libexslt/exslt.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libexslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libexslt/exslt.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libexslt/exsltconfig.h
$(RUBYLIBDIR)/include/libexslt/exsltconfig.h: $(srcdir)/include/libexslt/exsltconfig.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libexslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libexslt/exsltconfig.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libexslt/exsltexports.h
$(RUBYLIBDIR)/include/libexslt/exsltexports.h: $(srcdir)/include/libexslt/exsltexports.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libexslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libexslt/exsltexports.h $(@D)
pre-install-rb: $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/DOCBparser.h
$(RUBYLIBDIR)/include/libxml2/libxml/DOCBparser.h: $(srcdir)/include/libxml2/libxml/DOCBparser.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/DOCBparser.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/HTMLparser.h
$(RUBYLIBDIR)/include/libxml2/libxml/HTMLparser.h: $(srcdir)/include/libxml2/libxml/HTMLparser.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/HTMLparser.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/HTMLtree.h
$(RUBYLIBDIR)/include/libxml2/libxml/HTMLtree.h: $(srcdir)/include/libxml2/libxml/HTMLtree.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/HTMLtree.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/SAX.h
$(RUBYLIBDIR)/include/libxml2/libxml/SAX.h: $(srcdir)/include/libxml2/libxml/SAX.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/SAX.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/SAX2.h
$(RUBYLIBDIR)/include/libxml2/libxml/SAX2.h: $(srcdir)/include/libxml2/libxml/SAX2.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/SAX2.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/c14n.h
$(RUBYLIBDIR)/include/libxml2/libxml/c14n.h: $(srcdir)/include/libxml2/libxml/c14n.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/c14n.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/catalog.h
$(RUBYLIBDIR)/include/libxml2/libxml/catalog.h: $(srcdir)/include/libxml2/libxml/catalog.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/catalog.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/chvalid.h
$(RUBYLIBDIR)/include/libxml2/libxml/chvalid.h: $(srcdir)/include/libxml2/libxml/chvalid.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/chvalid.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/debugXML.h
$(RUBYLIBDIR)/include/libxml2/libxml/debugXML.h: $(srcdir)/include/libxml2/libxml/debugXML.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/debugXML.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/dict.h
$(RUBYLIBDIR)/include/libxml2/libxml/dict.h: $(srcdir)/include/libxml2/libxml/dict.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/dict.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/encoding.h
$(RUBYLIBDIR)/include/libxml2/libxml/encoding.h: $(srcdir)/include/libxml2/libxml/encoding.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/encoding.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/entities.h
$(RUBYLIBDIR)/include/libxml2/libxml/entities.h: $(srcdir)/include/libxml2/libxml/entities.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/entities.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/globals.h
$(RUBYLIBDIR)/include/libxml2/libxml/globals.h: $(srcdir)/include/libxml2/libxml/globals.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/globals.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/hash.h
$(RUBYLIBDIR)/include/libxml2/libxml/hash.h: $(srcdir)/include/libxml2/libxml/hash.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/hash.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/list.h
$(RUBYLIBDIR)/include/libxml2/libxml/list.h: $(srcdir)/include/libxml2/libxml/list.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/list.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/nanoftp.h
$(RUBYLIBDIR)/include/libxml2/libxml/nanoftp.h: $(srcdir)/include/libxml2/libxml/nanoftp.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/nanoftp.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/nanohttp.h
$(RUBYLIBDIR)/include/libxml2/libxml/nanohttp.h: $(srcdir)/include/libxml2/libxml/nanohttp.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/nanohttp.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/parser.h
$(RUBYLIBDIR)/include/libxml2/libxml/parser.h: $(srcdir)/include/libxml2/libxml/parser.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/parser.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/parserInternals.h
$(RUBYLIBDIR)/include/libxml2/libxml/parserInternals.h: $(srcdir)/include/libxml2/libxml/parserInternals.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/parserInternals.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/pattern.h
$(RUBYLIBDIR)/include/libxml2/libxml/pattern.h: $(srcdir)/include/libxml2/libxml/pattern.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/pattern.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/relaxng.h
$(RUBYLIBDIR)/include/libxml2/libxml/relaxng.h: $(srcdir)/include/libxml2/libxml/relaxng.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/relaxng.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/schemasInternals.h
$(RUBYLIBDIR)/include/libxml2/libxml/schemasInternals.h: $(srcdir)/include/libxml2/libxml/schemasInternals.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/schemasInternals.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/schematron.h
$(RUBYLIBDIR)/include/libxml2/libxml/schematron.h: $(srcdir)/include/libxml2/libxml/schematron.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/schematron.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/threads.h
$(RUBYLIBDIR)/include/libxml2/libxml/threads.h: $(srcdir)/include/libxml2/libxml/threads.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/threads.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/tree.h
$(RUBYLIBDIR)/include/libxml2/libxml/tree.h: $(srcdir)/include/libxml2/libxml/tree.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/tree.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/uri.h
$(RUBYLIBDIR)/include/libxml2/libxml/uri.h: $(srcdir)/include/libxml2/libxml/uri.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/uri.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/valid.h
$(RUBYLIBDIR)/include/libxml2/libxml/valid.h: $(srcdir)/include/libxml2/libxml/valid.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/valid.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xinclude.h
$(RUBYLIBDIR)/include/libxml2/libxml/xinclude.h: $(srcdir)/include/libxml2/libxml/xinclude.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xinclude.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xlink.h
$(RUBYLIBDIR)/include/libxml2/libxml/xlink.h: $(srcdir)/include/libxml2/libxml/xlink.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xlink.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xmlIO.h
$(RUBYLIBDIR)/include/libxml2/libxml/xmlIO.h: $(srcdir)/include/libxml2/libxml/xmlIO.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xmlIO.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xmlautomata.h
$(RUBYLIBDIR)/include/libxml2/libxml/xmlautomata.h: $(srcdir)/include/libxml2/libxml/xmlautomata.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xmlautomata.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xmlerror.h
$(RUBYLIBDIR)/include/libxml2/libxml/xmlerror.h: $(srcdir)/include/libxml2/libxml/xmlerror.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xmlerror.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xmlexports.h
$(RUBYLIBDIR)/include/libxml2/libxml/xmlexports.h: $(srcdir)/include/libxml2/libxml/xmlexports.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xmlexports.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xmlmemory.h
$(RUBYLIBDIR)/include/libxml2/libxml/xmlmemory.h: $(srcdir)/include/libxml2/libxml/xmlmemory.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xmlmemory.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xmlmodule.h
$(RUBYLIBDIR)/include/libxml2/libxml/xmlmodule.h: $(srcdir)/include/libxml2/libxml/xmlmodule.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xmlmodule.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xmlreader.h
$(RUBYLIBDIR)/include/libxml2/libxml/xmlreader.h: $(srcdir)/include/libxml2/libxml/xmlreader.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xmlreader.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xmlregexp.h
$(RUBYLIBDIR)/include/libxml2/libxml/xmlregexp.h: $(srcdir)/include/libxml2/libxml/xmlregexp.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xmlregexp.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xmlsave.h
$(RUBYLIBDIR)/include/libxml2/libxml/xmlsave.h: $(srcdir)/include/libxml2/libxml/xmlsave.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xmlsave.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xmlschemas.h
$(RUBYLIBDIR)/include/libxml2/libxml/xmlschemas.h: $(srcdir)/include/libxml2/libxml/xmlschemas.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xmlschemas.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xmlschemastypes.h
$(RUBYLIBDIR)/include/libxml2/libxml/xmlschemastypes.h: $(srcdir)/include/libxml2/libxml/xmlschemastypes.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xmlschemastypes.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xmlstring.h
$(RUBYLIBDIR)/include/libxml2/libxml/xmlstring.h: $(srcdir)/include/libxml2/libxml/xmlstring.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xmlstring.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xmlunicode.h
$(RUBYLIBDIR)/include/libxml2/libxml/xmlunicode.h: $(srcdir)/include/libxml2/libxml/xmlunicode.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xmlunicode.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xmlversion.h
$(RUBYLIBDIR)/include/libxml2/libxml/xmlversion.h: $(srcdir)/include/libxml2/libxml/xmlversion.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xmlversion.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xmlwriter.h
$(RUBYLIBDIR)/include/libxml2/libxml/xmlwriter.h: $(srcdir)/include/libxml2/libxml/xmlwriter.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xmlwriter.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xpath.h
$(RUBYLIBDIR)/include/libxml2/libxml/xpath.h: $(srcdir)/include/libxml2/libxml/xpath.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xpath.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xpathInternals.h
$(RUBYLIBDIR)/include/libxml2/libxml/xpathInternals.h: $(srcdir)/include/libxml2/libxml/xpathInternals.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xpathInternals.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxml2/libxml/xpointer.h
$(RUBYLIBDIR)/include/libxml2/libxml/xpointer.h: $(srcdir)/include/libxml2/libxml/xpointer.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxml2/libxml/xpointer.h $(@D)
pre-install-rb: $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
do-install-rb: $(RUBYLIBDIR)/include/libxslt/attributes.h
$(RUBYLIBDIR)/include/libxslt/attributes.h: $(srcdir)/include/libxslt/attributes.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/attributes.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/documents.h
$(RUBYLIBDIR)/include/libxslt/documents.h: $(srcdir)/include/libxslt/documents.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/documents.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/extensions.h
$(RUBYLIBDIR)/include/libxslt/extensions.h: $(srcdir)/include/libxslt/extensions.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/extensions.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/extra.h
$(RUBYLIBDIR)/include/libxslt/extra.h: $(srcdir)/include/libxslt/extra.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/extra.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/functions.h
$(RUBYLIBDIR)/include/libxslt/functions.h: $(srcdir)/include/libxslt/functions.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/functions.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/imports.h
$(RUBYLIBDIR)/include/libxslt/imports.h: $(srcdir)/include/libxslt/imports.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/imports.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/keys.h
$(RUBYLIBDIR)/include/libxslt/keys.h: $(srcdir)/include/libxslt/keys.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/keys.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/namespaces.h
$(RUBYLIBDIR)/include/libxslt/namespaces.h: $(srcdir)/include/libxslt/namespaces.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/namespaces.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/numbersInternals.h
$(RUBYLIBDIR)/include/libxslt/numbersInternals.h: $(srcdir)/include/libxslt/numbersInternals.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/numbersInternals.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/pattern.h
$(RUBYLIBDIR)/include/libxslt/pattern.h: $(srcdir)/include/libxslt/pattern.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/pattern.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/preproc.h
$(RUBYLIBDIR)/include/libxslt/preproc.h: $(srcdir)/include/libxslt/preproc.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/preproc.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/security.h
$(RUBYLIBDIR)/include/libxslt/security.h: $(srcdir)/include/libxslt/security.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/security.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/templates.h
$(RUBYLIBDIR)/include/libxslt/templates.h: $(srcdir)/include/libxslt/templates.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/templates.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/transform.h
$(RUBYLIBDIR)/include/libxslt/transform.h: $(srcdir)/include/libxslt/transform.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/transform.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/variables.h
$(RUBYLIBDIR)/include/libxslt/variables.h: $(srcdir)/include/libxslt/variables.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/variables.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/xslt.h
$(RUBYLIBDIR)/include/libxslt/xslt.h: $(srcdir)/include/libxslt/xslt.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/xslt.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/xsltInternals.h
$(RUBYLIBDIR)/include/libxslt/xsltInternals.h: $(srcdir)/include/libxslt/xsltInternals.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/xsltInternals.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/xsltconfig.h
$(RUBYLIBDIR)/include/libxslt/xsltconfig.h: $(srcdir)/include/libxslt/xsltconfig.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/xsltconfig.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/xsltexports.h
$(RUBYLIBDIR)/include/libxslt/xsltexports.h: $(srcdir)/include/libxslt/xsltexports.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/xsltexports.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/xsltlocale.h
$(RUBYLIBDIR)/include/libxslt/xsltlocale.h: $(srcdir)/include/libxslt/xsltlocale.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/xsltlocale.h $(@D)
do-install-rb: $(RUBYLIBDIR)/include/libxslt/xsltutils.h
$(RUBYLIBDIR)/include/libxslt/xsltutils.h: $(srcdir)/include/libxslt/xsltutils.h $(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time
	$(Q) $(INSTALL_DATA) $(srcdir)/include/libxslt/xsltutils.h $(@D)
pre-install-rb:
	$(Q1:0=@$(MAKE) -q do-install-rb || )$(ECHO1:0=echo) installing nokogiri libraries
$(TARGET_SO_DIR_TIMESTAMP):
	$(Q) $(MAKEDIRS) $(@D) $(RUBYARCHDIR)
	$(Q) $(TOUCH) $@
$(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libexslt.time:
	$(Q) $(MAKEDIRS) $(@D) $(RUBYLIBDIR)/include/libexslt
	$(Q) $(TOUCH) $@
$(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxml2.-.libxml.time:
	$(Q) $(MAKEDIRS) $(@D) $(RUBYLIBDIR)/include/libxml2/libxml
	$(Q) $(TOUCH) $@
$(TIMESTAMP_DIR)/.sitelibdir.-.nokogiri.-.include.-.libxslt.time:
	$(Q) $(MAKEDIRS) $(@D) $(RUBYLIBDIR)/include/libxslt
	$(Q) $(TOUCH) $@

site-install: site-install-so site-install-rb
site-install-so: install-so
site-install-rb: install-rb

.SUFFIXES: .c .m .cc .mm .cxx .cpp .o .S

.cc.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $(CSRCFLAG)$<

.cc.S:
	$(ECHO) translating $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -S $(CSRCFLAG)$<

.mm.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $(CSRCFLAG)$<

.mm.S:
	$(ECHO) translating $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -S $(CSRCFLAG)$<

.cxx.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $(CSRCFLAG)$<

.cxx.S:
	$(ECHO) translating $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -S $(CSRCFLAG)$<

.cpp.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $(CSRCFLAG)$<

.cpp.S:
	$(ECHO) translating $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -S $(CSRCFLAG)$<

.c.o:
	$(ECHO) compiling $(<)
	$(Q) $(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -c $(CSRCFLAG)$<

.c.S:
	$(ECHO) translating $(<)
	$(Q) $(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -S $(CSRCFLAG)$<

.m.o:
	$(ECHO) compiling $(<)
	$(Q) $(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -c $(CSRCFLAG)$<

.m.S:
	$(ECHO) translating $(<)
	$(Q) $(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -S $(CSRCFLAG)$<

$(TARGET_SO): $(OBJS) Makefile
	$(ECHO) linking shared-object nokogiri/$(DLLIB)
	-$(Q)$(RM) $(@)
	$(Q) $(LDSHARED) -o $@ $(OBJS) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)
	$(Q) $(POSTLINK)



###
# -*-makefile-*-
# DO NOT DELETE

gumbo.o: $(srcdir)/nokogiri.h
html_document.o: $(srcdir)/nokogiri.h
html_element_description.o: $(srcdir)/nokogiri.h
html_entity_lookup.o: $(srcdir)/nokogiri.h
html_sax_parser_context.o: $(srcdir)/nokogiri.h
html_sax_push_parser.o: $(srcdir)/nokogiri.h
libxml2_backwards_compat.o: $(srcdir)/nokogiri.h
nokogiri.o: $(srcdir)/nokogiri.h
test_global_handlers.o: $(srcdir)/nokogiri.h
xml_attr.o: $(srcdir)/nokogiri.h
xml_attribute_decl.o: $(srcdir)/nokogiri.h
xml_cdata.o: $(srcdir)/nokogiri.h
xml_comment.o: $(srcdir)/nokogiri.h
xml_document.o: $(srcdir)/nokogiri.h
xml_document_fragment.o: $(srcdir)/nokogiri.h
xml_dtd.o: $(srcdir)/nokogiri.h
xml_element_content.o: $(srcdir)/nokogiri.h
xml_element_decl.o: $(srcdir)/nokogiri.h
xml_encoding_handler.o: $(srcdir)/nokogiri.h
xml_entity_decl.o: $(srcdir)/nokogiri.h
xml_entity_reference.o: $(srcdir)/nokogiri.h
xml_namespace.o: $(srcdir)/nokogiri.h
xml_node.o: $(srcdir)/nokogiri.h
xml_node_set.o: $(srcdir)/nokogiri.h
xml_processing_instruction.o: $(srcdir)/nokogiri.h
xml_reader.o: $(srcdir)/nokogiri.h
xml_relax_ng.o: $(srcdir)/nokogiri.h
xml_sax_parser.o: $(srcdir)/nokogiri.h
xml_sax_parser_context.o: $(srcdir)/nokogiri.h
xml_sax_push_parser.o: $(srcdir)/nokogiri.h
xml_schema.o: $(srcdir)/nokogiri.h
xml_syntax_error.o: $(srcdir)/nokogiri.h
xml_text.o: $(srcdir)/nokogiri.h
xml_xpath_context.o: $(srcdir)/nokogiri.h
xslt_stylesheet.o: $(srcdir)/nokogiri.h

all: clean-ports
clean-ports: $(DLLIB)
	-$(Q)$(RUBY) $(srcdir)/extconf.rb --clean --enable-static
