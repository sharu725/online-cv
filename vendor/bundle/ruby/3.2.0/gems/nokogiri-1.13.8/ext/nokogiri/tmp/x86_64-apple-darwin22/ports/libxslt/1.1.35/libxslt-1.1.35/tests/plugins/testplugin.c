/*
 * extensions.c: Implemetation of the extensions support
 *
 * Reference:
 *   http://www.w3.org/TR/1999/REC-xslt-19991116
 *
 * See Copyright for the status of this software.
 *
 * daniel@veillard.com
 */

#include <libxslt/libxslt.h>

#ifdef WITH_MODULES

#include <string.h>
#include <limits.h>

#include <libxml/xmlmemory.h>
#include <libxml/tree.h>
#include <libxml/hash.h>
#include <libxml/xmlerror.h>
#include <libxml/parserInternals.h>
#include <libxml/xpathInternals.h>
#include <libxml/list.h>
#include <libxml/xmlIO.h>
#include <libxslt/xslt.h>
#include <libxslt/xsltInternals.h>
#include <libxslt/xsltutils.h>
#include <libxslt/imports.h>
#include <libxslt/extensions.h>

#define XSLT_TESTPLUGIN_URL "http://xmlsoft.org/xslt/testplugin"

/* make sure init function is exported on win32 */
#if defined(_WIN32)
  #define PLUGINPUBFUN __declspec(dllexport)
#else
  #define PLUGINPUBFUN
#endif

/* include a prototype to make gcc happy */
void
PLUGINPUBFUN xmlsoft_org_xslt_testplugin_init(void);

/************************************************************************
 * 									*
 * 		Test plugin module http://xmlsoft.org/xslt/testplugin			*
 * 									*
 ************************************************************************/

/************************************************************************
 * 									*
 * 		Test of the extension module API			*
 * 									*
 ************************************************************************/

static xmlChar *testData = NULL;
static xmlChar *testStyleData = NULL;

/**
 * xsltExtFunctionTest:
 * @ctxt:  the XPath Parser context
 * @nargs:  the number of arguments
 *
 * function libxslt:test() for testing the extensions support.
 */
static void
xsltExtFunctionTest(xmlXPathParserContextPtr ctxt,
                    int nargs ATTRIBUTE_UNUSED)
{
    xsltTransformContextPtr tctxt;
    void *data = NULL;

    tctxt = xsltXPathGetTransformContext(ctxt);

    if (testData == NULL) {
        xsltGenericDebug(xsltGenericDebugContext,
                         "xsltExtFunctionTest: not initialized,"
                         " calling xsltGetExtData\n");
        data = xsltGetExtData(tctxt, (const xmlChar *) XSLT_TESTPLUGIN_URL);
        if (data == NULL) {
            xsltTransformError(tctxt, NULL, NULL,
                               "xsltExtElementTest: not initialized\n");
            return;
        }
    }
    if (tctxt == NULL) {
        xsltTransformError(xsltXPathGetTransformContext(ctxt), NULL, NULL,
                           "xsltExtFunctionTest: failed to get the transformation context\n");
        return;
    }
    if (data == NULL)
        data = xsltGetExtData(tctxt, (const xmlChar *) XSLT_TESTPLUGIN_URL);
    if (data == NULL) {
        xsltTransformError(xsltXPathGetTransformContext(ctxt), NULL, NULL,
                           "xsltExtFunctionTest: failed to get module data\n");
        return;
    }
    if (data != testData) {
        xsltTransformError(xsltXPathGetTransformContext(ctxt), NULL, NULL,
                           "xsltExtFunctionTest: got wrong module data\n");
        return;
    }
#ifdef WITH_XSLT_DEBUG_FUNCTION
    xsltGenericDebug(xsltGenericDebugContext,
                     "libxslt:test() called with %d args\n", nargs);
#endif
}

/**
 * xsltExtElementPreCompTest:
 * @style:  the stylesheet
 * @inst:  the instruction in the stylesheet
 *
 * Process a libxslt:test node
 */
static xsltElemPreCompPtr
xsltExtElementPreCompTest(xsltStylesheetPtr style, xmlNodePtr inst,
                          xsltTransformFunction function)
{
    xsltElemPreCompPtr ret;

    if (style == NULL) {
        xsltTransformError(NULL, NULL, inst,
                           "xsltExtElementTest: no transformation context\n");
        return (NULL);
    }
    if (testStyleData == NULL) {
        xsltGenericDebug(xsltGenericDebugContext,
                         "xsltExtElementPreCompTest: not initialized,"
                         " calling xsltStyleGetExtData\n");
        xsltStyleGetExtData(style, (const xmlChar *) XSLT_TESTPLUGIN_URL);
        if (testStyleData == NULL) {
            xsltTransformError(NULL, style, inst,
                               "xsltExtElementPreCompTest: not initialized\n");
            if (style != NULL)
                style->errors++;
            return (NULL);
        }
    }
    if (inst == NULL) {
        xsltTransformError(NULL, style, inst,
                           "xsltExtElementPreCompTest: no instruction\n");
        if (style != NULL)
            style->errors++;
        return (NULL);
    }
    ret = xsltNewElemPreComp(style, inst, function);
    return (ret);
}

/**
 * xsltExtElementTest:
 * @ctxt:  an XSLT processing context
 * @node:  The current node
 * @inst:  the instruction in the stylesheet
 * @comp:  precomputed information
 *
 * Process a libxslt:test node
 */
static void
xsltExtElementTest(xsltTransformContextPtr ctxt, xmlNodePtr node,
                   xmlNodePtr inst,
                   xsltElemPreCompPtr comp ATTRIBUTE_UNUSED)
{
    xmlNodePtr commentNode;

    if (testData == NULL) {
        xsltGenericDebug(xsltGenericDebugContext,
                         "xsltExtElementTest: not initialized,"
                         " calling xsltGetExtData\n");
        xsltGetExtData(ctxt, (const xmlChar *) XSLT_TESTPLUGIN_URL);
        if (testData == NULL) {
            xsltTransformError(ctxt, NULL, inst,
                               "xsltExtElementTest: not initialized\n");
            return;
        }
    }
    if (ctxt == NULL) {
        xsltTransformError(ctxt, NULL, inst,
                           "xsltExtElementTest: no transformation context\n");
        return;
    }
    if (node == NULL) {
        xsltTransformError(ctxt, NULL, inst,
                           "xsltExtElementTest: no current node\n");
        return;
    }
    if (inst == NULL) {
        xsltTransformError(ctxt, NULL, inst,
                           "xsltExtElementTest: no instruction\n");
        return;
    }
    if (ctxt->insert == NULL) {
        xsltTransformError(ctxt, NULL, inst,
                           "xsltExtElementTest: no insertion point\n");
        return;
    }
    commentNode = xmlNewComment((const xmlChar *)
                                "libxslt:testplugin element test worked");
    xmlAddChild(ctxt->insert, commentNode);
}

/**
 * xsltExtInitTest:
 * @ctxt:  an XSLT transformation context
 * @URI:  the namespace URI for the extension
 *
 * A function called at initialization time of an XSLT extension module
 *
 * Returns a pointer to the module specific data for this transformation
 */
static void *
xsltExtInitTest(xsltTransformContextPtr ctxt, const xmlChar * URI)
{
    if (testStyleData == NULL) {
        xsltGenericDebug(xsltGenericErrorContext,
                         "xsltExtInitTest: not initialized,"
                         " calling xsltStyleGetExtData\n");
        xsltStyleGetExtData(ctxt->style, URI);
        if (testStyleData == NULL) {
            xsltTransformError(ctxt, NULL, NULL,
                               "xsltExtInitTest: not initialized\n");
            return (NULL);
        }
    }
    if (testData != NULL) {
        xsltTransformError(ctxt, NULL, NULL,
                           "xsltExtInitTest: already initialized\n");
        return (NULL);
    }
    testData = (void *) "test data";
    xsltGenericDebug(xsltGenericDebugContext,
                     "Registered test plugin module : %s\n", URI);
    return (testData);
}


/**
 * xsltExtShutdownTest:
 * @ctxt:  an XSLT transformation context
 * @URI:  the namespace URI for the extension
 * @data:  the data associated to this module
 *
 * A function called at shutdown time of an XSLT extension module
 */
static void
xsltExtShutdownTest(xsltTransformContextPtr ctxt,
                    const xmlChar * URI, void *data)
{
    if (testData == NULL) {
        xsltTransformError(ctxt, NULL, NULL,
                           "xsltExtShutdownTest: not initialized\n");
        return;
    }
    if (data != testData) {
        xsltTransformError(ctxt, NULL, NULL,
                           "xsltExtShutdownTest: wrong data\n");
    }
    testData = NULL;
    xsltGenericDebug(xsltGenericDebugContext,
                     "Unregistered test plugin module : %s\n", URI);
}

/**
 * xsltExtStyleInitTest:
 * @style:  an XSLT stylesheet
 * @URI:  the namespace URI for the extension
 *
 * A function called at initialization time of an XSLT extension module
 *
 * Returns a pointer to the module specific data for this transformation
 */
static void *
xsltExtStyleInitTest(xsltStylesheetPtr style ATTRIBUTE_UNUSED,
                     const xmlChar * URI)
{
    if (testStyleData != NULL) {
        xsltTransformError(NULL, NULL, NULL,
                           "xsltExtInitTest: already initialized\n");
        return (NULL);
    }
    testStyleData = (void *) "test data";
    xsltGenericDebug(xsltGenericDebugContext,
                     "Registered test plugin module : %s\n", URI);
    return (testStyleData);
}


/**
 * xsltExtStyleShutdownTest:
 * @style:  an XSLT stylesheet
 * @URI:  the namespace URI for the extension
 * @data:  the data associated to this module
 *
 * A function called at shutdown time of an XSLT extension module
 */
static void
xsltExtStyleShutdownTest(xsltStylesheetPtr style ATTRIBUTE_UNUSED,
                         const xmlChar * URI, void *data)
{
    if (testStyleData == NULL) {
        xsltGenericError(xsltGenericErrorContext,
                         "xsltExtShutdownTest: not initialized\n");
        return;
    }
    if (data != testStyleData) {
        xsltTransformError(NULL, NULL, NULL,
                           "xsltExtShutdownTest: wrong data\n");
    }
    testStyleData = NULL;
    xsltGenericDebug(xsltGenericDebugContext,
                     "Unregistered test plugin module : %s\n", URI);
}

/**
 * xmlsoft_org_xslt_testplugin_init:
 *
 * Registers the test plugin module
 */

void
PLUGINPUBFUN xmlsoft_org_xslt_testplugin_init(void)
{
    xsltRegisterExtModuleFull((const xmlChar *) XSLT_TESTPLUGIN_URL,
                              xsltExtInitTest, xsltExtShutdownTest,
                              xsltExtStyleInitTest,
                              xsltExtStyleShutdownTest);
    xsltRegisterExtModuleFunction((const xmlChar *) "testplugin",
                                  (const xmlChar *) XSLT_TESTPLUGIN_URL,
                                  xsltExtFunctionTest);
    xsltRegisterExtModuleElement((const xmlChar *) "testplugin",
                                 (const xmlChar *) XSLT_TESTPLUGIN_URL,
                                 xsltExtElementPreCompTest,
                                 xsltExtElementTest);
}

#endif /*WITH_MODULES*/
