## Process this file with automake to produce Makefile.in

SUBDIRS=common functions math saxon sets strings dynamic date $(CRYPTO_TESTDIR)
DIST_SUBDIRS = common functions math saxon sets strings dynamic date crypto

test tests:
	@(cur=`pwd` ; for dir in $(SUBDIRS) ; do cd $$dir ; $(MAKE) CHECKER='$(CHECKER)' tests ; cd $$cur ; done)

valgrind:
	@echo '## Running the regression tests under Valgrind'
	$(MAKE) CHECKER='libtool --mode=execute valgrind -q --leak-check=full' tests

