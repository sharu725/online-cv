## Process this file with automake to produce Makefile.in

SUBDIRS=docs REC1 REC2 REC general namespaces keys numbers documents \
        extensions reports xmlspec multiple xinclude XSLTMark docbook \
	exslt plugins fuzz

all:

# Each subdirectory has it's own Makefile to cater for the unique
# requirements of that subdirectory.  In general, xsltproc will be
# run on the *.xsl / *.xml file combinations, and the output of that
# run will be compared with the "expected" output contained in *.out
# and (if errors are expected) in *.err
test tests:
	@(cur=`pwd` ; for dir in $(SUBDIRS) ; do cd $$dir ; $(MAKE) CHECKER='$(CHECKER)' tests ; cd $$cur ; done)

valgrind:
	@echo '## Running the regression tests under Valgrind'
	@echo '## Go get a cup of coffee it is gonna take a while ...'
	$(MAKE) CHECKER='libtool --mode=execute valgrind -q --leak-check=full' tests

full: tests docbook_tests

docbook_tests:
	@(cd docbook ; $(MAKE) full)

