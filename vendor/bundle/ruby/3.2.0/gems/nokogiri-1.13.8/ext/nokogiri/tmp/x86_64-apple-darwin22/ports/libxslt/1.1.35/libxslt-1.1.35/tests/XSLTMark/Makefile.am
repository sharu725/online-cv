## Process this file with automake to produce Makefile.in

AUTOMAKE_OPTIONS = -Wno-override
EXTRA_DIST = \
  dbgen.pl \
  alphabetize.out alphabetize.ref alphabetize.xsl \
  attsets.out attsets.ref attsets.xsl \
  avts.out avts.ref avts.xsl \
  axis.out axis.ref axis.xml axis.xsl \
  backwards.out backwards.ref backwards.xsl \
  bottles.out bottles.ref bottles.xml bottles.xsl \
  breadth.out breadth.ref breadth.xml \
  brutal.out brutal.ref brutal.xml brutal.xsl \
  chart.out chart.ref chart.xml chart.xsl \
  creation.out creation.ref creation.xsl \
  current.out current.ref current.xml current.xsl \
  dbonerow.out dbonerow.ref dbonerow.xsl \
  dbtail.out dbtail.ref dbtail.xsl \
  decoy.out decoy.xsl \
  depth.out depth.ref depth.xml \
  encrypt.out encrypt.ref encrypt.xsl \
  find.xsl \
  functions.out functions.ref functions.xsl \
  game.out game.ref game.xml game.xsl \
  gettysburg.xml \
  html.out html.ref html.xml html.xsl \
  identity.out identity.ref identity.xml identity.xsl \
  inventory.out inventory.ref inventory.xml inventory.xsl \
  metric.out metric.ref metric.xml metric.xsl \
  number.out number.xml number.xsl \
  oddtemplate.out oddtemplate.ref oddtemplate.xml oddtemplate.xsl \
  patterns.out patterns.ref patterns.xsl \
  prettyprint.out prettyprint.ref prettyprint.xsl \
  priority.out priority.ref priority.xml priority.xsl \
  products.out products.ref products.xml products.xsl \
  queens.out queens.ref queens.xml queens.xsl \
  reverser.out reverser.ref reverser.xsl \
  stringsort.out stringsort.ref stringsort.xsl \
  summarize.out summarize.ref summarize.xsl \
  total.out total.ref total.xsl \
  tower.out tower.ref tower.xml tower.xsl tower2.xsl \
  trend.out trend.ref trend.xml trend.xsl \
  union.out union.ref union.xml union.xsl \
  xpath.out xpath.ref xpath.xml xpath.xsl \
  xslbench1.out xslbench1.xml xslbench1.xsl \
  xslbench2.out xslbench2.xsl \
  xslbench3.out xslbench3.xsl \
  xslbenchdream.xml

ALL_TESTS=	alphabetize attsets avts axis backwards bottles breadth brutal chart \
  creation current dbonerow dbtail decoy depth encrypt functions game \
  html identity inventory metric number oddtemplate patterns prettyprint \
  priority products queens reverser stringsort summarize total tower trend \
  union xpath xslbench1 xslbench2 xslbench3

dummy $(ALL_TESTS:=.out):
	$(MAKE) $(@:.out=)

xsltproc = $(top_builddir)/xsltproc/xsltproc

$(xsltproc):
	cd ../../xsltproc && $(MAKE) xsltproc

test tests:
	@echo '## Running XSLTMark tests'
	@$(MAKE) $(ALL_TESTS)

valgrind:
	@echo '## Running the regression tests under Valgrind'
	$(MAKE) CHECKER='libtool --mode=execute valgrind -q --leak-check=full' tests

CLEANFILES = *.tmp *~ .memdump core db100.xml db1000.xml db10000.xml


if WITH_PERL
db100.xml: $(srcdir)/dbgen.pl
	$(PERL) $(srcdir)/dbgen.pl 100 > db100.xml

db1000.xml: $(srcdir)/dbgen.pl
	$(PERL) $(srcdir)/dbgen.pl 1000 > db1000.xml

db10000.xml: $(srcdir)/dbgen.pl
	$(PERL) $(srcdir)/dbgen.pl 10000 > db10000.xml

alphabetize:	db100.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

avts:			db100.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

creation:		db100.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

dbonerow:		db10000.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

dbtail:		db100.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

decoy:		db100.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

encrypt:		db100.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

functions:		db100.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

identity:		db1000.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

patterns:		db100.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

prettyprint:	db100.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

stringsort:		db1000.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp
else

alphabetize:
avts:
creation:
dbonerow:
dbtail:
decoy:
encrypt:
functions:
identity:
patterns:
prettyprint:
stringsort:

endif

attsets:		chart.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

axis:			axis.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

backwards:		game.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

bottles:		bottles.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

brutal:		brutal.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

chart:		chart.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

current:		current.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

game:			game.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

html:			html.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

inventory:		inventory.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

metric:		metric.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

number:		number.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

oddtemplate:	oddtemplate.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

priority:		priority.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

products:		products.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

queens:		queens.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

reverser:		gettysburg.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

summarize:		queens.xsl $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

total:		chart.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

tower:		tower.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

trend:		trend.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

union:		union.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

xpath:		xpath.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

xslbench1:		xslbench1.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

xslbench2:		xslbenchdream.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

xslbench3:		xslbenchdream.xml $(xsltproc)
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/$@.xsl $< > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

breadth: $(xsltproc)
	@test -f breadth.xml || $(LN_S) $(srcdir)/breadth.xml .
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/find.xsl $@.xml > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

depth: $(xsltproc)
	@test -f depth.xml || $(LN_S) $(srcdir)/depth.xml .
	@(echo > .memdump)
	@log=`$(CHECKER) $(xsltproc) \
		$(srcdir)/find.xsl $@.xml > $@.tmp; \
	  if [ ! -f $(srcdir)/$@.out ] ; then \
		cp $@.tmp $(srcdir)/$@.out ; \
	  else \
		diff $(srcdir)/$@.out $@.tmp ; \
	  fi ; \
	  grep "MORY ALLO" .memdump  | grep -v "MEMORY ALLOCATED : 0" || true`
	@if [ -n "$$log" ] ; then \
	  	echo $@ result ; \
		echo "$$log" ; \
	fi
	@rm -f $@.tmp

.PHONY: test tests valgrind $(ALL_TESTS)
