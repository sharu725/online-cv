#!/usr/bin/python -u
#
# The exercise of rewriting xsltproc on top of the python
# bindings, not complete yet and shows up the things missing
# from the existing python interfaces
#
import sys
import time
import os
import string
import libxml2
# Memory debug specific
libxml2.debugMemory(1)
import libxslt

debug = 0
repeat = 0
timing = 0
novalid = 0
noout = 0
docbook = 0
html = 0
xinclude = 0
profile = 0
params = {}
output = None
errorno = 0

#
# timing
#
begin = 0
endtime = 0
def startTimer():
    global begin

    begin = time.time()

def endTimer(msg):
    global begin
    global endtime

    endtime = time.time()
    print("%s took %d ms" % (msg, (endtime - begin) * 1000))

def xsltProcess(doc, cur, filename):
    global timing
    global xinclude
    global params
    global html

    if xinclude:
        if timing:
            startTimer()
        doc.XIncludeProcess()
        if timing:
            endTimer("XInclude processing %s" % (filename))

    if timing:
        startTimer()
    if output == None:
        if repeat != 0:
            for j in range(1, repeat):
                res = cur.applyStylesheet(doc, params)
                res.freeDoc()
                doc.freeDoc()
                if html == 1:
                    doc = libxml2.htmlParseFile(filename, None)
                else:
                    doc = libxml2.parseFile(filename, None)
#        ctxt = libxslt.newTransformContext(doc)
#        if ctxt == None:
#            return
        if profile:
            print("TODO: Profiling not yet supported")
        else:
            res = cur.applyStylesheet(doc, params)
        if timing:
            if repeat != 0:
                endTimer("Applying stylesheet %d times" % (repeat))
            else:
                endTimer("Applying stylesheet")
        doc.freeDoc()
        if res == None:
            print("no result for %s" % (filename))
            return
        if noout != 0:
            res.freeDoc()
            return
        if debug == 1:
            res.debugDumpDocument(None)
        else:
            if timing:
                startTimer()
            cur.saveResultToFilename("-", res, 0)
            if timing:
                endTimer("Saving result")
        res.freeDoc()
    else:
        print("TODO: xsltRunStylesheet not yet mapped")

def usage(name = 'pyxsltproc'):
    print("Usage: %s [options] stylesheet file [file ...]" % (name))
    print("a reimplementation of xsltproc(1) on top of libxslt-python")
    print("   Options:")
    print("\t--version or -V: show the version of libxml and libxslt used")
    print("\t--verbose or -v: show logs of what's happening")
    print("\t--output file or -o file: save to a given file")
    print("\t--timing: display the time used")
    print("\t--repeat: run the transformation 20 times")
    print("\t--debug: dump the tree of the result instead")
    print("\t--novalid skip the Dtd loading phase")
    print("\t--noout: do not dump the result")
    print("\t--maxdepth val : increase the maximum depth")
    print("\t--html: the input document is(are) an HTML file(s)")
    print("\t--param name value : pass a (parameter,value) pair")
    print("\t       value is an XPath expression.")
    print("\t       string values must be quoted like \"'string'\"")
    print("\t       or use stringparam to avoid it")
    print("\t--stringparam name value : pass a (parameter,string value) pair")
    print("\t--nonet refuse to fetch DTDs or entities over network")
    print("\t--catalogs : use SGML catalogs from $SGML_CATALOG_FILES")
    print("\t             otherwise XML Catalogs starting from ")
    print("\t         file:///etc/xml/catalog are activated by default")
    print("\t--xinclude : do XInclude processing on document input")
    print("\t--profile or --norman : dump profiling information ")
    print("\nProject libxslt home page: https://gitlab.gnome.org/GNOME/libxslt")

def main(args = None):
    global debug
    global repeat
    global timing
    global novalid
    global noout
    global docbook
    global html
    global xinclude
    global profile
    global params
    global output
    global errorno

    done = 0
    cur = None

    if not args:
        args = sys.argv[1:]
        if len(args) <= 0:
            usage(sys.argv[0])
            

    i = 0
    while i < len(args):
        if args[i] == "-":
            break
        if args[i][0] != '-':
            i = i + 1
            continue
        if args[i] == "-timing" or args[i] == "--timing":
            timing = 1
        elif args[i] == "-debug" or args[i] == "--debug":
            debug = 1
        elif args[i] == "-verbose" or args[i] == "--verbose" or \
             args[i] == "-v":
            print("TODO: xsltSetGenericDebugFunc() mapping missing")
        elif args[i] == "-version" or args[i] == "--version" or \
             args[i] == "-V":
            print("TODO: version information mapping missing")
        elif args[i] == "-verbose" or args[i] == "--verbose" or \
             args[i] == "-v":
            if repeat == 0:
                repeat = 20
            else:
                repeat = 100
        elif args[i] == "-novalid" or args[i] == "--novalid":
            print("TODO: xmlLoadExtDtdDefaultValue mapping missing")
            novalid = 1
        elif args[i] == "-noout" or args[i] == "--noout":
            noout = 1
        elif args[i] == "-html" or args[i] == "--html":
            html = 1
        elif args[i] == "-nonet" or args[i] == "--nonet":
            print("TODO: xmlSetExternalEntityLoader mapping missing")
            nonet = 1
        elif args[i] == "-catalogs" or args[i] == "--catalogs":
            try:
                catalogs = os.environ['SGML_CATALOG_FILES']
            except:
                catalogs = None
            if catalogs != none:
                libxml2.xmlLoadCatalogs(catalogs)
            else:
                print("Variable $SGML_CATALOG_FILES not set")
        elif args[i] == "-xinclude" or args[i] == "--xinclude":
            xinclude = 1
            libxslt.setXIncludeDefault(1)
        elif args[i] == "-param" or args[i] == "--param":
            i = i + 1
            params[args[i]] = args[i + 1]
            i = i + 1
        elif args[i] == "-stringparam" or args[i] == "--stringparam":
            i = i + 1
            params[args[i]] = "'%s'" % (args[i + 1])
            i = i + 1
        elif args[i] == "-maxdepth" or args[i] == "--maxdepth":
            print("TODO: xsltMaxDepth mapping missing")
        else:
            print("Unknown option %s" % (args[i]))
            usage()
            return(3)
        
        
        
        
        i = i + 1
        
    libxml2.lineNumbersDefault(1)
    libxml2.substituteEntitiesDefault(1)
    # TODO: xmlLoadExtDtdDefaultValue = XML_DETECT_IDS | XML_COMPLETE_ATTRS
    # if novalid:
    # TODO: xmlLoadExtDtdDefaultValue = 0

    # TODO libxslt.exsltRegisterAll();
    libxslt.registerTestModule()

    i = 0
    while i < len(args) and done == 0:
        if args[i] == "-maxdepth" or args[i] == "--maxdepth":
            i = i + 2
            continue
        if args[i] == "-o" or args[i] == "-output" or args[i] == "--output":
            i = i + 2
            continue
        if args[i] == "-param" or args[i] == "--param":
            i = i + 3
            continue
        if args[i] == "-stringparam" or args[i] == "--stringparam":
            i = i + 3
            continue
        if args[i] != "-" and args[i][0] == '-':
            i = i + 1
            continue
        if timing:
            startTimer()
        style = libxml2.parseFile(args[i])
        if timing:
            endTimer("Parsing stylesheet %s" % (args[i]))
        if style == None:
            print("cannot parse %s" % (args[i]))
            cur = None
            errorno = 4
            done = 1
        else:
            cur = libxslt.loadStylesheetPI(style)
            if cur != None:
                xsltProcess(style, cur, args[i])
                cur = None
            else:
                cur = libxslt.parseStylesheetDoc(style)
                if cur == None:
                    style.freeDoc()
                    errorno = 5
                    done = 1
        i = i + 1
        break

    while i < len(args) and done == 0 and cur != None:
        if timing:
            startTimer()
        if html:
            doc = libxml2.htmlParseFile(args[i], None)
        else:
            doc = libxml2.parseFile(args[i])
        if doc == None:
            print("unable to parse %s" % (args[i]))
            errorno = 6
            i = i + 1
            continue
        if timing:
            endTimer("Parsing document %s" % (args[i]))
        xsltProcess(doc, cur, args[i])
        i = i + 1

    if cur != None:
        cur.freeStylesheet()
    params = None

if __name__ == "__main__":
    main()

# Memory debug specific
libxslt.cleanup()
if libxml2.debugMemory(1) != 0:
    print("Memory leak %d bytes" % (libxml2.debugMemory(1)))
    libxml2.dumpMemory()

sys.exit(errorno)
