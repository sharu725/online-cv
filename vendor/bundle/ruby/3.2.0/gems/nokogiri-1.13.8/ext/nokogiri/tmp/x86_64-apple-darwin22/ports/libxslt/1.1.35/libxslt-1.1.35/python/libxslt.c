/*
  libxslt.c: this module implements the main part of the glue of the
 *           libxslt library and the Python interpreter. It provides the
 *           entry points where an automatically generated stub is either
 *           unpractical or would not match cleanly the Python model.
 *
 * If compiled with MERGED_MODULES, the entry point will be used to
 * initialize both the libxml2 and the libxslt wrappers
 *
 * See Copyright for the status of this software.
 *
 * daniel@veillard.com
 */
#include <Python.h>
/* #include "config.h" */
#include <libxml/xmlmemory.h>
#include <libxml/tree.h>
#include <libxml/xpath.h>
#include "libexslt/exslt.h"
#include "libxslt_wrap.h"
#include "libxslt-py.h"

#include <stdio.h>
#include <stddef.h>

#ifdef _MSC_VER

/* snprintf emulation taken from http://stackoverflow.com/a/8712996/1956010 */
#if _MSC_VER < 1900

#include <stdarg.h>

#define vsnprintf c99_vsnprintf

__inline int c99_vsnprintf(char *outBuf, size_t size, const char *format, va_list ap)
{
    int count = -1;

    if (size != 0)
        count = _vsnprintf_s(outBuf, size, _TRUNCATE, format, ap);
    if (count == -1)
        count = _vscprintf(format, ap);

    return count;
}

#endif /* _MSC_VER < 1900 */

#elif defined(XSLT_NEED_TRIO)
#include "trio.h"
#define vsnprintf trio_vsnprintf
#endif

/* #define DEBUG */
/* #define DEBUG_XPATH */
/* #define DEBUG_ERROR */
/* #define DEBUG_MEMORY */
/* #define DEBUG_EXTENSIONS */
/* #define DEBUG_EXTENSIONS */

void initlibxsltmod(void);

/************************************************************************
 *									*
 *			Per type specific glue				*
 *									*
 ************************************************************************/

PyObject *
libxslt_xsltStylesheetPtrWrap(xsltStylesheetPtr style) {
    PyObject *ret;

#ifdef DEBUG
    printf("libxslt_xsltStylesheetPtrWrap: style = %p\n", style);
#endif
    if (style == NULL) {
	Py_INCREF(Py_None);
	return(Py_None);
    }
    ret = PyCapsule_New((void *) style, (char *)"xsltStylesheetPtr", NULL);

    return(ret);
}

PyObject *
libxslt_xsltTransformContextPtrWrap(xsltTransformContextPtr ctxt) {
    PyObject *ret;

#ifdef DEBUG
    printf("libxslt_xsltTransformContextPtrWrap: ctxt = %p\n", ctxt);
#endif
    if (ctxt == NULL) {
	Py_INCREF(Py_None);
	return(Py_None);
    }
    ret = PyCapsule_New((void *) ctxt, (char *)"xsltTransformContextPtr",
                        NULL);
    return(ret);
}

PyObject *
libxslt_xsltElemPreCompPtrWrap(xsltElemPreCompPtr ctxt) {
    PyObject *ret;

#ifdef DEBUG
    printf("libxslt_xsltElemPreCompPtrWrap: ctxt = %p\n", ctxt);
#endif
    if (ctxt == NULL) {
	Py_INCREF(Py_None);
	return(Py_None);
    }
    ret = PyCapsule_New((void *) ctxt, (char *)"xsltElemPreCompPtr", NULL);
    return(ret);
}

PyObject *
libxslt_xsltGetTransformContextHashCode(PyObject *self ATTRIBUTE_UNUSED, PyObject *args) {
    PyObject *py_tctxt;
    PyObject *ret;
    long hash_code;
    xsltTransformContextPtr tctxt;

    if (!PyArg_ParseTuple(args, (char *)"O:getTransformContextHashCode",
                          &py_tctxt))
        return NULL;

    tctxt =  (xsltTransformContextPtr) PytransformCtxt_Get(py_tctxt);
    hash_code = (ptrdiff_t) tctxt;

    ret = PyLong_FromLong(hash_code);
    return ret;
}

PyObject *
libxslt_xsltCompareTransformContextsEqual(PyObject *self ATTRIBUTE_UNUSED, PyObject *args) {

    PyObject *py_tctxt1, *py_tctxt2;
    xsltTransformContextPtr tctxt1, tctxt2;

    if (!PyArg_ParseTuple(args, (char *)"OO:compareTransformContextsEqual",
                          &py_tctxt1, &py_tctxt2))
        return NULL;

    tctxt1 = (xsltTransformContextPtr) PytransformCtxt_Get(py_tctxt1);
    tctxt2 = (xsltTransformContextPtr) PytransformCtxt_Get(py_tctxt2);

    if ( tctxt1 == tctxt2 )
        return Py_BuildValue((char *)"i", 1);
    else
        return Py_BuildValue((char *)"i", 0);
}

PyObject *
libxslt_xsltGetStylesheetHashCode(PyObject *self ATTRIBUTE_UNUSED, PyObject *args) {
    PyObject *py_style;
    PyObject *ret;
    long hash_code;
    xsltStylesheetPtr style;

    if (!PyArg_ParseTuple(args, (char *)"O:getStylesheetHashCode",
                          &py_style))
        return NULL;

    style =  (xsltStylesheetPtr) Pystylesheet_Get(py_style);
    hash_code = (ptrdiff_t) style;

    ret = PyLong_FromLong(hash_code);
    return ret;
}


PyObject *
libxslt_xsltCompareStylesheetsEqual(PyObject *self ATTRIBUTE_UNUSED, PyObject *args) {

    PyObject *py_style1, *py_style2;
    xsltStylesheetPtr style1, style2;

    if (!PyArg_ParseTuple(args, (char *)"OO:compareStylesheetsEqual",
                          &py_style1, &py_style2))
        return NULL;

    style1 = (xsltStylesheetPtr) Pystylesheet_Get(py_style1);
    style2 = (xsltStylesheetPtr) Pystylesheet_Get(py_style2);

    if ( style1 == style2 )
        return Py_BuildValue((char *)"i", 1);
    else
        return Py_BuildValue((char *)"i", 0);
}

/************************************************************************
 *									*
 *			Extending the API				*
 *									*
 ************************************************************************/

static xmlHashTablePtr libxslt_extModuleFunctions = NULL;
static xmlHashTablePtr libxslt_extModuleElements = NULL;
static xmlHashTablePtr libxslt_extModuleElementPreComp = NULL;

static void
deallocateCallback(void *payload, const xmlChar *name ATTRIBUTE_UNUSED) {
    PyObject *function = (PyObject *) payload;

#ifdef DEBUG_EXTENSIONS
    printf("deallocateCallback(%s) called\n", name);
#endif

    Py_XDECREF(function);
}

static void
deallocateClasse(void *payload, const xmlChar *name ATTRIBUTE_UNUSED) {
    PyObject *class = (PyObject *) payload;

#ifdef DEBUG_EXTENSIONS
    printf("deallocateClasse(%s) called\n", name);
#endif

    Py_XDECREF(class);
}


/**
 * libxslt_xsltElementPreCompCallback
 * @style:  the stylesheet
 * @inst:  the instruction in the stylesheet
 *
 * Callback for preprocessing of a custom element
 */
static xsltElemPreCompPtr
libxslt_xsltElementPreCompCallback(xsltStylesheetPtr style, xmlNodePtr inst,
              xsltTransformFunction function) {
    xsltElemPreCompPtr ret;
    const xmlChar *name;
    PyObject *args;
    PyObject *result;
    PyObject *pyobj_element_f;
    PyObject *pyobj_precomp_f;

   const xmlChar *ns_uri;


#ifdef DEBUG_EXTENSIONS
    printf("libxslt_xsltElementPreCompCallback called\n");
#endif

    if (style == NULL) {
	xsltTransformError(NULL, NULL, inst,
	     "libxslt_xsltElementPreCompCallback: no transformation context\n");
	    return (NULL);
    }

    if (inst == NULL) {
	xsltTransformError(NULL, style, inst,
	     "libxslt_xsltElementPreCompCallback: no instruction\n");
	if (style != NULL) style->errors++;
	return (NULL);
    }

    if (style == NULL)
	return (NULL);

    if (inst != NULL && inst->ns != NULL) {
	name = inst->name;
	ns_uri = inst->ns->href;
    } else {
	xsltTransformError(NULL, style, inst,
		"libxslt_xsltElementPreCompCallback: internal error bad parameter\n");
		printf("libxslt_xsltElementPreCompCallback: internal error bad parameter\n");
	if (style != NULL) style->errors++;
	return (NULL);
    }

    /*
     * Find the functions, they should be there it was there at lookup
     */
    pyobj_precomp_f = xmlHashLookup2(libxslt_extModuleElementPreComp,
	                              name, ns_uri);
    if (pyobj_precomp_f == NULL) {
	xsltTransformError(NULL, style, inst,
		"libxslt_xsltElementPreCompCallback: internal error, could not find precompile python function!\n");
	if (style != NULL) style->errors++;
	return (NULL);
    }

    pyobj_element_f = xmlHashLookup2(libxslt_extModuleElements,
	                              name, ns_uri);
    if (pyobj_element_f == NULL) {
	xsltTransformError(NULL, style, inst,
		"libxslt_xsltElementPreCompCallback: internal error, could not find element python function!\n");
	if (style != NULL) style->errors++;
	return (NULL);
    }

    args = Py_BuildValue((char *)"(OOO)",
	    libxslt_xsltStylesheetPtrWrap(style),
	    libxml_xmlNodePtrWrap(inst),
	    pyobj_element_f);

    Py_INCREF(pyobj_precomp_f); /* Protect refcount against reentrant manipulation of callback hash */
    result = PyEval_CallObject(pyobj_precomp_f, args);
    Py_DECREF(pyobj_precomp_f);
    Py_DECREF(args);

    /* FIXME allow callbacks to return meaningful information to modify compile process */
    /* If error, do we need to check the result and throw exception? */

    Py_XDECREF(result);

    ret = xsltNewElemPreComp (style, inst, function);
    return (ret);
}


static void
libxslt_xsltElementTransformCallback(xsltTransformContextPtr ctxt,
				    xmlNodePtr node,
				    xmlNodePtr inst,
				    xsltElemPreCompPtr comp)
{
    PyObject *args, *result;
    PyObject *func = NULL;
    const xmlChar *name;
    const xmlChar *ns_uri;

    if (ctxt == NULL)
	return;

    if (inst != NULL && inst->name != NULL && inst->ns != NULL && inst->ns->href != NULL) {
	name = inst->name;
	ns_uri = inst->ns->href;
    } else {
	printf("libxslt_xsltElementTransformCallback: internal error bad parameter\n");
	return;
    }

#ifdef DEBUG_EXTENSIONS
    printf("libxslt_xsltElementTransformCallback called name %s URI %s\n", name, ns_uri);
#endif

    /*
     * Find the function, it should be there it was there at lookup
     */
    func = xmlHashLookup2(libxslt_extModuleElements,
	                              name, ns_uri);
    if (func == NULL) {
	printf("libxslt_xsltElementTransformCallback: internal error %s not found !\n",
	       name);
	return;
    }

    args = Py_BuildValue((char *)"OOOO",
	libxslt_xsltTransformContextPtrWrap(ctxt),
	libxml_xmlNodePtrWrap(node),
	libxml_xmlNodePtrWrap(inst),
	libxslt_xsltElemPreCompPtrWrap(comp));

    Py_INCREF(func); /* Protect refcount against reentrant manipulation of callback hash */
    result = PyEval_CallObject(func, args);
    Py_DECREF(func);
    Py_DECREF(args);

    /* FIXME Check result of callobject and set exception if fail */

    Py_XDECREF(result);
}

PyObject *
libxslt_xsltRegisterExtModuleElement(PyObject *self ATTRIBUTE_UNUSED,
	                              PyObject *args) {
    PyObject *py_retval;
    int ret = 0;
    xmlChar *name;
    xmlChar *ns_uri;
    PyObject *pyobj_element_f;
    PyObject *pyobj_precomp_f;

    if (!PyArg_ParseTuple(args, (char *)"szOO:registerExtModuleElement",
		          &name, &ns_uri, &pyobj_precomp_f, &pyobj_element_f))
        return(NULL);

#ifdef DEBUG_EXTENSIONS
    printf("libxslt_xsltRegisterExtModuleElement called: %s %s\n",
	   name, ns_uri);
#endif

    if ((name == NULL) || (pyobj_element_f == NULL) || (pyobj_precomp_f == NULL)) {
	py_retval = libxml_intWrap(-1);
	return(py_retval);
    }

#ifdef DEBUG_EXTENSIONS
    printf("libxslt_xsltRegisterExtModuleElement(%s, %s) called\n",
	   name, ns_uri);
#endif

    if (libxslt_extModuleElements == NULL)
	libxslt_extModuleElements = xmlHashCreate(10);

    if (libxslt_extModuleElementPreComp == NULL)
	libxslt_extModuleElementPreComp = xmlHashCreate(10);

    if (libxslt_extModuleElements == NULL || libxslt_extModuleElementPreComp == NULL) {
	py_retval = libxml_intWrap(-1);
	return(py_retval);
    }

    ret = xmlHashAddEntry2(libxslt_extModuleElements, name, ns_uri, pyobj_element_f);
    if (ret != 0) {
	py_retval = libxml_intWrap(-1);
	return(py_retval);
    }
    Py_XINCREF(pyobj_element_f);

    ret = xmlHashAddEntry2(libxslt_extModuleElementPreComp, name, ns_uri, pyobj_precomp_f);
    if (ret != 0) {
	xmlHashRemoveEntry2(libxslt_extModuleElements, name, ns_uri, deallocateCallback);
	py_retval = libxml_intWrap(-1);
	return(py_retval);
    }
    Py_XINCREF(pyobj_precomp_f);

    ret = xsltRegisterExtModuleElement(name, ns_uri,
					libxslt_xsltElementPreCompCallback,
					libxslt_xsltElementTransformCallback);
    py_retval = libxml_intWrap((int) ret);
    return(py_retval);
}
static void
libxslt_xmlXPathFuncCallback(xmlXPathParserContextPtr ctxt, int nargs) {
    PyObject *list, *cur, *result;
    xmlXPathObjectPtr obj;
    xmlXPathContextPtr rctxt;
    PyObject *current_function = NULL;
    const xmlChar *name;
    const xmlChar *ns_uri;
    int i;

    if (ctxt == NULL)
	return;
    rctxt = ctxt->context;
    if (rctxt == NULL)
	return;
    name = rctxt->function;
    ns_uri = rctxt->functionURI;
#ifdef DEBUG_XPATH
    printf("libxslt_xmlXPathFuncCallback called name %s URI %s\n", name, ns_uri);
#endif

    /*
     * Find the function, it should be there it was there at lookup
     */
    current_function = xmlHashLookup2(libxslt_extModuleFunctions,
	                              name, ns_uri);
    if (current_function == NULL) {
	printf("libxslt_xmlXPathFuncCallback: internal error %s not found !\n",
	       name);
	return;
    }

    list = PyTuple_New(nargs + 1);
    PyTuple_SetItem(list, 0, libxml_xmlXPathParserContextPtrWrap(ctxt));
    for (i = nargs - 1;i >= 0;i--) {
	obj = valuePop(ctxt);
	cur = libxml_xmlXPathObjectPtrWrap(obj);
	PyTuple_SetItem(list, i + 1, cur);
    }

    Py_INCREF(current_function);
    result = PyEval_CallObject(current_function, list);
    Py_DECREF(current_function);
    Py_DECREF(list);

    /* Check for null in case of exception */
    if (result != NULL) {
	obj = libxml_xmlXPathObjectPtrConvert(result);
	valuePush(ctxt, obj);
    }
}

PyObject *
libxslt_xsltRegisterExtModuleFunction(PyObject *self ATTRIBUTE_UNUSED,
	                              PyObject *args) {
    PyObject *py_retval;
    int ret = 0;
    xmlChar *name;
    xmlChar *ns_uri;
    PyObject *pyobj_f;

    if (!PyArg_ParseTuple(args, (char *)"szO:registerExtModuleFunction",
		          &name, &ns_uri, &pyobj_f))
        return(NULL);

    if ((name == NULL) || (pyobj_f == NULL)) {
	py_retval = libxml_intWrap(-1);
	return(py_retval);
    }

#ifdef DEBUG_XPATH
    printf("libxslt_xsltRegisterExtModuleFunction(%s, %s) called\n",
	   name, ns_uri);
#endif

    if (libxslt_extModuleFunctions == NULL)
	libxslt_extModuleFunctions = xmlHashCreate(10);
    if (libxslt_extModuleFunctions == NULL) {
	py_retval = libxml_intWrap(-1);
	return(py_retval);
    }
    ret = xmlHashAddEntry2(libxslt_extModuleFunctions, name, ns_uri, pyobj_f);
    if (ret != 0) {
	py_retval = libxml_intWrap(-1);
	return(py_retval);
    }
    Py_XINCREF(pyobj_f);

    ret = xsltRegisterExtModuleFunction(name, ns_uri,
	                                     libxslt_xmlXPathFuncCallback);
    py_retval = libxml_intWrap((int) ret);
    return(py_retval);
}


/************************************************************************
 *									*
 *			Document loading front-ends			*
 *									*
 ************************************************************************/

static PyObject *pythonDocLoaderObject = NULL;

static xmlDocPtr
pythonDocLoaderFuncWrapper(const xmlChar * URI, xmlDictPtr dict, int options,
                           void *ctxt ATTRIBUTE_UNUSED,
                           xsltLoadType type ATTRIBUTE_UNUSED)
{
    xmlParserCtxtPtr pctxt;
    xmlDocPtr doc=NULL;

    pctxt = xmlNewParserCtxt();
    if (pctxt == NULL)
        return(NULL);
    if ((dict != NULL) && (pctxt->dict != NULL)) {
        xmlDictFree(pctxt->dict);
	pctxt->dict = NULL;
    }
    if (dict != NULL) {
	pctxt->dict = dict;
	xmlDictReference(pctxt->dict);
#ifdef WITH_XSLT_DEBUG
	xsltGenericDebug(xsltGenericDebugContext,
                     "Reusing dictionary for document\n");
#endif
    }
    xmlCtxtUseOptions(pctxt, options);

    /*
     * Now pass to python the URI, the xsltParserContext and the context
     * (either a transformContext or a stylesheet) and get back an xmlDocPtr
     */
    if (pythonDocLoaderObject != NULL) {
        PyObject *ctxtobj, *pctxtobj, *result;
        pctxtobj = libxml_xmlParserCtxtPtrWrap(pctxt);

        if (type == XSLT_LOAD_DOCUMENT) {
          ctxtobj = libxslt_xsltTransformContextPtrWrap(ctxt);
          result = PyObject_CallFunction(pythonDocLoaderObject,
                                         (char *) "(sOOi)", URI, pctxtobj, ctxtobj, 0);
        }
        else {
          ctxtobj = libxslt_xsltStylesheetPtrWrap(ctxt);
          result = PyObject_CallFunction(pythonDocLoaderObject,
                                         (char *) "(sOOi)", URI, pctxtobj, ctxtobj, 1);
        }

	Py_XDECREF(pctxtobj);

        if (result != NULL) {
            /*
	     * The return value should be the document
             * Should we test it somehow before getting the C object from it?
	     */
            PyObject *py_doc = PyObject_GetAttrString(result, (char *) "_o");
            doc = (xmlDocPtr) PyxmlNode_Get(py_doc);
            /* do we have to DECCREF the result?? */
        }
    }

    if (! pctxt->wellFormed) {
        if (doc != NULL) {
            xmlFreeDoc(doc);
	    doc = NULL;
        }
        if (pctxt->myDoc != NULL) {
            xmlFreeDoc(pctxt->myDoc);
            pctxt->myDoc = NULL;
        }
    }
    /*
     * xmlFreeParserCtxt(pctxt);
     * libc complains about double free-ing with this line
     */

    return(doc);
}


PyObject *
libxslt_xsltSetLoaderFunc(PyObject *self ATTRIBUTE_UNUSED, PyObject *args) {
    PyObject *py_retval;
    PyObject *loader;

    if (!PyArg_ParseTuple(args, (char *)"O:libxslt_xsltSetLoaderFunc",
		&loader))
	return(NULL);

    pythonDocLoaderObject = loader;
    xsltSetLoaderFunc(pythonDocLoaderFuncWrapper);

    py_retval = PyLong_FromLong(0);
    return(py_retval);
}

PyObject *
libxslt_xsltGetLoaderFunc(void) {
    PyObject *py_retval;

    py_retval = pythonDocLoaderObject;
    return(py_retval);
}


/************************************************************************
 *									*
 *			Some customized front-ends			*
 *									*
 ************************************************************************/

PyObject *
libxslt_xsltNewTransformContext(PyObject *self ATTRIBUTE_UNUSED, PyObject *args) {
    PyObject *py_retval;
    PyObject *pyobj_style;
    PyObject *pyobj_doc;
    xsltStylesheetPtr style;
    xmlDocPtr doc;
    xsltTransformContextPtr c_retval;

    if (!PyArg_ParseTuple(args, (char *) "OO:xsltNewTransformContext",
		          &pyobj_style, &pyobj_doc))
        return(NULL);

    style = (xsltStylesheetPtr) Pystylesheet_Get(pyobj_style);
    doc = (xmlDocPtr) PyxmlNode_Get(pyobj_doc);

    c_retval = xsltNewTransformContext(style, doc);
    py_retval = libxslt_xsltTransformContextPtrWrap((xsltTransformContextPtr) c_retval);
    return (py_retval);
}

PyObject *
libxslt_xsltFreeTransformContext(PyObject *self ATTRIBUTE_UNUSED, PyObject *args) {
    PyObject *py_tctxt;
    xsltTransformContextPtr tctxt;

    if (!PyArg_ParseTuple(args, (char *) "O:xsltFreeTransformContext", &py_tctxt))
        return(NULL);

    tctxt = (xsltTransformContextPtr) PytransformCtxt_Get(py_tctxt);
    xsltFreeTransformContext(tctxt);

    /* Return None */
    Py_INCREF(Py_None);
    return(Py_None);
}

PyObject *
libxslt_xsltApplyStylesheetUser(PyObject *self ATTRIBUTE_UNUSED, PyObject *args) {
    PyObject *py_retval;
    xmlDocPtr c_retval;
    xsltStylesheetPtr style;
    PyObject *pyobj_style;
    xmlDocPtr doc;
    xsltTransformContextPtr transformCtxt;
    PyObject *pyobj_doc;
    PyObject *pyobj_params;
    PyObject *pyobj_transformCtxt;
    const char **params = NULL;
    int len = 0, i, j;
    ssize_t ppos = 0;
    PyObject *name;
    PyObject *value;

    if (!PyArg_ParseTuple(args, (char *) "OOOO:xsltApplyStylesheetUser",
		          &pyobj_style, &pyobj_doc, &pyobj_params, &pyobj_transformCtxt))
        return(NULL);

    if (pyobj_params != Py_None) {
	if (PyDict_Check(pyobj_params)) {
	    len = PyDict_Size(pyobj_params);
	    if (len > 0) {
		params = (const char **) xmlMalloc((len + 1) * 2 *
			                           sizeof(char *));
		if (params == NULL) {
		    printf("libxslt_xsltApplyStylesheet: out of memory\n");
		    Py_INCREF(Py_None);
		    return(Py_None);
		}
		j = 0;
		while (PyDict_Next(pyobj_params, &ppos, &name, &value)) {
		    const char *tmp;

#if PY_MAJOR_VERSION >= 3
		    Py_ssize_t size;

		    tmp = PyUnicode_AsUTF8AndSize(name, &size);
#else
                    int size;

		    tmp = PyString_AS_STRING(name);
		    size = PyString_GET_SIZE(name);
#endif
		    params[j * 2] = (char *) xmlCharStrndup(tmp, size);

#if PY_MAJOR_VERSION >= 3
		    if (PyUnicode_Check(value)) {
			tmp = PyUnicode_AsUTF8AndSize(value, &size);
#else
		    if (PyString_Check(value)) {
			tmp = PyString_AS_STRING(value);
			size = PyString_GET_SIZE(value);
#endif
			params[(j * 2) + 1] = (char *)
			    xmlCharStrndup(tmp, size);
		    } else {
			params[(j * 2) + 1] = NULL;
		    }
		    j = j + 1;
		}
		params[j * 2] = NULL;
		params[(j * 2) + 1] = NULL;
	    }
	} else {
	    printf("libxslt_xsltApplyStylesheet: parameters not a dict\n");
	    Py_INCREF(Py_None);
	    return(Py_None);
	}
    }
    style = (xsltStylesheetPtr) Pystylesheet_Get(pyobj_style);
    doc = (xmlDocPtr) PyxmlNode_Get(pyobj_doc);
    transformCtxt = (xsltTransformContextPtr) PytransformCtxt_Get(pyobj_transformCtxt);

    c_retval = xsltApplyStylesheetUser(style, doc, params, NULL, NULL, transformCtxt);
    py_retval = libxml_xmlDocPtrWrap((xmlDocPtr) c_retval);
    if (params != NULL) {
	if (len > 0) {
	    for (i = 0;i < 2 * len;i++) {
		if (params[i] != NULL)
		    xmlFree((char *)params[i]);
	    }
	    xmlFree(params);
	}
    }
    return(py_retval);
}

PyObject *
libxslt_xsltApplyStylesheet(PyObject *self ATTRIBUTE_UNUSED, PyObject *args) {
    PyObject *py_retval;
    xmlDocPtr c_retval;
    xsltStylesheetPtr style;
    PyObject *pyobj_style;
    xmlDocPtr doc;
    PyObject *pyobj_doc;
    PyObject *pyobj_params;
    const char **params = NULL;
    int len = 0, i, j, params_size;
    ssize_t ppos = 0;
    PyObject *name;
    PyObject *value;

    if (!PyArg_ParseTuple(args, (char *) "OOO:xsltApplyStylesheet",
		          &pyobj_style, &pyobj_doc, &pyobj_params))
        return(NULL);

    if (pyobj_params != Py_None) {
	if (PyDict_Check(pyobj_params)) {
	    len = PyDict_Size(pyobj_params);
	    if (len > 0) {
	        params_size = (len + 1) * 2 * sizeof(char *);
		params = (const char **) xmlMalloc(params_size);
		if (params == NULL) {
		    printf("libxslt_xsltApplyStylesheet: out of memory\n");
		    Py_INCREF(Py_None);
		    return(Py_None);
		}
		memset(params, 0, params_size);
		j = 0;
		while (PyDict_Next(pyobj_params, &ppos, &name, &value)) {
		    const char *tmp;
#if PY_MAJOR_VERSION >= 3
		    Py_ssize_t size;

		    tmp = PyUnicode_AsUTF8AndSize(name, &size);
#else
		    int size;

		    tmp = PyString_AS_STRING(name);
		    size = PyString_GET_SIZE(name);
#endif
		    params[j * 2] = (char *) xmlCharStrndup(tmp, size);

#if PY_MAJOR_VERSION >= 3
		    if (PyUnicode_Check(value)) {
			tmp = PyUnicode_AsUTF8AndSize(value, &size);
#else
		    if (PyString_Check(value)) {
			tmp = PyString_AS_STRING(value);
			size = PyString_GET_SIZE(value);
#endif
			params[(j * 2) + 1] = (char *)
			    xmlCharStrndup(tmp, size);
		    } else {
			params[(j * 2) + 1] = NULL;
		    }
		    j = j + 1;
		}
		params[j * 2] = NULL;
		params[(j * 2) + 1] = NULL;
	    }
	} else {
	    printf("libxslt_xsltApplyStylesheet: parameters not a dict\n");
	    Py_INCREF(Py_None);
	    return(Py_None);
	}
    }
    style = (xsltStylesheetPtr) Pystylesheet_Get(pyobj_style);
    doc = (xmlDocPtr) PyxmlNode_Get(pyobj_doc);

    c_retval = xsltApplyStylesheet(style, doc, params);
    py_retval = libxml_xmlDocPtrWrap((xmlDocPtr) c_retval);
    if (params != NULL) {
	if (len > 0) {
	    for (i = 0;i < 2 * len;i++) {
		if (params[i] != NULL)
		    xmlFree((char *)params[i]);
	    }
	    xmlFree(params);
	}
    }
    return(py_retval);
}

PyObject *
libxslt_xsltSaveResultToString(PyObject *self ATTRIBUTE_UNUSED, PyObject *args) {
    PyObject *py_retval;        /* our final return value, a python string   */
    xmlChar  *buffer;
    int       size    = 0;
    int       emitted = 0;
    xmlDocPtr result;
    PyObject *pyobj_result;
    xsltStylesheetPtr style;
    PyObject *pyobj_style;

    if (!PyArg_ParseTuple(args, (char *)"OO:xsltSaveResultToString", &pyobj_style, &pyobj_result))
      goto FAIL;
    result = (xmlDocPtr) PyxmlNode_Get(pyobj_result);
    style  = (xsltStylesheetPtr) Pystylesheet_Get(pyobj_style);


    /* FIXME: We should probably add more restrictive error checking
     * and raise an error instead of "just" returning NULL.
     * FIXME: Documentation and code for xsltSaveResultToString diff
     * -> emmitted will never be positive non-null.
     */
    emitted = xsltSaveResultToString(&buffer, &size, result, style);
    if(!buffer || emitted < 0)
      goto FAIL;
    /* We haven't tested the aberrant case of a transformation that
     * renders to an empty string. For now we try to play it safe.
     */
    if(size)
      {
      buffer[size] = '\0';
#if PY_MAJOR_VERSION >= 3
      py_retval = PyUnicode_DecodeUTF8((char *) buffer, size, NULL);
#else
      py_retval = PyString_FromString((char *) buffer);
#endif
      xmlFree(buffer);
      }
    else
#if PY_MAJOR_VERSION >= 3
      py_retval = PyUnicode_DecodeUTF8("", 0, NULL);
#else
      py_retval = PyString_FromString("");
#endif
    return(py_retval);
 FAIL:
    return(0);
}


/************************************************************************
 *									*
 *			Error message callback				*
 *									*
 ************************************************************************/

static PyObject *libxslt_xsltPythonErrorFuncHandler = NULL;
static PyObject *libxslt_xsltPythonErrorFuncCtxt = NULL;

static void LIBXSLT_ATTR_FORMAT(2,3)
libxslt_xsltErrorFuncHandler(void *ctx ATTRIBUTE_UNUSED, const char *msg,
                           ...)
{
    int size;
    int chars;
    char *larger;
    va_list ap;
    char *str;
    PyObject *list;
    PyObject *message;
    PyObject *result;

#ifdef DEBUG_ERROR
    printf("libxslt_xsltErrorFuncHandler(%p, %s, ...) called\n", ctx, msg);
#endif


    if (libxslt_xsltPythonErrorFuncHandler == NULL) {
        va_start(ap, msg);
        vfprintf(stderr, msg, ap);
        va_end(ap);
    } else {
        str = (char *) xmlMalloc(150);
        if (str == NULL)
            return;

        size = 150;

        while (1) {
            va_start(ap, msg);
            chars = vsnprintf(str, size, msg, ap);
            va_end(ap);
            if ((chars > -1) && (chars < size))
                break;
            if (chars > -1)
                size += chars + 1;
            else
                size += 100;
            if ((larger = (char *) xmlRealloc(str, size)) == NULL) {
                xmlFree(str);
                return;
            }
            str = larger;
        }

        list = PyTuple_New(2);
        PyTuple_SetItem(list, 0, libxslt_xsltPythonErrorFuncCtxt);
        Py_XINCREF(libxslt_xsltPythonErrorFuncCtxt);
        message = libxml_charPtrWrap(str);
        PyTuple_SetItem(list, 1, message);
        result = PyEval_CallObject(libxslt_xsltPythonErrorFuncHandler, list);
        Py_XDECREF(list);
        Py_XDECREF(result);
    }
}

static void
libxslt_xsltErrorInitialize(void)
{
#ifdef DEBUG_ERROR
    printf("libxslt_xsltErrorInitialize() called\n");
#endif
    xmlSetGenericErrorFunc(NULL, libxslt_xsltErrorFuncHandler);
    xsltSetGenericErrorFunc(NULL, libxslt_xsltErrorFuncHandler);
}

PyObject *
libxslt_xsltRegisterErrorHandler(PyObject * self ATTRIBUTE_UNUSED,
                               PyObject * args)
{
    PyObject *py_retval;
    PyObject *pyobj_f;
    PyObject *pyobj_ctx;

    if (!PyArg_ParseTuple
        (args, (char *) "OO:xmlRegisterErrorHandler", &pyobj_f,
         &pyobj_ctx))
        return (NULL);

#ifdef DEBUG_ERROR
    printf("libxml_registerXPathFunction(%p, %p) called\n", pyobj_ctx,
           pyobj_f);
#endif

    if (libxslt_xsltPythonErrorFuncHandler != NULL) {
        Py_XDECREF(libxslt_xsltPythonErrorFuncHandler);
    }
    if (libxslt_xsltPythonErrorFuncCtxt != NULL) {
        Py_XDECREF(libxslt_xsltPythonErrorFuncCtxt);
    }

    Py_XINCREF(pyobj_ctx);
    Py_XINCREF(pyobj_f);

    /* TODO: check f is a function ! */
    libxslt_xsltPythonErrorFuncHandler = pyobj_f;
    libxslt_xsltPythonErrorFuncCtxt = pyobj_ctx;

    py_retval = libxml_intWrap(1);
    return (py_retval);
}

/************************************************************************
 *									*
 *			Extension classes				*
 *									*
 ************************************************************************/

static xmlHashTablePtr libxslt_extModuleClasses = NULL;

static void *
libxslt_xsltPythonExtModuleStyleInit(xsltStylesheetPtr style,
	                            const xmlChar * URI) {
    PyObject *result = NULL;
    PyObject *class = NULL;

#ifdef DEBUG_EXTENSIONS
    printf("libxslt_xsltPythonExtModuleStyleInit(%p, %s) called\n",
	   style, URI);
#endif

    if ((style == NULL) || (URI == NULL))
	return(NULL);

    /*
     * Find the function, it should be there it was there at lookup
     */
    class = xmlHashLookup(libxslt_extModuleClasses, URI);
    if (class == NULL) {
	fprintf(stderr, "libxslt_xsltPythonExtModuleStyleInit: internal error %s not found !\n", URI);
	return(NULL);
    }

    if (PyObject_HasAttrString(class, (char *) "_styleInit")) {
	result = PyObject_CallMethod(class, (char *) "_styleInit",
		     (char *) "Os", libxslt_xsltStylesheetPtrWrap(style), URI);
    }
    return((void *)result);
}
static void
libxslt_xsltPythonExtModuleStyleShutdown(xsltStylesheetPtr style,
	                                const xmlChar * URI, void *data) {
    PyObject *class = NULL;
    PyObject *result;

#ifdef DEBUG_EXTENSIONS
    printf("libxslt_xsltPythonExtModuleStyleShutdown(%p, %s, %p) called\n",
	   style, URI, data);
#endif

    if ((style == NULL) || (URI == NULL))
	return;

    /*
     * Find the function, it should be there it was there at lookup
     */
    class = xmlHashLookup(libxslt_extModuleClasses, URI);
    if (class == NULL) {
	fprintf(stderr, "libxslt_xsltPythonExtModuleStyleShutdown: internal error %s not found !\n", URI);
	return;
    }

    if (PyObject_HasAttrString(class, (char *) "_styleShutdown")) {
	result = PyObject_CallMethod(class, (char *) "_styleShutdown",
		     (char *) "OsO", libxslt_xsltStylesheetPtrWrap(style),
		     URI, (PyObject *) data);
	Py_XDECREF(result);
	Py_XDECREF((PyObject *)data);
    }
}

static void *
libxslt_xsltPythonExtModuleCtxtInit(xsltTransformContextPtr ctxt,
	                            const xmlChar * URI) {
    PyObject *result = NULL;
    PyObject *class = NULL;

#ifdef DEBUG_EXTENSIONS
    printf("libxslt_xsltPythonExtModuleCtxtInit(%p, %s) called\n",
	   ctxt, URI);
#endif

    if ((ctxt == NULL) || (URI == NULL))
	return(NULL);

    /*
     * Find the function, it should be there it was there at lookup
     */
    class = xmlHashLookup(libxslt_extModuleClasses, URI);
    if (class == NULL) {
	fprintf(stderr, "libxslt_xsltPythonExtModuleCtxtInit: internal error %s not found !\n", URI);
	return(NULL);
    }

    if (PyObject_HasAttrString(class, (char *) "_ctxtInit")) {
	result = PyObject_CallMethod(class, (char *) "_ctxtInit",
		     (char *) "Os", libxslt_xsltTransformContextPtrWrap(ctxt),
		     URI);
    }
    return((void *)result);
}
static void
libxslt_xsltPythonExtModuleCtxtShutdown(xsltTransformContextPtr ctxt,
	                                const xmlChar * URI, void *data) {
    PyObject *class = NULL;
    PyObject *result;

#ifdef DEBUG_EXTENSIONS
    printf("libxslt_xsltPythonExtModuleCtxtShutdown(%p, %s, %p) called\n",
	   ctxt, URI, data);
#endif

    if ((ctxt == NULL) || (URI == NULL))
	return;

    /*
     * Find the function, it should be there it was there at lookup
     */
    class = xmlHashLookup(libxslt_extModuleClasses, URI);
    if (class == NULL) {
	fprintf(stderr, "libxslt_xsltPythonExtModuleCtxtShutdown: internal error %s not found !\n", URI);
	return;
    }

    if (PyObject_HasAttrString(class, (char *) "_ctxtShutdown")) {
	result = PyObject_CallMethod(class, (char *) "_ctxtShutdown",
		     (char *) "OsO", libxslt_xsltTransformContextPtrWrap(ctxt),
		     URI, (PyObject *) data);
	Py_XDECREF(result);
	Py_XDECREF((PyObject *)data);
    }
}

PyObject *
libxslt_xsltRegisterExtensionClass(PyObject *self ATTRIBUTE_UNUSED,
	                           PyObject *args) {
    PyObject *py_retval;
    int ret = 0;
    xmlChar *ns_uri;
    PyObject *pyobj_c;

    if (!PyArg_ParseTuple(args, (char *)"zO:registerExtensionClass",
		          &ns_uri, &pyobj_c))
        return(NULL);

    if ((ns_uri == NULL) || (pyobj_c == NULL)) {
	py_retval = libxml_intWrap(-1);
	return(py_retval);
    }

#ifdef DEBUG_EXTENSIONS
    printf("libxslt_xsltRegisterExtensionClass(%s) called\n", ns_uri);
#endif

    if (libxslt_extModuleClasses == NULL)
	libxslt_extModuleClasses = xmlHashCreate(10);
    if (libxslt_extModuleClasses == NULL) {
	py_retval = libxml_intWrap(-1);
	return(py_retval);
    }
    ret = xmlHashAddEntry(libxslt_extModuleClasses, ns_uri, pyobj_c);
    if (ret != 0) {
	py_retval = libxml_intWrap(-1);
	return(py_retval);
    }
    Py_XINCREF(pyobj_c);

    ret = xsltRegisterExtModuleFull(ns_uri,
       libxslt_xsltPythonExtModuleCtxtInit,
       libxslt_xsltPythonExtModuleCtxtShutdown,
       libxslt_xsltPythonExtModuleStyleInit,
       libxslt_xsltPythonExtModuleStyleShutdown);
    py_retval = libxml_intWrap((int) ret);
    if (ret < 0) {
	Py_XDECREF(pyobj_c);
    }
    return(py_retval);
}

/************************************************************************
 *									*
 *			Integrated cleanup				*
 *									*
 ************************************************************************/

PyObject *
libxslt_xsltPythonCleanup(PyObject *self ATTRIBUTE_UNUSED,
	                  PyObject *args ATTRIBUTE_UNUSED) {

    if (libxslt_extModuleFunctions != NULL) {
	xmlHashFree(libxslt_extModuleFunctions, deallocateCallback);
    }
    if (libxslt_extModuleElements != NULL) {
	xmlHashFree(libxslt_extModuleElements, deallocateCallback);
    }
    if (libxslt_extModuleElementPreComp != NULL) {
	xmlHashFree(libxslt_extModuleElementPreComp, deallocateCallback);
    }
    if (libxslt_extModuleClasses != NULL) {
	xmlHashFree(libxslt_extModuleClasses, deallocateClasse);
    }
    xsltCleanupGlobals();
    Py_INCREF(Py_None);
    return(Py_None);
}

/************************************************************************
 *									*
 *			The registration stuff				*
 *									*
 ************************************************************************/
static PyMethodDef libxsltMethods[] = {
#include "libxslt-export.c"
    { NULL, NULL, 0, NULL }
};

#ifdef MERGED_MODULES
#if PY_MAJOR_VERSION >= 3
extern PyObject*  PyInit_libxml2mod(void);
#else
extern void initlibxml2mod(void);
#endif
#endif

#if PY_MAJOR_VERSION >= 3
#define INITERROR return NULL

static struct PyModuleDef moduledef = {
    PyModuleDef_HEAD_INIT,
    "libxsltmod",
    NULL,
    -1,
    libxsltMethods,
    NULL,
    NULL,
    NULL,
    NULL
};
#else
#define INITERROR return
#endif

#if PY_MAJOR_VERSION >= 3
PyObject* PyInit_libxsltmod(void){
#else
void initlibxsltmod(void) {
#endif
    PyObject *m;

#ifdef MERGED_MODULES
#if PY_MAJOR_VERSION >= 3
    PyInit_libxml2mod();
#else
    initlibxml2mod();
#endif
#endif

#if PY_MAJOR_VERSION >= 3
    m = PyModule_Create(&moduledef);
#else
    m = Py_InitModule((char *)"libxsltmod", libxsltMethods);
#endif
    if (!m)
	INITERROR;
    /*
     * Specific XSLT initializations
     */
    libxslt_xsltErrorInitialize();
    xmlInitMemory();
    xmlLoadExtDtdDefaultValue = XML_DETECT_IDS | XML_COMPLETE_ATTRS;
    xmlDefaultSAXHandler.cdataBlock = NULL;
    /*
     * Register the EXSLT extensions and the test module
     */
    exsltRegisterAll();
#if PY_MAJOR_VERSION >= 3
    return m;
#endif
}
