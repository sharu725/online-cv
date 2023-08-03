/**
 * testThreads.c: testing of heavilly multithreaded concurrent accesses
 *
 * See Copyright for the status of this software.
 *
 * daniel@veillard.com
 */

/*
 * TODO: extend it to allow giving the stylesheets/input as filenames on the
 *       command line to test specifics, also add exslt
 */

#include "config.h"
#include "libexslt/exslt.h"
#include <stdlib.h>
#include <stdio.h>

#ifndef _REENTRANT
#define _REENTRANT
#endif
#include <libxml/xmlversion.h>

#if defined(LIBXML_THREAD_ENABLED) && defined(HAVE_PTHREAD_H)

#include <libxml/globals.h>
#include <libxml/threads.h>
#include <libxml/parser.h>
#include <libxml/catalog.h>
#include <libxml/xpathInternals.h>
#include <libxslt/xslt.h>
#include <libxslt/xsltInternals.h>
#include <libxslt/transform.h>
#include <libxslt/xsltutils.h>
#include <libxslt/extensions.h>
#include <libexslt/exsltconfig.h>
#include <pthread.h>
#include <string.h>
#if !defined(_MSC_VER)
#include <unistd.h>
#endif
#include <assert.h>

#define	MAX_ARGC	20

static pthread_t tid[MAX_ARGC];

#define EXT_NS BAD_CAST "http://foo.org"
#define EXT_DATA "bar"

const char *stylesheet = "<xsl:stylesheet version='1.0' \
xmlns:xsl='http://www.w3.org/1999/XSL/Transform' \
xmlns:foo='http://foo.org' \
extension-element-prefixes='foo'>\
<xsl:template match='text()'>\
Success <xsl:value-of select='foo:foo()'/>\
</xsl:template>\
</xsl:stylesheet>\
";

int init = 0;

const char *doc = "<doc>Failed</doc>";
const char *expect = "<?xml version=\"1.0\"?>\nSuccess foo\n";

static void fooFunction(xmlXPathParserContextPtr ctxt,
                        int nargs ATTRIBUTE_UNUSED) {
    xmlXPathReturnString(ctxt, xmlStrdup(BAD_CAST "foo"));
}

static
void * registerFooExtensions(ATTRIBUTE_UNUSED xsltTransformContextPtr ctxt,
                             ATTRIBUTE_UNUSED const xmlChar *URI) {
    xsltRegisterExtModuleFunction(BAD_CAST "foo", EXT_NS, fooFunction);
    return((void *)EXT_DATA);
}

static
void shutdownFooExtensions(xsltTransformContextPtr ctxt ATTRIBUTE_UNUSED,
                           const xmlChar *URI, void *data) {
    const char *str = (const char *) data;
    if (!xmlStrEqual(URI, EXT_NS)) {
        fprintf(stderr, "Mismatch in extensions shutdown URI");
    }
    if (!xmlStrEqual(BAD_CAST str, BAD_CAST EXT_DATA)) {
        fprintf(stderr, "Mismatch in extensions shutdown DATA");
    }
}

static void registerFooModule(void) {
    xsltRegisterExtModule(EXT_NS, registerFooExtensions, shutdownFooExtensions);
}

static void *
threadRoutine1(void *data)
{
    xmlDocPtr input;
    xmlDocPtr style;
    xmlDocPtr res;
    xmlChar *result;
    int len;
    xsltStylesheetPtr cur;
    int id = (int)(unsigned long) data;

    input = xmlReadMemory(doc, strlen(doc), "doc.xml", NULL, 0);
    if (input == NULL) {
        fprintf(stderr, "Thread id %d failed to parse input\n", id);
        exit(1);
    }
    style = xmlReadMemory(stylesheet, strlen(stylesheet), "doc.xsl", NULL, 0);
    if (style == NULL) {
        fprintf(stderr, "Thread id %d failed to parse stylesheet\n", id);
        exit(1);
    }
    cur = xsltParseStylesheetDoc(style);
    if (cur == NULL) {
        fprintf(stderr, "Thread id %d failed to compile stylesheet\n", id);
        exit(1);
    }
    res = xsltApplyStylesheet(cur, input, NULL);
    if (res == NULL) {
        fprintf(stderr, "Thread id %d failed to apply stylesheet\n", id);
        exit(1);
    }
    if (xsltSaveResultToString(&result, &len, res, cur) < 0) {
        fprintf(stderr, "Thread id %d failed to output result\n", id);
        exit(1);
    }
    if (!xmlStrEqual(BAD_CAST expect, result)) {
        fprintf(stderr, "Thread id %d output not conform\n", id);
        exit(1);
    }
    xsltFreeStylesheet(cur);
    xmlFreeDoc(input);
    xmlFreeDoc(res);
    xmlFree(result);
    return(0);
}

static void *
threadRoutine2(void *data)
{
    xmlDocPtr input;
    xmlDocPtr res;
    xmlChar *result;
    int len;
    xsltStylesheetPtr cur = (xsltStylesheetPtr) data;

    if (cur == NULL) {
        fprintf(stderr, "Thread failed to get the stylesheet\n");
        exit(1);
    }
    input = xmlReadMemory(doc, strlen(doc), "doc.xml", NULL, 0);
    if (input == NULL) {
        fprintf(stderr, "Thread failed to parse input\n");
        exit(1);
    }
    res = xsltApplyStylesheet(cur, input, NULL);
    if (res == NULL) {
        fprintf(stderr, "Thread failed to apply stylesheet\n");
        exit(1);
    }
    if (xsltSaveResultToString(&result, &len, res, cur) < 0) {
        fprintf(stderr, "Thread failed to output result\n");
        exit(1);
    }
    if (!xmlStrEqual(BAD_CAST expect, result)) {
        fprintf(stderr, "Thread output not conform\n");
        exit(1);
    }
    xmlFreeDoc(input);
    xmlFreeDoc(res);
    xmlFree(result);
    return(0);
}
int
main(void)
{
    unsigned int i, repeat;
    unsigned int num_threads = 8;
    void *results[MAX_ARGC];
    int ret;

    xmlInitParser();

    /*
     * Register the EXSLT extensions and the test module
     */
    exsltRegisterAll();
    xsltRegisterTestModule();

    /*
     * Register our own extension module
     */
    registerFooModule();

    /*
     * First pass each thread has its own version of the stylesheet
     * each of them will initialize and shutdown the extension
     */
    printf("Pass 1\n");
    for (repeat = 0;repeat < 500;repeat++) {
        memset(results, 0, sizeof(*results)*num_threads);
        memset(tid, 0xff, sizeof(*tid)*num_threads);

	for (i = 0; i < num_threads; i++) {
	    ret = pthread_create(&tid[i], NULL, threadRoutine1,
                                 (void *) (unsigned long) i);
	    if (ret != 0) {
		perror("pthread_create");
		exit(1);
	    }
	}
	for (i = 0; i < num_threads; i++) {
	    ret = pthread_join(tid[i], &results[i]);
	    if (ret != 0) {
		perror("pthread_join");
		exit(1);
	    }
	}
    }

    /*
     * Second pass all threads share the same stylesheet instance
     * look for transformation clashes
     */
    printf("Pass 2\n");
    for (repeat = 0;repeat < 500;repeat++) {
        xmlDocPtr style;
        xsltStylesheetPtr cur;

        style = xmlReadMemory(stylesheet, strlen(stylesheet), "doc.xsl",
                               NULL, 0);
        if (style == NULL) {
            fprintf(stderr, "Main failed to parse stylesheet\n");
            exit(1);
        }
        cur = xsltParseStylesheetDoc(style);
        if (cur == NULL) {
            fprintf(stderr, "Main failed to compile stylesheet\n");
            exit(1);
        }
        memset(results, 0, sizeof(*results)*num_threads);
        memset(tid, 0xff, sizeof(*tid)*num_threads);

	for (i = 0; i < num_threads; i++) {
	    ret = pthread_create(&tid[i], NULL, threadRoutine2, (void *) cur);
	    if (ret != 0) {
		perror("pthread_create");
		exit(1);
	    }
	}
	for (i = 0; i < num_threads; i++) {
	    ret = pthread_join(tid[i], &results[i]);
	    if (ret != 0) {
		perror("pthread_join");
		exit(1);
	    }
	}
        xsltFreeStylesheet(cur);
    }
    xsltCleanupGlobals();
    xmlCleanupParser();
    xmlMemoryDump();
    printf("Ok\n");
    return (0);
}
#else /* !LIBXML_THREADS_ENABLED | !HAVE_PTHREAD_H */
int
main(void)
{
    fprintf(stderr, "libxml was not compiled with thread\n");
    return (0);
}
#endif
