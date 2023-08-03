/*
 * fuzz.c: Fuzz targets for libxslt
 *
 * See Copyright for the status of this software.
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "fuzz.h"

#include <libxml/tree.h>
#include <libxml/parser.h>
#include <libxml/xpath.h>
#include <libxml/xpathInternals.h>
#include <libxslt/extensions.h>
#include <libxslt/functions.h>
#include <libxslt/security.h>
#include <libxslt/transform.h>
#include <libxslt/xslt.h>
#include <libxslt/xsltInternals.h>
#include <libxslt/xsltutils.h>
#include <libexslt/exslt.h>

#if defined(_WIN32)
  #define DIR_SEP '\\'
#else
  #define DIR_SEP '/'
#endif

static xmlDocPtr doc;
static xsltSecurityPrefsPtr sec;
static xsltTransformContextPtr tctxt;
static xmlHashTablePtr saxonExtHash;

static void
xsltFuzzXmlErrorFunc(void *vctxt, const char *msg ATTRIBUTE_UNUSED, ...) {
    xmlParserCtxtPtr ctxt = (xmlParserCtxtPtr) vctxt;
    /*
     * Stopping the parser should be slightly faster and might catch some
     * issues related to recent libxml2 changes.
     */
    xmlStopParser(ctxt);
}

static void
xsltFuzzXsltErrorFunc(void *vctxt ATTRIBUTE_UNUSED,
                      const char *msg ATTRIBUTE_UNUSED, ...) {
}

static void
xsltFuzzInit(void) {
    /* Init libxml2, libxslt and libexslt */
    xmlInitParser();
    xmlXPathInit();
    xsltInit();
    exsltRegisterAll();

    /* Suppress error messages */
    xmlSetGenericErrorFunc(NULL, xsltFuzzXmlErrorFunc);
    xsltSetGenericErrorFunc(NULL, xsltFuzzXsltErrorFunc);

    /* Disallow I/O */
    sec = xsltNewSecurityPrefs();
    xsltSetSecurityPrefs(sec, XSLT_SECPREF_READ_FILE, xsltSecurityForbid);
    xsltSetSecurityPrefs(sec, XSLT_SECPREF_WRITE_FILE, xsltSecurityForbid);
    xsltSetSecurityPrefs(sec, XSLT_SECPREF_CREATE_DIRECTORY, xsltSecurityForbid);
    xsltSetSecurityPrefs(sec, XSLT_SECPREF_READ_NETWORK, xsltSecurityForbid);
    xsltSetSecurityPrefs(sec, XSLT_SECPREF_WRITE_NETWORK, xsltSecurityForbid);
}

static xmlDocPtr
xsltFuzzLoadDoc(const char *argv0, const char *dir, const char *filename) {
    char *path;

    if (dir != NULL) {
        path = malloc(strlen(dir) + 1 + strlen(filename) + 1);
        sprintf(path, "%s/%s", dir, filename);
        doc = xmlReadFile(path, NULL, 0);
        if (doc == NULL)
            fprintf(stderr, "Error: unable to parse file '%s' in '%s'\n",
                    filename, dir);
    } else {
        const char *end;
        size_t dirLen;

        end = strrchr(argv0, DIR_SEP);
        dirLen = (end == NULL) ? 0 : end - argv0 + 1;
        path = malloc(dirLen + strlen(filename) + 1);
        memcpy(path, argv0, dirLen);
        path[dirLen] = '\0';
        strcat(path, filename);
        doc = xmlReadFile(path, NULL, 0);

        if (doc == NULL && dirLen > 0) {
            /* Binary might be in .libs, try parent directory */
            path[dirLen-1] = 0;
            end = strrchr(path, DIR_SEP);
            dirLen = (end == NULL) ? 0 : end - path + 1;
            path[dirLen] = '\0';
            strcat(path, filename);
            doc = xmlReadFile(path, NULL, 0);
        }

        if (doc == NULL)
            fprintf(stderr, "Error: unable to parse file '%s'\n", filename);
    }

    free(path);

    return doc;
}

/* XPath fuzzer
 *
 * This fuzz target parses and evaluates XPath expressions in an (E)XSLT
 * context using a static XML document. It heavily exercises the libxml2
 * XPath engine (xpath.c), a few other parts of libxml2, and most of
 * libexslt.
 *
 * Some EXSLT functions need the transform context to create RVTs for
 * node-sets. A couple of functions also access the stylesheet. The
 * XPath context from the transform context is used to parse and
 * evaluate expressions.
 *
 * All these objects are created once at startup. After fuzzing each input,
 * they're reset as cheaply as possible.
 *
 * TODO
 *
 * - Some expressions can create lots of temporary node sets (RVTs) which
 *   aren't freed until the whole expression was evaluated, leading to
 *   extensive memory usage. Cleaning them up earlier would require
 *   callbacks from the XPath engine, for example after evaluating a
 *   predicate expression, which doesn't seem feasible. Terminating the
 *   evaluation after creating a certain number of RVTs is a simple
 *   workaround.
 * - Register a custom xsl:decimal-format declaration for format-number().
 * - Some functions add strings to the stylesheet or transform context
 *   dictionary, for example via xsltGetQName, requiring a clean up of the
 *   dicts after fuzzing each input. This behavior seems questionable.
 *   Extension functions shouldn't needlessly modify the transform context
 *   or stylesheet.
 * - Register xsl:keys and fuzz the key() function.
 * - Add a few custom func:functions.
 * - Fuzz the document() function with external documents.
 */

int
xsltFuzzXPathInit(int *argc_p ATTRIBUTE_UNUSED, char ***argv_p,
                  const char *dir) {
    const char *xmlFilename = "xpath.xml";
    xsltStylesheetPtr style;
    xmlXPathContextPtr xpctxt;

    xsltFuzzInit();

    /* Load XML document */
    doc = xsltFuzzLoadDoc((*argv_p)[0], dir, xmlFilename);
    if (doc == NULL)
        return -1;

    style = xsltNewStylesheet();
    tctxt = xsltNewTransformContext(style, doc);
    xsltSetCtxtSecurityPrefs(sec, tctxt);

    /*
     * Some extension functions need the current instruction.
     *
     * - format-number() for namespaces.
     * - document() for the base URL.
     * - maybe others?
     *
     * For fuzzing, it's enough to use the source document's root element.
     */
    tctxt->inst = xmlDocGetRootElement(doc);

    saxonExtHash = (xmlHashTablePtr)
        xsltStyleGetExtData(style, SAXON_NAMESPACE);

    /* Set up XPath context */
    xpctxt = tctxt->xpathCtxt;

    /* Resource limits to avoid timeouts and call stack overflows */
    xpctxt->opLimit = 500000;

    /* Test namespaces used in xpath.xml */
    xmlXPathRegisterNs(xpctxt, BAD_CAST "a", BAD_CAST "a");
    xmlXPathRegisterNs(xpctxt, BAD_CAST "b", BAD_CAST "b");
    xmlXPathRegisterNs(xpctxt, BAD_CAST "c", BAD_CAST "c");

    /* EXSLT namespaces */
    xmlXPathRegisterNs(xpctxt, BAD_CAST "crypto", EXSLT_CRYPTO_NAMESPACE);
    xmlXPathRegisterNs(xpctxt, BAD_CAST "date", EXSLT_DATE_NAMESPACE);
    xmlXPathRegisterNs(xpctxt, BAD_CAST "dyn", EXSLT_DYNAMIC_NAMESPACE);
    xmlXPathRegisterNs(xpctxt, BAD_CAST "exsl", EXSLT_COMMON_NAMESPACE);
    xmlXPathRegisterNs(xpctxt, BAD_CAST "math", EXSLT_MATH_NAMESPACE);
    xmlXPathRegisterNs(xpctxt, BAD_CAST "saxon", SAXON_NAMESPACE);
    xmlXPathRegisterNs(xpctxt, BAD_CAST "set", EXSLT_SETS_NAMESPACE);
    xmlXPathRegisterNs(xpctxt, BAD_CAST "str", EXSLT_STRINGS_NAMESPACE);

    /* Register variables */
    xmlXPathRegisterVariable(xpctxt, BAD_CAST "f", xmlXPathNewFloat(-1.5));
    xmlXPathRegisterVariable(xpctxt, BAD_CAST "b", xmlXPathNewBoolean(1));
    xmlXPathRegisterVariable(xpctxt, BAD_CAST "s",
                             xmlXPathNewString(BAD_CAST "var"));
    xmlXPathRegisterVariable(
            xpctxt, BAD_CAST "n",
            xmlXPathEval(BAD_CAST "//node() | /*/*/namespace::*", xpctxt));

    return 0;
}

xmlXPathObjectPtr
xsltFuzzXPath(const char *data, size_t size) {
    xmlXPathContextPtr xpctxt = tctxt->xpathCtxt;
    xmlChar *xpathExpr;

    /* Null-terminate */
    xpathExpr = malloc(size + 1);
    memcpy(xpathExpr, data, size);
    xpathExpr[size] = 0;

    /* Compile and return early if the expression is invalid */
    xmlXPathCompExprPtr compExpr = xmlXPathCtxtCompile(xpctxt, xpathExpr);
    free(xpathExpr);
    if (compExpr == NULL)
        return NULL;

    /* Initialize XPath evaluation context and evaluate */
    xpctxt->node = (xmlNodePtr) doc; /* Maybe test different context nodes? */
    xpctxt->contextSize = 1;
    xpctxt->proximityPosition = 1;
    xpctxt->opCount = 0;
    xmlXPathObjectPtr xpathObj = xmlXPathCompiledEval(compExpr, xpctxt);
    xmlXPathFreeCompExpr(compExpr);

    /* Clean object cache */
    xmlXPathContextSetCache(xpctxt, 0, 0, 0);
    xmlXPathContextSetCache(xpctxt, 1, -1, 0);

    /* Clean dictionaries */
    if (xmlDictSize(tctxt->dict) > 0) {
        xmlDictFree(tctxt->dict);
        xmlDictFree(tctxt->style->dict);
        tctxt->style->dict = xmlDictCreate();
        tctxt->dict = xmlDictCreateSub(tctxt->style->dict);
    }

    /* Clean saxon:expression cache */
    if (xmlHashSize(saxonExtHash) > 0) {
        /* There doesn't seem to be a cheaper way with the public API. */
        xsltShutdownCtxtExts(tctxt);
        xsltInitCtxtExts(tctxt);
        saxonExtHash = (xmlHashTablePtr)
            xsltStyleGetExtData(tctxt->style, SAXON_NAMESPACE);
    }

    return xpathObj;
}

void
xsltFuzzXPathFreeObject(xmlXPathObjectPtr obj) {
    xmlXPathFreeObject(obj);

    /* Some XSLT extension functions create RVTs. */
    xsltFreeRVTs(tctxt);
}

void
xsltFuzzXPathCleanup(void) {
    xsltStylesheetPtr style = tctxt->style;

    xmlXPathRegisteredNsCleanup(tctxt->xpathCtxt);
    xsltFreeSecurityPrefs(sec);
    sec = NULL;
    xsltFreeTransformContext(tctxt);
    tctxt = NULL;
    xsltFreeStylesheet(style);
    style = NULL;
    xmlFreeDoc(doc);
    doc = NULL;
}

/*
 * XSLT fuzzer
 *
 * This is a rather naive fuzz target using a static XML document.
 *
 * TODO
 *
 * - Improve seed corpus
 * - Mutate multiple input documents: source, xsl:import, xsl:include
 * - format-number() with xsl:decimal-format
 * - Better coverage for xsl:key and key() function
 * - EXSLT func:function
 * - xsl:document
 */

int
xsltFuzzXsltInit(int *argc_p ATTRIBUTE_UNUSED, char ***argv_p,
                 const char *dir) {
    const char *xmlFilename = "xslt.xml";

    xsltFuzzInit();

    /* Load XML document */
    doc = xsltFuzzLoadDoc((*argv_p)[0], dir, xmlFilename);
    if (doc == NULL)
        return -1;

    return 0;
}

xmlChar *
xsltFuzzXslt(const char *data, size_t size) {
    xmlDocPtr xsltDoc;
    xmlDocPtr result;
    xmlNodePtr xsltRoot;
    xsltStylesheetPtr sheet;
    xsltTransformContextPtr ctxt;
    xmlChar *ret = NULL;
    int retLen;

    xsltDoc = xmlReadMemory(data, size, NULL, NULL, 0);
    if (xsltDoc == NULL)
        return NULL;
    xsltRoot = xmlDocGetRootElement(xsltDoc);
    xmlNewNs(xsltRoot, EXSLT_COMMON_NAMESPACE, BAD_CAST "exsl");
    xmlNewNs(xsltRoot, EXSLT_COMMON_NAMESPACE, BAD_CAST "exslt");
    xmlNewNs(xsltRoot, EXSLT_CRYPTO_NAMESPACE, BAD_CAST "crypto");
    xmlNewNs(xsltRoot, EXSLT_DATE_NAMESPACE, BAD_CAST "date");
    xmlNewNs(xsltRoot, EXSLT_DYNAMIC_NAMESPACE, BAD_CAST "dyn");
    xmlNewNs(xsltRoot, EXSLT_MATH_NAMESPACE, BAD_CAST "math");
    xmlNewNs(xsltRoot, EXSLT_SETS_NAMESPACE, BAD_CAST "set");
    xmlNewNs(xsltRoot, EXSLT_STRINGS_NAMESPACE, BAD_CAST "str");
    xmlNewNs(xsltRoot, SAXON_NAMESPACE, BAD_CAST "saxon");

    sheet = xsltNewStylesheet();
    if (sheet == NULL) {
        xmlFreeDoc(xsltDoc);
        return NULL;
    }
    sheet->xpathCtxt->opLimit = 100000;
    sheet->xpathCtxt->opCount = 0;
    if (xsltParseStylesheetUser(sheet, xsltDoc) != 0) {
        xsltFreeStylesheet(sheet);
        xmlFreeDoc(xsltDoc);
        return NULL;
    }

    ctxt = xsltNewTransformContext(sheet, doc);
    xsltSetCtxtSecurityPrefs(sec, ctxt);
    ctxt->maxTemplateDepth = 100;
    ctxt->opLimit = 20000;
    ctxt->xpathCtxt->opLimit = 100000;
    ctxt->xpathCtxt->opCount = sheet->xpathCtxt->opCount;

    result = xsltApplyStylesheetUser(sheet, doc, NULL, NULL, NULL, ctxt);
    if (result != NULL)
        xsltSaveResultToString(&ret, &retLen, result, sheet);

    xmlFreeDoc(result);
    xsltFreeTransformContext(ctxt);
    xsltFreeStylesheet(sheet);

    return ret;
}

void
xsltFuzzXsltCleanup(void) {
    xsltFreeSecurityPrefs(sec);
    sec = NULL;
    xmlFreeDoc(doc);
    doc = NULL;
}
