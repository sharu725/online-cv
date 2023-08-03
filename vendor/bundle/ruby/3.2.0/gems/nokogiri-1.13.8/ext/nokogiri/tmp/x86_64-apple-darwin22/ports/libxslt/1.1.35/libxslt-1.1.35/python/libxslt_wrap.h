#include "libxml_wrap.h"
#include <libxslt/xslt.h>
#include <libxslt/xsltInternals.h>
#include <libxslt/xsltutils.h>
#include <libxslt/attributes.h>
#include <libxslt/documents.h>
#include <libxslt/extensions.h>
#include <libxslt/extra.h>
#include <libxslt/functions.h>
#include <libxslt/imports.h>
#include <libxslt/keys.h>
#include <libxslt/namespaces.h>
#include <libxslt/numbersInternals.h>
#include <libxslt/pattern.h>
#include <libxslt/preproc.h>
#include <libxslt/templates.h>
#include <libxslt/transform.h>
#include <libxslt/variables.h>
#include <libxslt/xsltconfig.h>

#define Pystylesheet_Get(v) (((v) == Py_None) ? NULL : \
        (((Pystylesheet_Object *)(v))->obj))

typedef struct {
    PyObject_HEAD
    xsltStylesheetPtr obj;
} Pystylesheet_Object;

#define PytransformCtxt_Get(v) (((v) == Py_None) ? NULL : \
        (((PytransformCtxt_Object *)(v))->obj))

typedef struct {
    PyObject_HEAD
    xsltTransformContextPtr obj;
} PytransformCtxt_Object;

#define PycompiledStyle_Get(v) (((v) == Py_None) ? NULL : \
        (((PycompiledStyle_Object *)(v))->obj))

typedef struct {
    PyObject_HEAD
    xsltTransformContextPtr obj;
} PycompiledStyle_Object;


PyObject * libxslt_xsltStylesheetPtrWrap(xsltStylesheetPtr ctxt);
PyObject * libxslt_xsltTransformContextPtrWrap(xsltTransformContextPtr ctxt);
PyObject * libxslt_xsltStylePreCompPtrWrap(xsltStylePreCompPtr comp);
PyObject * libxslt_xsltElemPreCompPtrWrap(xsltElemPreCompPtr comp);
