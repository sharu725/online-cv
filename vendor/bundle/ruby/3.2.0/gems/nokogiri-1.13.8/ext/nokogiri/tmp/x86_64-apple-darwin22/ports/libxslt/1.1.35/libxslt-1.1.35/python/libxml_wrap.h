#include <Python.h>
#include <libxml/tree.h>
#include <libxml/parser.h>
#include <libxml/parserInternals.h>
#include <libxml/catalog.h>
#include <libxml/threads.h>
#include <libxml/nanoftp.h>
#include <libxml/nanohttp.h>
#include <libxml/uri.h>
#include <libxml/xpath.h>
#include <libxml/xpathInternals.h>
#include <libxml/debugXML.h>
#include <libxml/HTMLparser.h>
#include <libxml/HTMLtree.h>
#include <libxml/xinclude.h>
#include <libxml/xpointer.h>

/*
 * for older versions of Python, we don't use PyBytes, but keep PyString
 * and don't use Capsule but CObjects
 */
#if PY_VERSION_HEX < 0x02070000
#ifndef PyBytes_Check
#define PyBytes_Check PyString_Check
#define PyBytes_Size PyString_Size
#define PyBytes_AsString PyString_AsString
#define PyBytes_AS_STRING PyString_AS_STRING
#define PyBytes_GET_SIZE PyString_GET_SIZE
#endif
#ifndef PyCapsule_New
#define PyCapsule_New PyCObject_FromVoidPtrAndDesc
#define PyCapsule_CheckExact PyCObject_Check
#define PyCapsule_GetPointer(o, n) PyCObject_GetDesc((o))
#endif
#endif

#define PyxmlNode_Get(v) (((v) == Py_None) ? NULL : \
	(((PyxmlNode_Object *)(v))->obj))

typedef struct {
    PyObject_HEAD
    xmlNodePtr obj;
} PyxmlNode_Object;

#define PyxmlXPathContext_Get(v) (((v) == Py_None) ? NULL : \
	(((PyxmlXPathContext_Object *)(v))->obj))

typedef struct {
    PyObject_HEAD
    xmlXPathContextPtr obj;
} PyxmlXPathContext_Object;

#define PyxmlXPathParserContext_Get(v) (((v) == Py_None) ? NULL : \
	(((PyxmlXPathParserContext_Object *)(v))->obj))

typedef struct {
    PyObject_HEAD
    xmlXPathParserContextPtr obj;
} PyxmlXPathParserContext_Object;

#define PyparserCtxt_Get(v) (((v) == Py_None) ? NULL : \
        (((PyparserCtxt_Object *)(v))->obj))

typedef struct {
    PyObject_HEAD
    xmlParserCtxtPtr obj;
} PyparserCtxt_Object;

#define Pycatalog_Get(v) (((v) == Py_None) ? NULL : \
        (((Pycatalog_Object *)(v))->obj))

typedef struct {
    PyObject_HEAD
    xmlCatalogPtr obj;
} Pycatalog_Object;

#if PY_MAJOR_VERSION >= 3
FILE *libxml_PyFileGet(PyObject *f);
void libxml_PyFileRelease(FILE *f);
#define PyFile_Get(v) (((v) == Py_None) ? NULL : libxml_PyFileGet(v))
#define PyFile_Release(f) libxml_PyFileRelease(f)
#else
#define PyFile_Get(v) (((v) == Py_None) ? NULL : \
	(PyFile_Check(v) ? (PyFile_AsFile(v)) : stdout))
#define PyFile_Release(f)
#endif

PyObject * libxml_intWrap(int val);
PyObject * libxml_longWrap(long val);
PyObject * libxml_xmlCharPtrWrap(xmlChar *str);
PyObject * libxml_constxmlCharPtrWrap(const xmlChar *str);
PyObject * libxml_charPtrWrap(char *str);
PyObject * libxml_constcharPtrWrap(const char *str);
PyObject * libxml_charPtrConstWrap(const char *str);
PyObject * libxml_xmlCharPtrConstWrap(const xmlChar *str);
PyObject * libxml_xmlDocPtrWrap(xmlDocPtr doc);
PyObject * libxml_xmlNodePtrWrap(xmlNodePtr node);
PyObject * libxml_xmlAttrPtrWrap(xmlAttrPtr attr);
PyObject * libxml_xmlNsPtrWrap(xmlNsPtr ns);
PyObject * libxml_xmlAttributePtrWrap(xmlAttributePtr ns);
PyObject * libxml_xmlElementPtrWrap(xmlElementPtr ns);
PyObject * libxml_doubleWrap(double val);
PyObject * libxml_xmlXPathContextPtrWrap(xmlXPathContextPtr ctxt);
PyObject * libxml_xmlParserCtxtPtrWrap(xmlParserCtxtPtr ctxt);
PyObject * libxml_xmlXPathParserContextPtrWrap(xmlXPathParserContextPtr ctxt);
PyObject * libxml_xmlXPathObjectPtrWrap(xmlXPathObjectPtr obj);
PyObject * libxml_xmlCatalogPtrWrap(xmlCatalogPtr obj);
PyObject * libxml_xmlURIPtrWrap(xmlURIPtr uri);
PyObject * libxml_xmlOutputBufferPtrWrap(xmlOutputBufferPtr buffer);
PyObject * libxml_xmlParserInputBufferPtrWrap(xmlParserInputBufferPtr buffer);
PyObject * libxml_xmlRegexpPtrWrap(xmlRegexpPtr regexp);

xmlXPathObjectPtr libxml_xmlXPathObjectPtrConvert(PyObject * obj);
