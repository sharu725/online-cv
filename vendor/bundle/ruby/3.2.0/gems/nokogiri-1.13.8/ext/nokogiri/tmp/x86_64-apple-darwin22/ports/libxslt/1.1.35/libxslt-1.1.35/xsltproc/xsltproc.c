/*
 * xsltproc.c: user program for the XSL Transformation 1.0 engine
 *
 * See Copyright for the status of this software.
 *
 * daniel@veillard.com
 */

#include "libxslt/libxslt.h"
#include "libxslt/xsltconfig.h"
#include "libexslt/exslt.h"
#include <stdio.h>
#ifdef HAVE_STRING_H
#include <string.h>
#endif
#ifdef HAVE_SYS_TIME_H
#include <sys/time.h>
#endif
#ifdef HAVE_TIME_H
#include <time.h>
#endif
#ifdef HAVE_SYS_STAT_H
#include <sys/stat.h>
#endif
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif
#ifdef HAVE_STDLIB_H
#include <stdlib.h>
#endif
#ifdef HAVE_STDARG_H
#include <stdarg.h>
#endif
#if defined(_WIN32) && !defined(__CYGWIN__)
#include <fcntl.h>
#endif
#include <libxml/xmlmemory.h>
#include <libxml/debugXML.h>
#include <libxml/HTMLtree.h>
#include <libxml/xmlIO.h>
#ifdef LIBXML_XINCLUDE_ENABLED
#include <libxml/xinclude.h>
#endif
#ifdef LIBXML_CATALOG_ENABLED
#include <libxml/catalog.h>
#endif
#include <libxml/parser.h>
#include <libxml/parserInternals.h>
#include <libxml/uri.h>

#include <libxslt/xslt.h>
#include <libxslt/xsltInternals.h>
#include <libxslt/transform.h>
#include <libxslt/xsltutils.h>
#include <libxslt/extensions.h>
#include <libxslt/security.h>

#include <libexslt/exsltconfig.h>

#if defined(HAVE_SYS_TIME_H)
#include <sys/time.h>
#elif defined(HAVE_TIME_H)
#include <time.h>
#endif

#ifdef HAVE_SYS_TIMEB_H
#include <sys/timeb.h>
#endif

static int debug = 0;
static int repeat = 0;
static int timing = 0;
static int dumpextensions = 0;
static int novalid = 0;
static int nodtdattr = 0;
static int noout = 0;
static int nodict = 0;
#ifdef LIBXML_HTML_ENABLED
static int html = 0;
#endif
static char *encoding = NULL;
static int load_trace = 0;
#ifdef LIBXML_XINCLUDE_ENABLED
static int xinclude = 0;
static int xincludestyle = 0;
#endif
static int profile = 0;

#define MAX_PARAMETERS 64
#define MAX_PATHS 64
#ifdef _WIN32
# define PATH_SEPARATOR ';'
#else
# define PATH_SEPARATOR ':'
#endif

static int options = XSLT_PARSE_OPTIONS;
static const char *params[MAX_PARAMETERS + 1];
static int nbparams = 0;
static xmlChar *strparams[MAX_PARAMETERS + 1];
static int nbstrparams = 0;
static xmlChar *paths[MAX_PATHS + 1];
static int nbpaths = 0;
static char *output = NULL;
static int errorno = 0;
static const char *writesubtree = NULL;

/*
 * Entity loading control and customization.
 */

static
void parsePath(const xmlChar *path) {
    const xmlChar *cur;

    if (path == NULL)
	return;
    while (*path != 0) {
	if (nbpaths >= MAX_PATHS) {
	    fprintf(stderr, "MAX_PATHS reached: too many paths\n");
	    return;
	}
	cur = path;
	while ((*cur == ' ') || (*cur == PATH_SEPARATOR))
	    cur++;
	path = cur;
	while ((*cur != 0) && (*cur != ' ') && (*cur != PATH_SEPARATOR))
	    cur++;
	if (cur != path) {
	    paths[nbpaths] = xmlStrndup(path, cur - path);
	    if (paths[nbpaths] != NULL)
		nbpaths++;
	    path = cur;
	}
    }
}

xmlExternalEntityLoader defaultEntityLoader = NULL;

static xmlParserInputPtr
xsltprocExternalEntityLoader(const char *URL, const char *ID,
			     xmlParserCtxtPtr ctxt) {
    xmlParserInputPtr ret = NULL;
    warningSAXFunc warning = NULL;

    int i;
    const char *lastsegment = URL;
    const char *iter = URL;

    if (nbpaths > 0) {
	while (*iter != 0) {
	    if (*iter == '/')
		lastsegment = iter + 1;
	    iter++;
	}
    }

    if ((ctxt != NULL) && (ctxt->sax != NULL)) {
	warning = ctxt->sax->warning;
	ctxt->sax->warning = NULL;
    }

    if (defaultEntityLoader != NULL) {
	ret = defaultEntityLoader(URL, ID, ctxt);
	if (ret != NULL) {
	    if (warning != NULL)
		ctxt->sax->warning = warning;
	    if (load_trace) {
		fprintf \
			(stderr,
			 "Loaded URL=\"%s\" ID=\"%s\"\n",
			 URL ? URL : "(null)",
			 ID ? ID : "(null)");
	    }
	    return(ret);
	}
    }
    for (i = 0;i < nbpaths;i++) {
	xmlChar *newURL;

	newURL = xmlStrdup((const xmlChar *) paths[i]);
	newURL = xmlStrcat(newURL, (const xmlChar *) "/");
	newURL = xmlStrcat(newURL, (const xmlChar *) lastsegment);
	if (newURL != NULL) {
	    if (defaultEntityLoader != NULL)
		ret = defaultEntityLoader((const char *)newURL, ID, ctxt);
	    if (ret != NULL) {
		if (warning != NULL)
		    ctxt->sax->warning = warning;
		if (load_trace) {
		    fprintf \
			(stderr,
			 "Loaded URL=\"%s\" ID=\"%s\"\n",
			 newURL,
			 ID ? ID : "(null)");
		}
		xmlFree(newURL);
		return(ret);
	    }
	    xmlFree(newURL);
	}
    }
    if (warning != NULL) {
	ctxt->sax->warning = warning;
	if (URL != NULL)
	    warning(ctxt, "failed to load external entity \"%s\"\n", URL);
	else if (ID != NULL)
	    warning(ctxt, "failed to load external entity \"%s\"\n", ID);
    }
    return(NULL);
}

/*
 * Internal timing routines to remove the necessity to have unix-specific
 * function calls
 */
#ifndef HAVE_GETTIMEOFDAY
#ifdef HAVE_SYS_TIMEB_H
#ifdef HAVE_SYS_TIME_H
#ifdef HAVE_FTIME

int
my_gettimeofday(struct timeval *tvp, void *tzp)
{
	struct timeb timebuffer;

	ftime(&timebuffer);
	if (tvp) {
		tvp->tv_sec = timebuffer.time;
		tvp->tv_usec = timebuffer.millitm * 1000L;
	}
	return (0);
}
#define HAVE_GETTIMEOFDAY 1
#define gettimeofday my_gettimeofday

#endif /* HAVE_FTIME */
#endif /* HAVE_SYS_TIME_H */
#endif /* HAVE_SYS_TIMEB_H */
#endif /* !HAVE_GETTIMEOFDAY */

static void endTimer(const char *format, ...) LIBXSLT_ATTR_FORMAT(1,2);

#if defined(HAVE_GETTIMEOFDAY)
static struct timeval begin, endtime;
/*
 * startTimer: call where you want to start timing
 */
static void startTimer(void)
{
    gettimeofday(&begin,NULL);
}
/*
 * endTimer: call where you want to stop timing and to print out a
 *           message about the timing performed; format is a printf
 *           type argument
 */
static void endTimer(const char *format, ...)
{
    long msec;
    va_list ap;

    gettimeofday(&endtime, NULL);
    msec = endtime.tv_sec - begin.tv_sec;
    msec *= 1000;
    msec += (endtime.tv_usec - begin.tv_usec) / 1000;

#ifndef HAVE_STDARG_H
#error "endTimer required stdarg functions"
#endif
    va_start(ap, format);
    vfprintf(stderr,format,ap);
    va_end(ap);

    fprintf(stderr, " took %ld ms\n", msec);
}
#elif defined(HAVE_TIME_H)
/*
 * No gettimeofday function, so we have to make do with calling clock.
 * This is obviously less accurate, but there's little we can do about
 * that.
 */
#ifndef CLOCKS_PER_SEC
#define CLOCKS_PER_SEC 100
#endif

clock_t begin, endtime;
static void startTimer(void)
{
    begin=clock();
}
static void endTimer(const char *format, ...)
{
    long msec;
    va_list ap;

    endtime=clock();
    msec = ((endtime-begin) * 1000) / CLOCKS_PER_SEC;

#ifndef HAVE_STDARG_H
#error "endTimer required stdarg functions"
#endif
    va_start(ap, format);
    vfprintf(stderr,format,ap);
    va_end(ap);
    fprintf(stderr, " took %ld ms\n", msec);
}
#else
/*
 * We don't have a gettimeofday or time.h, so we just don't do timing
 */
static void startTimer(void)
{
  /*
   * Do nothing
   */
}
static void endTimer(const char *format, ...)
{
  /*
   * We cannot do anything because we don't have a timing function
   */
#ifdef HAVE_STDARG_H
    va_start(ap, format);
    vfprintf(stderr,format,ap);
    va_end(ap);
    fprintf(stderr, " was not timed\n");
#else
  /* We don't have gettimeofday, time or stdarg.h, what crazy world is
   * this ?!
   */
#endif
}
#endif

/*
 * xsltSubtreeCheck:
 *
 * allow writes only on a subtree specified on the command line
 */
static int
xsltSubtreeCheck(xsltSecurityPrefsPtr sec ATTRIBUTE_UNUSED,
	          xsltTransformContextPtr ctxt ATTRIBUTE_UNUSED,
		  const char *value ATTRIBUTE_UNUSED) {
    int len, ret;

    if (writesubtree == NULL)
	return(0);
    if (value == NULL)
	return(-1);

    len = xmlStrlen(BAD_CAST writesubtree);
    ret = xmlStrncmp(BAD_CAST writesubtree, BAD_CAST value, len);
    if (ret == 0)
	return(1);
    return(0);
}

static void
xsltProcess(xmlDocPtr doc, xsltStylesheetPtr cur, const char *filename) {
    xmlDocPtr res;
    xsltTransformContextPtr ctxt;


#ifdef LIBXML_XINCLUDE_ENABLED
    if (xinclude) {
        int ret;

	if (timing)
	    startTimer();
#if LIBXML_VERSION >= 20603
	ret = xmlXIncludeProcessFlags(doc, XSLT_PARSE_OPTIONS);
#else
	ret = xmlXIncludeProcess(doc);
#endif
	if (timing) {
	    endTimer("XInclude processing %s", filename);
	}

        if (ret < 0) {
	    errorno = 6;
            return;
        }
    }
#endif
    if (timing)
        startTimer();
    if (output == NULL) {
	if (repeat) {
	    int j;

	    for (j = 1; j < repeat; j++) {
		res = xsltApplyStylesheet(cur, doc, params);
		xmlFreeDoc(res);
		xmlFreeDoc(doc);
#ifdef LIBXML_HTML_ENABLED
		if (html)
		    doc = htmlReadFile(filename, encoding, options);
		else
#endif
		    doc = xmlReadFile(filename, encoding, options);
	    }
	}
	ctxt = xsltNewTransformContext(cur, doc);
	if (ctxt == NULL)
	    return;
	xsltSetCtxtParseOptions(ctxt, options);
#ifdef LIBXML_XINCLUDE_ENABLED
	if (xinclude)
	    ctxt->xinclude = 1;
#endif
	if (profile) {
	    res = xsltApplyStylesheetUser(cur, doc, params, NULL,
		                          stderr, ctxt);
	} else {
	    res = xsltApplyStylesheetUser(cur, doc, params, NULL,
		                          NULL, ctxt);
	}
	if (ctxt->state == XSLT_STATE_ERROR)
	    errorno = 9;
	else if (ctxt->state == XSLT_STATE_STOPPED)
	    errorno = 10;
	xsltFreeTransformContext(ctxt);
	if (timing) {
	    if (repeat)
		endTimer("Applying stylesheet %d times", repeat);
	    else
		endTimer("Applying stylesheet");
	}
	xmlFreeDoc(doc);
	if (res == NULL) {
	    fprintf(stderr, "no result for %s\n", filename);
	    return;
	}
	if (noout) {
	    xmlFreeDoc(res);
	    return;
	}
#ifdef LIBXML_DEBUG_ENABLED
	if (debug)
	    xmlDebugDumpDocument(stdout, res);
	else {
#endif
	    if (cur->methodURI == NULL) {
		if (timing)
		    startTimer();
		xsltSaveResultToFile(stdout, res, cur);
		if (timing)
		    endTimer("Saving result");
	    } else {
		if (xmlStrEqual
		    (cur->method, (const xmlChar *) "xhtml")) {
		    fprintf(stderr, "non standard output xhtml\n");
		    if (timing)
			startTimer();
		    xsltSaveResultToFile(stdout, res, cur);
		    if (timing)
			endTimer("Saving result");
		} else {
		    fprintf(stderr,
			    "Unsupported non standard output %s\n",
			    cur->method);
		    errorno = 7;
		}
	    }
#ifdef LIBXML_DEBUG_ENABLED
	}
#endif

	xmlFreeDoc(res);
    } else {
        int ret;
	ctxt = xsltNewTransformContext(cur, doc);
	if (ctxt == NULL)
	    return;
	xsltSetCtxtParseOptions(ctxt, options);
#ifdef LIBXML_XINCLUDE_ENABLED
	if (xinclude)
	    ctxt->xinclude = 1;
#endif
	ctxt->maxTemplateDepth = xsltMaxDepth;
	ctxt->maxTemplateVars = xsltMaxVars;

	if (profile) {
	    ret = xsltRunStylesheetUser(cur, doc, params, output,
		                        NULL, NULL, stderr, ctxt);
	} else {
	    ret = xsltRunStylesheetUser(cur, doc, params, output,
		                        NULL, NULL, NULL, ctxt);
	}
	if (ret == -1)
	    errorno = 11;
	else if (ctxt->state == XSLT_STATE_ERROR)
	    errorno = 9;
	else if (ctxt->state == XSLT_STATE_STOPPED)
	    errorno = 10;
	xsltFreeTransformContext(ctxt);
	if (timing)
	    endTimer("Running stylesheet and saving result");
	xmlFreeDoc(doc);
    }
}

static void usage(const char *name) {
    printf("Usage: %s [options] stylesheet file [file ...]\n", name);
    printf("   Options:\n");
    printf("\t--version or -V: show the version of libxml and libxslt used\n");
    printf("\t--verbose or -v: show logs of what's happening\n");
    printf("\t--output file or -o file: save to a given file\n");
    printf("\t--timing: display the time used\n");
    printf("\t--repeat: run the transformation 20 times\n");
#ifdef LIBXML_DEBUG_ENABLED
    printf("\t--debug: dump the tree of the result instead\n");
#endif
    printf("\t--dumpextensions: dump the registered extension elements and functions to stdout\n");
    printf("\t--novalid skip the DTD loading phase\n");
    printf("\t--nodtdattr do not default attributes from the DTD\n");
    printf("\t--noout: do not dump the result\n");
    printf("\t--maxdepth val : increase the maximum depth (default %d)\n", xsltMaxDepth);
    printf("\t--maxvars val : increase the maximum variables (default %d)\n", xsltMaxVars);
    printf("\t--maxparserdepth val : increase the maximum parser depth\n");
    printf("\t--huge: relax any hardcoded limit from the parser\n");
    printf("\t             fixes \"parser error : internal error: Huge input lookup\"\n");
    printf("\t--seed-rand val : initialize pseudo random number generator with specific seed\n");
#ifdef LIBXML_HTML_ENABLED
    printf("\t--html: the input document is(are) an HTML file(s)\n");
#endif
    printf("\t--encoding: the input document character encoding\n");
    printf("\t--param name value : pass a (parameter,value) pair\n");
    printf("\t       name is a QName or a string of the form {URI}NCName.\n");
    printf("\t       value is an UTF8 XPath expression.\n");
    printf("\t       string values must be quoted like \"'string'\"\n or");
    printf("\t       use stringparam to avoid it\n");
    printf("\t--stringparam name value : pass a (parameter, UTF8 string value) pair\n");
    printf("\t--path 'paths': provide a set of paths for resources\n");
    printf("\t--nonet : refuse to fetch DTDs or entities over network\n");
    printf("\t--nowrite : refuse to write to any file or resource\n");
    printf("\t--nomkdir : refuse to create directories\n");
    printf("\t--writesubtree path : allow file write only with the path subtree\n");
#ifdef LIBXML_CATALOG_ENABLED
    printf("\t--catalogs : use SGML catalogs from $SGML_CATALOG_FILES\n");
    printf("\t             otherwise XML Catalogs starting from \n");
    printf("\t         file:///etc/xml/catalog are activated by default\n");
#endif
#ifdef LIBXML_XINCLUDE_ENABLED
    printf("\t--xinclude : do XInclude processing on document input\n");
    printf("\t--xincludestyle : do XInclude processing on stylesheets\n");
#endif
    printf("\t--load-trace : print trace of all external entites loaded\n");
    printf("\t--profile or --norman : dump profiling information \n");
    printf("\nProject libxslt home page: https://gitlab.gnome.org/GNOME/libxslt\n");
}

int
main(int argc, char **argv)
{
    int i;
    xsltStylesheetPtr cur = NULL;
    xmlDocPtr doc, style;
    xsltSecurityPrefsPtr sec = NULL;

    if (argc <= 1) {
        usage(argv[0]);
        return (1);
    }

    srand(time(NULL));
    xmlInitMemory();

#if defined(_WIN32) && !defined(__CYGINW__)
    setmode(fileno(stdout), O_BINARY);
    setmode(fileno(stderr), O_BINARY);
#endif
#if defined(_MSC_VER) && _MSC_VER < 1900
    _set_output_format(_TWO_DIGIT_EXPONENT);
#endif

    LIBXML_TEST_VERSION

    sec = xsltNewSecurityPrefs();
    xsltSetDefaultSecurityPrefs(sec);
    defaultEntityLoader = xmlGetExternalEntityLoader();
    xmlSetExternalEntityLoader(xsltprocExternalEntityLoader);

    for (i = 1; i < argc; i++) {
        if (!strcmp(argv[i], "-"))
            break;

        if (argv[i][0] != '-')
            continue;
#ifdef LIBXML_DEBUG_ENABLED
        if ((!strcmp(argv[i], "-debug")) || (!strcmp(argv[i], "--debug"))) {
            debug++;
        } else
#endif
        if ((!strcmp(argv[i], "-v")) ||
                (!strcmp(argv[i], "-verbose")) ||
                (!strcmp(argv[i], "--verbose"))) {
            xsltSetGenericDebugFunc(stderr, NULL);
        } else if ((!strcmp(argv[i], "-o")) ||
                   (!strcmp(argv[i], "-output")) ||
                   (!strcmp(argv[i], "--output"))) {
            i++;
#if defined(_WIN32) || defined (__CYGWIN__)
	    output = (char *) xmlCanonicPath((xmlChar *) argv[i]);
            if (output == NULL)
#endif
		output = (char *) xmlStrdup((xmlChar *) argv[i]);
        } else if ((!strcmp(argv[i], "-V")) ||
                   (!strcmp(argv[i], "-version")) ||
                   (!strcmp(argv[i], "--version"))) {
            printf("Using libxml %s, libxslt %s and libexslt %s\n",
                   xmlParserVersion, xsltEngineVersion, exsltLibraryVersion);
            printf
    ("xsltproc was compiled against libxml %d, libxslt %d and libexslt %d\n",
                 LIBXML_VERSION, LIBXSLT_VERSION, LIBEXSLT_VERSION);
            printf("libxslt %d was compiled against libxml %d\n",
                   xsltLibxsltVersion, xsltLibxmlVersion);
            printf("libexslt %d was compiled against libxml %d\n",
                   exsltLibexsltVersion, exsltLibxmlVersion);
        } else if ((!strcmp(argv[i], "-repeat"))
                   || (!strcmp(argv[i], "--repeat"))) {
            if (repeat == 0)
                repeat = 20;
            else
                repeat = 100;
        } else if ((!strcmp(argv[i], "-novalid")) ||
                   (!strcmp(argv[i], "--novalid"))) {
            novalid++;
        } else if ((!strcmp(argv[i], "-nodtdattr")) ||
                   (!strcmp(argv[i], "--nodtdattr"))) {
            nodtdattr++;
        } else if ((!strcmp(argv[i], "-noout")) ||
                   (!strcmp(argv[i], "--noout"))) {
            noout++;
#ifdef LIBXML_HTML_ENABLED
        } else if ((!strcmp(argv[i], "-html")) ||
                   (!strcmp(argv[i], "--html"))) {
            html++;
#endif
	} else if ((!strcmp(argv[i], "-encoding")) ||
		   (!strcmp(argv[i], "--encoding"))) {
	    encoding = argv[++i];
        } else if ((!strcmp(argv[i], "-timing")) ||
                   (!strcmp(argv[i], "--timing"))) {
            timing++;
        } else if ((!strcmp(argv[i], "-profile")) ||
                   (!strcmp(argv[i], "--profile"))) {
            profile++;
        } else if ((!strcmp(argv[i], "-nodict")) ||
                   (!strcmp(argv[i], "--nodict"))) {
            nodict++;
        } else if ((!strcmp(argv[i], "-norman")) ||
                   (!strcmp(argv[i], "--norman"))) {
            profile++;
        } else if ((!strcmp(argv[i], "-nonet")) ||
                   (!strcmp(argv[i], "--nonet"))) {
	    defaultEntityLoader = xmlNoNetExternalEntityLoader;
        } else if ((!strcmp(argv[i], "-nowrite")) ||
                   (!strcmp(argv[i], "--nowrite"))) {
	    xsltSetSecurityPrefs(sec, XSLT_SECPREF_WRITE_FILE,
		                 xsltSecurityForbid);
	    xsltSetSecurityPrefs(sec, XSLT_SECPREF_CREATE_DIRECTORY,
		                 xsltSecurityForbid);
	    xsltSetSecurityPrefs(sec, XSLT_SECPREF_WRITE_NETWORK,
		                 xsltSecurityForbid);
        } else if ((!strcmp(argv[i], "-nomkdir")) ||
                   (!strcmp(argv[i], "--nomkdir"))) {
	    xsltSetSecurityPrefs(sec, XSLT_SECPREF_CREATE_DIRECTORY,
		                 xsltSecurityForbid);
        } else if ((!strcmp(argv[i], "-writesubtree")) ||
                   (!strcmp(argv[i], "--writesubtree"))) {
	    i++;
	    writesubtree = argv[i];
	    xsltSetSecurityPrefs(sec, XSLT_SECPREF_WRITE_FILE,
		                 xsltSubtreeCheck);
        } else if ((!strcmp(argv[i], "-path")) ||
                   (!strcmp(argv[i], "--path"))) {
	    i++;
	    parsePath(BAD_CAST argv[i]);
#ifdef LIBXML_CATALOG_ENABLED
        } else if ((!strcmp(argv[i], "-catalogs")) ||
                   (!strcmp(argv[i], "--catalogs"))) {
            const char *catalogs;

            catalogs = getenv("SGML_CATALOG_FILES");
            if (catalogs == NULL) {
                fprintf(stderr, "Variable $SGML_CATALOG_FILES not set\n");
            } else {
                xmlLoadCatalogs(catalogs);
            }
#endif
#ifdef LIBXML_XINCLUDE_ENABLED
        } else if ((!strcmp(argv[i], "-xinclude")) ||
                   (!strcmp(argv[i], "--xinclude"))) {
            xinclude++;
        } else if ((!strcmp(argv[i], "-xincludestyle")) ||
                   (!strcmp(argv[i], "--xincludestyle"))) {
            xincludestyle++;
            xsltSetXIncludeDefault(1);
#endif
        } else if ((!strcmp(argv[i], "-load-trace")) ||
                   (!strcmp(argv[i], "--load-trace"))) {
            load_trace++;
        } else if ((!strcmp(argv[i], "-param")) ||
                   (!strcmp(argv[i], "--param"))) {
            i++;
            params[nbparams++] = argv[i++];
            params[nbparams++] = argv[i];
            if (nbparams >= MAX_PARAMETERS) {
                fprintf(stderr, "too many params increase MAX_PARAMETERS \n");
                return (2);
            }
        } else if ((!strcmp(argv[i], "-stringparam")) ||
                   (!strcmp(argv[i], "--stringparam"))) {
	    const xmlChar *string;
	    xmlChar *value;

            i++;
            params[nbparams++] = argv[i++];
	    string = (const xmlChar *) argv[i];
	    if (xmlStrchr(string, '"')) {
		if (xmlStrchr(string, '\'')) {
		    fprintf(stderr,
		    "stringparam contains both quote and double-quotes !\n");
		    return(8);
		}
		value = xmlStrdup((const xmlChar *)"'");
		value = xmlStrcat(value, string);
		value = xmlStrcat(value, (const xmlChar *)"'");
	    } else {
		value = xmlStrdup((const xmlChar *)"\"");
		value = xmlStrcat(value, string);
		value = xmlStrcat(value, (const xmlChar *)"\"");
	    }

            params[nbparams++] = (const char *) value;
	    strparams[nbstrparams++] = value;
            if (nbparams >= MAX_PARAMETERS) {
                fprintf(stderr, "too many params increase MAX_PARAMETERS \n");
                return (2);
            }
        } else if ((!strcmp(argv[i], "-maxdepth")) ||
                   (!strcmp(argv[i], "--maxdepth"))) {
            int value;

            i++;
            if (i == argc) {
                fprintf(stderr, "XSLT maxdepth value not specified!\n");
                return (2);
            }

            if (sscanf(argv[i], "%d", &value) == 1) {
                if (value > 0)
                    xsltMaxDepth = value;
            }
        } else if ((!strcmp(argv[i], "-maxvars")) ||
                   (!strcmp(argv[i], "--maxvars"))) {
            int value;

            i++;
            if (sscanf(argv[i], "%d", &value) == 1) {
                if (value > 0)
                    xsltMaxVars = value;
            }
        } else if ((!strcmp(argv[i], "-maxparserdepth")) ||
                   (!strcmp(argv[i], "--maxparserdepth"))) {
            int value;

            i++;
            if (i == argc) {
                fprintf(stderr, "XML maxparserdepth value not specified!\n");
                return (2);
            }

            if (sscanf(argv[i], "%d", &value) == 1) {
                if (value > 0)
                    xmlParserMaxDepth = value;
            }
        } else if ((!strcmp(argv[i], "-huge")) ||
                   (!strcmp(argv[i], "--huge"))) {
            options |= XML_PARSE_HUGE;
        } else if ((!strcmp(argv[i], "-seed-rand")) ||
                   (!strcmp(argv[i], "--seed-rand"))) {
            int value;

            i++;
            if (sscanf(argv[i], "%d", &value) == 1) {
                if (value > 0)
                    srand(value);
            }
        } else if ((!strcmp(argv[i],"-dumpextensions"))||
			(!strcmp(argv[i],"--dumpextensions"))) {
		dumpextensions++;
	} else {
            fprintf(stderr, "Unknown option %s\n", argv[i]);
            usage(argv[0]);
            return (3);
        }
    }
    params[nbparams] = NULL;

    if (novalid != 0)
	options = XML_PARSE_NOENT | XML_PARSE_NOCDATA;
    else if (nodtdattr)
        options = XML_PARSE_NOENT | XML_PARSE_DTDLOAD | XML_PARSE_NOCDATA;
    if (nodict != 0)
        options |= XML_PARSE_NODICT;

    /*
     * Register the EXSLT extensions and the test module
     */
    exsltRegisterAll();
    xsltRegisterTestModule();

    if (dumpextensions)
	xsltDebugDumpExtensions(NULL);

    for (i = 1; i < argc; i++) {
        if ((!strcmp(argv[i], "-maxdepth")) ||
            (!strcmp(argv[i], "--maxdepth"))) {
            i++;
            continue;
        } else if ((!strcmp(argv[i], "-maxvars")) ||
            (!strcmp(argv[i], "--maxvars"))) {
            i++;
            continue;
        } else if ((!strcmp(argv[i], "-maxparserdepth")) ||
            (!strcmp(argv[i], "--maxparserdepth"))) {
            i++;
            continue;
        } else if ((!strcmp(argv[i], "-seed-rand")) ||
            (!strcmp(argv[i], "--seed-rand"))) {
            i++;
            continue;
        } else if ((!strcmp(argv[i], "-o")) ||
                   (!strcmp(argv[i], "-output")) ||
                   (!strcmp(argv[i], "--output"))) {
            i++;
	    continue;
	} else if ((!strcmp(argv[i], "-encoding")) ||
		   (!strcmp(argv[i], "--encoding"))) {
	    i++;
	    continue;
        } else if ((!strcmp(argv[i], "-writesubtree")) ||
                   (!strcmp(argv[i], "--writesubtree"))) {
            i++;
	    continue;
        } else if ((!strcmp(argv[i], "-path")) ||
                   (!strcmp(argv[i], "--path"))) {
            i++;
	    continue;
	}
        if ((!strcmp(argv[i], "-param")) || (!strcmp(argv[i], "--param"))) {
            i += 2;
            continue;
        }
        if ((!strcmp(argv[i], "-stringparam")) ||
            (!strcmp(argv[i], "--stringparam"))) {
            i += 2;
            continue;
        }
        if ((argv[i][0] != '-') || (strcmp(argv[i], "-") == 0)) {
            if (timing)
                startTimer();
	    style = xmlReadFile((const char *) argv[i], NULL, options);
            if (timing)
		endTimer("Parsing stylesheet %s", argv[i]);
#ifdef LIBXML_XINCLUDE_ENABLED
	    if (xincludestyle) {
		if (style != NULL) {
		    if (timing)
			startTimer();
#if LIBXML_VERSION >= 20603
		    xmlXIncludeProcessFlags(style, XSLT_PARSE_OPTIONS);
#else
		    xmlXIncludeProcess(style);
#endif
		    if (timing) {
			endTimer("XInclude processing %s", argv[i]);
		    }
		}
	    }
#endif
	    if (style == NULL) {
		fprintf(stderr,  "cannot parse %s\n", argv[i]);
		cur = NULL;
		errorno = 4;
	    } else {
		cur = xsltLoadStylesheetPI(style);
		if (cur != NULL) {
		    /* it is an embedded stylesheet */
		    xsltProcess(style, cur, argv[i]);
		    xsltFreeStylesheet(cur);
		    cur = NULL;
		    goto done;
		}
		cur = xsltParseStylesheetDoc(style);
		if (cur != NULL) {
		    if (cur->errors != 0) {
			errorno = 5;
			goto done;
		    }
		    i++;
		} else {
		    xmlFreeDoc(style);
		    errorno = 5;
		    goto done;
		}
	    }
            break;

        }
    }


    if ((cur != NULL) && (cur->errors == 0)) {
        for (; i < argc; i++) {
	    doc = NULL;
            if (timing)
                startTimer();
#ifdef LIBXML_HTML_ENABLED
            if (html)
                doc = htmlReadFile(argv[i], encoding, options);
            else
#endif
                doc = xmlReadFile(argv[i], encoding, options);
            if (doc == NULL) {
                fprintf(stderr, "unable to parse %s\n", argv[i]);
		errorno = 6;
                continue;
            }
            if (timing)
		endTimer("Parsing document %s", argv[i]);
	    xsltProcess(doc, cur, argv[i]);
        }
    }
done:
    if (cur != NULL)
        xsltFreeStylesheet(cur);
    for (i = 0;i < nbstrparams;i++)
	xmlFree(strparams[i]);
    if (output != NULL)
	xmlFree(output);
    xsltFreeSecurityPrefs(sec);
    xsltCleanupGlobals();
    xmlCleanupParser();
    xmlMemoryDump();
    return(errorno);
}

