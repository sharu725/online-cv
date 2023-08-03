#!/usr/bin/python -u
#
# generate python wrappers from the XML API description
#

functions = {}
enums = {} # { enumType: { enumConstant: enumValue } }

import string

#######################################################################
#
#  That part if purely the API acquisition phase from the
#  XML API description
#
#######################################################################
import os
import xml.sax

debug = 0
srcdir = os.getenv("SRCDIR", ".")

def getparser():
    # Attach parser to an unmarshalling object. return both objects.
    target = docParser()
    parser = xml.sax.make_parser()
    parser.setContentHandler(target)
    return parser, target

class docParser(xml.sax.handler.ContentHandler):
    def __init__(self):
        self._methodname = None
        self._data = []
        self.in_function = 0

        self.startElement = self.start
        self.endElement = self.end
        self.characters = self.data

    def close(self):
        if debug:
            print("close")

    def getmethodname(self):
        return self._methodname

    def data(self, text):
        if debug:
            print("data %s" % text)
        self._data.append(text)

    def start(self, tag, attrs):
        if debug:
            print("start %s, %s" % (tag, attrs))
        if tag == 'function':
            self._data = []
            self.in_function = 1
            self.function = None
            self.function_args = []
            self.function_descr = None
            self.function_return = None
            self.function_file = None
            if 'name' in attrs:
                self.function = attrs['name']
            if 'file' in attrs:
                self.function_file = attrs['file']
        elif tag == 'info':
            self._data = []
        elif tag == 'arg':
            if self.in_function == 1:
                self.function_arg_name = None
                self.function_arg_type = None
                self.function_arg_info = None
                if 'name' in attrs:
                    self.function_arg_name = attrs['name']
                if 'type' in attrs:
                    self.function_arg_type = attrs['type']
                if 'info' in attrs:
                    self.function_arg_info = attrs['info']
        elif tag == 'return':
            if self.in_function == 1:
                self.function_return_type = None
                self.function_return_info = None
                self.function_return_field = None
                if 'type' in attrs:
                    self.function_return_type = attrs['type']
                if 'info' in attrs:
                    self.function_return_info = attrs['info']
                if 'field' in attrs:
                    self.function_return_field = attrs['field']
        elif tag == 'enum':
            enum(attrs['type'],attrs['name'],attrs['value'])



    def end(self, tag):
        if debug:
            print("end %s" % tag)
        if tag == 'function':
            if self.function != None:
                function(self.function, self.function_descr,
                         self.function_return, self.function_args,
                         self.function_file)
                self.in_function = 0
        elif tag == 'arg':
            if self.in_function == 1:
                self.function_args.append([self.function_arg_name,
                                           self.function_arg_type,
                                           self.function_arg_info])
        elif tag == 'return':
            if self.in_function == 1:
                self.function_return = [self.function_return_type,
                                        self.function_return_info,
                                        self.function_return_field]
        elif tag == 'info':
            str = ''
            for c in self._data:
                str = str + c
            if self.in_function == 1:
                self.function_descr = str


def function(name, desc, ret, args, file):
    functions[name] = (desc, ret, args, file)

def enum(type, name, value):
    if type not in enums:
        enums[type] = {}
    enums[type][name] = value

#######################################################################
#
#  Some filtering rukes to drop functions/types which should not
#  be exposed as-is on the Python interface
#
#######################################################################

skipped_modules = {
    'xmlmemory': None,
    'DOCBparser': None,
    'SAX': None,
    'hash': None,
    'list': None,
    'threads': None,
    'xpointer': None,
    'transform': None,
}
skipped_types = {
    'int *': "usually a return type",
    'xmlSAXHandlerPtr': "not the proper interface for SAX",
    'htmlSAXHandlerPtr': "not the proper interface for SAX",
    'xmlRMutexPtr': "thread specific, skipped",
    'xmlMutexPtr': "thread specific, skipped",
    'xmlGlobalStatePtr': "thread specific, skipped",
    'xmlListPtr': "internal representation not suitable for python",
    'xmlBufferPtr': "internal representation not suitable for python",
    'FILE *': None,
}

#######################################################################
#
#  Table of remapping to/from the python type or class to the C
#  counterpart.
#
#######################################################################

py_types = {
    'void': (None, None, None, None, None),
    'int':  ('i', None, "int", "int", "libxml_"),
    'long':  ('l', None, "long", "long", "libxml_"),
    'double':  ('d', None, "double", "double", "libxml_"),
    'unsigned int':  ('i', None, "int", "int", "libxml_"),
    'xmlChar':  ('c', None, "int", "int", "libxml_"),
    'unsigned char *':  ('z', None, "charPtr", "char *", "libxml_"),
    'char *':  ('z', None, "charPtr", "char *", "libxml_"),
    'const char *':  ('z', None, "charPtrConst", "const char *", "libxml_"),
    'xmlChar *':  ('z', None, "xmlCharPtr", "xmlChar *", "libxml_"),
    'const xmlChar *':  ('z', None, "xmlCharPtrConst", "const xmlChar *", "libxml_"),
    'xmlNodePtr':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'const xmlNodePtr':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'xmlNode *':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'const xmlNode *':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'xmlDtdPtr':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'const xmlDtdPtr':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'xmlDtd *':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'const xmlDtd *':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'xmlAttrPtr':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'const xmlAttrPtr':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'xmlAttr *':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'const xmlAttr *':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'xmlEntityPtr':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'const xmlEntityPtr':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'xmlEntity *':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'const xmlEntity *':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'xmlElementPtr':  ('O', "xmlElement", "xmlElementPtr", "xmlElementPtr", "libxml_"),
    'const xmlElementPtr':  ('O', "xmlElement", "xmlElementPtr", "xmlElementPtr", "libxml_"),
    'xmlElement *':  ('O', "xmlElement", "xmlElementPtr", "xmlElementPtr", "libxml_"),
    'const xmlElement *':  ('O', "xmlElement", "xmlElementPtr", "xmlElementPtr", "libxml_"),
    'xmlAttributePtr':  ('O', "xmlAttribute", "xmlAttributePtr", "xmlAttributePtr", "libxml_"),
    'const xmlAttributePtr':  ('O', "xmlAttribute", "xmlAttributePtr", "xmlAttributePtr", "libxml_"),
    'xmlAttribute *':  ('O', "xmlAttribute", "xmlAttributePtr", "xmlAttributePtr", "libxml_"),
    'const xmlAttribute *':  ('O', "xmlAttribute", "xmlAttributePtr", "xmlAttributePtr", "libxml_"),
    'xmlNsPtr':  ('O', "xmlNode", "xmlNsPtr", "xmlNsPtr", "libxml_"),
    'const xmlNsPtr':  ('O', "xmlNode", "xmlNsPtr", "xmlNsPtr", "libxml_"),
    'xmlNs *':  ('O', "xmlNode", "xmlNsPtr", "xmlNsPtr", "libxml_"),
    'const xmlNs *':  ('O', "xmlNode", "xmlNsPtr", "xmlNsPtr", "libxml_"),
    'xmlDocPtr':  ('O', "xmlNode", "xmlDocPtr", "xmlDocPtr", "libxml_"),
    'const xmlDocPtr':  ('O', "xmlNode", "xmlDocPtr", "xmlDocPtr", "libxml_"),
    'xmlDoc *':  ('O', "xmlNode", "xmlDocPtr", "xmlDocPtr", "libxml_"),
    'const xmlDoc *':  ('O', "xmlNode", "xmlDocPtr", "xmlDocPtr", "libxml_"),
    'htmlDocPtr':  ('O', "xmlNode", "xmlDocPtr", "xmlDocPtr", "libxml_"),
    'const htmlDocPtr':  ('O', "xmlNode", "xmlDocPtr", "xmlDocPtr", "libxml_"),
    'htmlDoc *':  ('O', "xmlNode", "xmlDocPtr", "xmlDocPtr", "libxml_"),
    'const htmlDoc *':  ('O', "xmlNode", "xmlDocPtr", "xmlDocPtr", "libxml_"),
    'htmlNodePtr':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'const htmlNodePtr':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'htmlNode *':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'const htmlNode *':  ('O', "xmlNode", "xmlNodePtr", "xmlNodePtr", "libxml_"),
    'xmlXPathContextPtr':  ('O', "xmlXPathContext", "xmlXPathContextPtr", "xmlXPathContextPtr", "libxml_"),
    'xmlXPathParserContextPtr':  ('O', "xmlXPathParserContext", "xmlXPathParserContextPtr", "xmlXPathParserContextPtr", "libxml_"),
    'xmlParserCtxtPtr': ('O', "parserCtxt", "xmlParserCtxtPtr", "xmlParserCtxtPtr", "libxml_"),
    'xmlParserCtxt *': ('O', "parserCtxt", "xmlParserCtxtPtr", "xmlParserCtxtPtr", "libxml_"),
    'htmlParserCtxtPtr': ('O', "parserCtxt", "xmlParserCtxtPtr", "xmlParserCtxtPtr", "libxml_"),
    'htmlParserCtxt *': ('O', "parserCtxt", "xmlParserCtxtPtr", "xmlParserCtxtPtr", "libxml_"),
    'xmlCatalogPtr': ('O', "catalog", "xmlCatalogPtr", "xmlCatalogPtr"),
    'FILE *': ('O', "File", "FILEPtr", "FILE *", "libxml_"),
    'xsltTransformContextPtr':  ('O', "transformCtxt", "xsltTransformContextPtr", "xsltTransformContextPtr", "libxslt_"),
    'xsltTransformContext *':  ('O', "transformCtxt", "xsltTransformContextPtr", "xsltTransformContextPtr", "libxslt_"),
    'xsltStylePreCompPtr':  ('O', "compiledStyle", "xsltStylePreCompPtr", "xsltStylePreCompPtr", "libxslt_"),
    'xsltStylePreComp *':  ('O', "compiledStyle", "xsltStylePreCompPtr", "xsltStylePreCompPtr", "libxslt_"),
    'xsltStylesheetPtr':  ('O', "stylesheet", "xsltStylesheetPtr", "xsltStylesheetPtr", "libxslt_"),
    'xsltStylesheet *':  ('O', "stylesheet", "xsltStylesheetPtr", "xsltStylesheetPtr", "libxslt_"),
    'xmlXPathContext *':  ('O', "xpathContext", "xmlXPathContextPtr", "xmlXPathContextPtr", "libxslt_"),
}

py_return_types = {
    'xmlXPathObjectPtr':  ('O', "foo", "xmlXPathObjectPtr", "xmlXPathObjectPtr", "libxml_"),
}

unknown_types = {}

#######################################################################
#
#  This part writes the C <-> Python stubs libxslt-py.[ch] and
#  the table libxslt-export.c to add when registrering the Python module
#
#######################################################################

def skip_function(name):
    if name[0:12] == "xmlXPathWrap":
        return 1
    if name == "xsltMatchPattern":
        return 1
#    if name[0:11] == "xmlXPathNew":
#        return 1
    return 0

def print_function_wrapper(name, output, export, include):
    global py_types
    global unknown_types
    global functions
    global skipped_modules

    try:
        (desc, ret, args, file) = functions[name]
    except:
        print("failed to get function %s infos")
        return

    if file in skipped_modules:
        return 0
    if skip_function(name) == 1:
        return 0

    c_call = ""
    format=""
    format_args=""
    c_args=""
    c_return=""
    c_convert=""
    for arg in args:
        # This should be correct
        if arg[1][0:6] == "const ":
            arg[1] = arg[1][6:]
        c_args = c_args + "    %s %s;\n" % (arg[1], arg[0])
        if arg[1] in py_types:
            (f, t, n, c, p) = py_types[arg[1]]
            if f != None:
                format = format + f
            if t != None:
                format_args = format_args + ", &pyobj_%s" % (arg[0])
                c_args = c_args + "    PyObject *pyobj_%s;\n" % (arg[0])
                c_convert = c_convert + \
                   "    %s = (%s) Py%s_Get(pyobj_%s);\n" % (arg[0],
                   arg[1], t, arg[0])
            else:
                format_args = format_args + ", &%s" % (arg[0])
            if c_call != "":
                c_call = c_call + ", "
            c_call = c_call + "%s" % (arg[0])
        else:
            if arg[1] in skipped_types:
                return 0
            if arg[1] in unknown_types:
                lst = unknown_types[arg[1]]
                lst.append(name)
            else:
                unknown_types[arg[1]] = [name]
            return -1
    if format != "":
        format = format + ":%s" % (name)

    if ret[0] == 'void':
        if file == "python_accessor":
            if args[1][1] == "char *" or args[1][1] == "xmlChar *":
                c_call = "\n    if (%s->%s != NULL) xmlFree(%s->%s);\n" % (
                                 args[0][0], args[1][0], args[0][0], args[1][0])
                c_call = c_call + "    %s->%s = xmlStrdup((const xmlChar *)%s);\n" % (args[0][0],
                                 args[1][0], args[1][0])
            else:
                c_call = "\n    %s->%s = %s;\n" % (args[0][0], args[1][0],
                                                   args[1][0])
        else:
            c_call = "\n    %s(%s);\n" % (name, c_call)
        ret_convert = "    Py_INCREF(Py_None);\n    return(Py_None);\n"
    elif ret[0] in py_types:
        (f, t, n, c, p) = py_types[ret[0]]
        c_return = "    %s c_retval;\n" % (ret[0])
        if file == "python_accessor" and ret[2] != None:
            c_call = "\n    c_retval = %s->%s;\n" % (args[0][0], ret[2])
        else:
            c_call = "\n    c_retval = %s(%s);\n" % (name, c_call)
        ret_convert = "    py_retval = %s%sWrap((%s) c_retval);\n" % (p,n,c)
        ret_convert = ret_convert + "    return(py_retval);\n"
    elif ret[0] in py_return_types:
        (f, t, n, c, p) = py_return_types[ret[0]]
        c_return = "    %s c_retval;\n" % (ret[0])
        if file == "python_accessor" and ret[2] != None:
            c_call = "\n    c_retval = %s->%s;\n" % (args[0][0], ret[2])
        else:
            c_call = "\n    c_retval = %s(%s);\n" % (name, c_call)
        ret_convert = "    py_retval = %s%sWrap((%s) c_retval);\n" % (p,n,c)
        ret_convert = ret_convert + "    return(py_retval);\n"
    else:
        if ret[0] in skipped_types:
            return 0
        if ret[0] in unknown_types:
            lst = unknown_types[ret[0]]
            lst.append(name)
        else:
            unknown_types[ret[0]] = [name]
        return -1

    include.write("PyObject * ")
    include.write("libxslt_%s(PyObject *self, PyObject *args);\n" % (name))

    export.write("    { (char *)\"%s\", libxslt_%s, METH_VARARGS, NULL },\n" % (name, name))

    if file == "python":
        # Those have been manually generated
        return 1
    if file == "python_accessor" and ret[0] != "void" and ret[2] == None:
        # Those have been manually generated
        return 1

    output.write("PyObject *\n")
    output.write("libxslt_%s(PyObject *self ATTRIBUTE_UNUSED," % (name))
    output.write(" PyObject *args")
    if format == "":
        output.write(" ATTRIBUTE_UNUSED")
    output.write(") {\n")
    if ret[0] != 'void':
        output.write("    PyObject *py_retval;\n")
    if c_return != "":
        output.write(c_return)
    if c_args != "":
        output.write(c_args)
    if format != "":
        output.write("\n    if (!PyArg_ParseTuple(args, (char *)\"%s\"%s))\n" %
                     (format, format_args))
        output.write("        return(NULL);\n")
    if c_convert != "":
        output.write(c_convert)

    output.write(c_call)
    output.write(ret_convert)
    output.write("}\n\n")
    return 1

def buildStubs():
    global py_types
    global py_return_types
    global unknown_types

    try:
        f = open("%s/libxslt-api.xml" % srcdir)
        data = f.read()
        (parser, target)  = getparser()
        parser.feed(data)
        parser.close()
    except IOError as msg:
        try:
            f = open("%s/../doc/libxslt-api.xml" % srcdir)
            data = f.read()
            (parser, target)  = getparser()
            parser.feed(data)
            parser.close()
        except IOError as msg:
            print("../doc/libxslt-api.xml", ":", msg)

    n = len(list(functions.keys()))
    print("Found %d functions in libxslt-api.xml" % (n))

    py_types['pythonObject'] = ('O', "pythonObject", "pythonObject",
                                "pythonObject", "libxml_")
    try:
        f = open("%s/libxslt-python-api.xml" % srcdir)
        data = f.read()
        (parser, target)  = getparser()
        parser.feed(data)
        parser.close()
    except IOError as msg:
        print("libxslt-python-api.xml", ":", msg)


    print("Found %d functions in libxslt-python-api.xml" % (
          len(list(functions.keys())) - n))
    nb_wrap = 0
    failed = 0
    skipped = 0

    include = open("libxslt-py.h", "w")
    include.write("/* Generated */\n\n")
    export = open("libxslt-export.c", "w")
    export.write("/* Generated */\n\n")
    wrapper = open("libxslt-py.c", "w")
    wrapper.write("/* Generated */\n\n")
#    wrapper.write("#include \"config.h\"\n")
    wrapper.write("#include <libxslt/xsltconfig.h>\n")
    wrapper.write("#include \"libxslt_wrap.h\"\n")
    wrapper.write("#include \"libxslt-py.h\"\n\n")
    for function in list(functions.keys()):
        ret = print_function_wrapper(function, wrapper, export, include)
        if ret < 0:
            failed = failed + 1
            del functions[function]
        if ret == 0:
            skipped = skipped + 1
            del functions[function]
        if ret == 1:
            nb_wrap = nb_wrap + 1
    include.close()
    export.close()
    wrapper.close()

    print("Generated %d wrapper functions, %d failed, %d skipped\n" % (nb_wrap,
                                                              failed, skipped))
    print("Missing type converters:")
    for type in list(unknown_types.keys()):
        print("%s:%d " % (type, len(unknown_types[type])))
    print()

#######################################################################
#
#  This part writes part of the Python front-end classes based on
#  mapping rules between types and classes and also based on function
#  renaming to get consistent function names at the Python level
#
#######################################################################

#
# The type automatically remapped to generated classes
#
libxml2_classes_type = {
    "xmlNodePtr": ("._o", "xmlNode(_obj=%s)", "xmlNode"),
    "xmlNode *": ("._o", "xmlNode(_obj=%s)", "xmlNode"),
    "xmlDocPtr": ("._o", "xmlDoc(_obj=%s)", "xmlDoc"),
    "xmlDocPtr *": ("._o", "xmlDoc(_obj=%s)", "xmlDoc"),
    "htmlDocPtr": ("._o", "xmlDoc(_obj=%s)", "xmlDoc"),
    "htmlxmlDocPtr *": ("._o", "xmlDoc(_obj=%s)", "xmlDoc"),
    "xmlAttrPtr": ("._o", "xmlAttr(_obj=%s)", "xmlAttr"),
    "xmlAttr *": ("._o", "xmlAttr(_obj=%s)", "xmlAttr"),
    "xmlNsPtr": ("._o", "xmlNs(_obj=%s)", "xmlNs"),
    "xmlNs *": ("._o", "xmlNs(_obj=%s)", "xmlNs"),
    "xmlDtdPtr": ("._o", "xmlDtd(_obj=%s)", "xmlDtd"),
    "xmlDtd *": ("._o", "xmlDtd(_obj=%s)", "xmlDtd"),
    "xmlEntityPtr": ("._o", "xmlEntity(_obj=%s)", "xmlEntity"),
    "xmlEntity *": ("._o", "xmlEntity(_obj=%s)", "xmlEntity"),
    "xmlElementPtr": ("._o", "xmlElement(_obj=%s)", "xmlElement"),
    "xmlElement *": ("._o", "xmlElement(_obj=%s)", "xmlElement"),
    "xmlAttributePtr": ("._o", "xmlAttribute(_obj=%s)", "xmlAttribute"),
    "xmlAttribute *": ("._o", "xmlAttribute(_obj=%s)", "xmlAttribute"),
    "xmlParserCtxtPtr": ("._o", "parserCtxt(_obj=%s)", "parserCtxt"),
    "xmlParserCtxt *": ("._o", "parserCtxt(_obj=%s)", "parserCtxt"),
    "xmlCatalogPtr": ("._o", "catalog(_obj=%s)", "catalog"),
}

classes_type = {
    "xsltTransformContextPtr": ("._o", "transformCtxt(_obj=%s)", "transformCtxt"),
    "xsltTransformContext *": ("._o", "transformCtxt(_obj=%s)", "transformCtxt"),
    "xsltStylesheetPtr": ("._o", "stylesheet(_obj=%s)", "stylesheet"),
    "xsltStylesheet *": ("._o", "stylesheet(_obj=%s)", "stylesheet"),
    "xmlXPathContextPtr": ("._o", "xpathContext(_obj=%s)", "xpathContext"),
    "xmlXPathContext *": ("._o", "xpathContext(_obj=%s)", "xpathContext"),
    "xmlXPathParserContextPtr": ("._o", "xpathParserContext(_obj=%s)", "xpathParserContext"),
    "xmlXPathParserContext *": ("._o", "xpathParserContext(_obj=%s)", "xpathParserContext"),
}

converter_type = {
    "xmlXPathObjectPtr": "libxml2.xpathObjectRet(%s)",
}

primary_classes = ["xpathParserContext", "xpathContext", "transformCtxt", "stylesheet"]

classes_ancestor = {
    "xpathContext" : "libxml2.xpathContext",
    "xpathParserContext" : "libxml2.xpathParserContext",
    "transformCtxt": "transformCtxtBase",
    "stylesheet": "stylesheetBase",
}
classes_destructors = {
    "xpathContext" : "pass"
}

function_classes = {}
ctypes = []
classes_list = []


def nameFixup(name, classe, type, file):
    listname = classe + "List"
    ll = len(listname)
    l = len(classe)
    if name[0:l] == listname:
        func = name[l:]
        func = func[0:1].lower() + func[1:]
    elif name[0:12] == "xmlParserGet" and file == "python_accessor":
        func = name[12:]
        func = func[0:1].lower() + func[1:]
    elif name[0:12] == "xmlParserSet" and file == "python_accessor":
        func = name[12:]
        func = func[0:1].lower() + func[1:]
    elif name[0:10] == "xmlNodeGet" and file == "python_accessor":
        func = name[10:]
        func = func[0:1].lower() + func[1:]
    elif name[0:18] == "xsltXPathParserGet" and file == "python_accessor":
        func = name[18:]
        func = func[0:1].lower() + func[1:]
    elif name[0:12] == "xsltXPathGet" and file == "python_accessor":
        func = name[12:]
        func = func[0:1].lower() + func[1:]
    elif name[0:16] == "xsltTransformGet" and file == "python_accessor":
        func = name[16:]
        func = func[0:1].lower() + func[1:]
    elif name[0:16] == "xsltTransformSet" and file == "python_accessor":
        func = name[13:]
        func = func[0:1].lower() + func[1:]
    elif name[0:17] == "xsltStylesheetGet" and file == "python_accessor":
        func = name[17:]
        func = func[0:1].lower() + func[1:]
    elif name[0:17] == "xsltStylesheetSet" and file == "python_accessor":
        func = name[14:]
        func = func[0:1].lower() + func[1:]
    elif name[0:l] == classe:
        func = name[l:]
        func = func[0:1].lower() + func[1:]
    elif name[0:7] == "libxml_":
        func = name[7:]
        func = func[0:1].lower() + func[1:]
    elif name[0:8] == "libxslt_":
        func = name[8:]
        func = func[0:1].lower() + func[1:]
    elif name[0:6] == "xmlGet":
        func = name[6:]
        func = func[0:1].lower() + func[1:]
    elif name[0:3] == "xml":
        func = name[3:]
        func = func[0:1].lower() + func[1:]
    elif name[0:7] == "xsltGet":
        func = name[7:]
        func = func[0:1].lower() + func[1:]
    elif name[0:4] == "xslt":
        func = name[4:]
        func = func[0:1].lower() + func[1:]
    else:
        func = name
    if func[0:5] == "xPath":
        func = "xpath" + func[5:]
    elif func[0:4] == "xPtr":
        func = "xpointer" + func[4:]
    elif func[0:8] == "xInclude":
        func = "xinclude" + func[8:]
    elif func[0:2] == "iD":
        func = "ID" + func[2:]
    elif func[0:3] == "uRI":
        func = "URI" + func[3:]
    elif func[0:4] == "uTF8":
        func = "UTF8" + func[4:]
    return func

def cmp_to_key(mycmp):
    'Convert a cmp= function into a key= function'
    class K(object):
        def __init__(self, obj, *args):
            self.obj = obj
        def __lt__(self, other):
            return mycmp(self.obj, other.obj) < 0
        def __gt__(self, other):
            return mycmp(self.obj, other.obj) > 0
        def __eq__(self, other):
            return mycmp(self.obj, other.obj) == 0
        def __le__(self, other):
            return mycmp(self.obj, other.obj) <= 0
        def __ge__(self, other):
            return mycmp(self.obj, other.obj) >= 0
        def __ne__(self, other):
            return mycmp(self.obj, other.obj) != 0
    return K

def functionCompare(info1, info2):
    (index1, func1, name1, ret1, args1, file1) = info1
    (index2, func2, name2, ret2, args2, file2) = info2
    if file1 == file2:
        if func1 < func2:
            return -1
        if func1 > func2:
            return 1
    if file1 == "python_accessor":
        return -1
    if file2 == "python_accessor":
        return 1
    if file1 < file2:
        return -1
    if file1 > file2:
        return 1
    return 0

def writeDoc(name, args, indent, output):
     if functions[name][0] == None or functions[name][0] == "":
         return
     val = functions[name][0]
     val = val.replace("NULL", "None")
     output.write(indent)
     output.write('"""')
     while len(val) > 60:
         if val[0] == " ":
             val = val[1:]
             continue
         str = val[0:60]
         i = str.rfind(" ")
         if i < 0:
             i = 60
         str = val[0:i]
         val = val[i:]
         output.write(str)
         output.write('\n  ')
         output.write(indent)
     output.write(val)
     output.write('"""\n')

def buildWrappers():
    global ctypes
    global py_types
    global py_return_types
    global unknown_types
    global functions
    global function_classes
    global libxml2_classes_type
    global classes_type
    global classes_list
    global converter_type
    global primary_classes
    global converter_type
    global classes_ancestor
    global converter_type
    global primary_classes
    global classes_ancestor
    global classes_destructors

    function_classes["None"] = []
    for type in list(classes_type.keys()):
        function_classes[classes_type[type][2]] = []

    #
    # Build the list of C types to look for ordered to start with
    # primary classes
    #
    ctypes_processed = {}
    classes_processed = {}
    for classe in primary_classes:
        classes_list.append(classe)
        classes_processed[classe] = ()
        for type in list(classes_type.keys()):
            tinfo = classes_type[type]
            if tinfo[2] == classe:
                ctypes.append(type)
                ctypes_processed[type] = ()
    for type in list(classes_type.keys()):
        if type in ctypes_processed:
            continue
        tinfo = classes_type[type]
        if tinfo[2] not in classes_processed:
            classes_list.append(tinfo[2])
            classes_processed[tinfo[2]] = ()

        ctypes.append(type)
        ctypes_processed[type] = ()

    for name in list(functions.keys()):
        found = 0
        (desc, ret, args, file) = functions[name]
        for type in ctypes:
            classe = classes_type[type][2]

            if name[0:4] == "xslt" and len(args) >= 1 and args[0][1] == type:
                found = 1
                func = nameFixup(name, classe, type, file)
                info = (0, func, name, ret, args, file)
                function_classes[classe].append(info)
            elif name[0:4] == "xslt" and len(args) >= 2 and args[1][1] == type:
                found = 1
                func = nameFixup(name, classe, type, file)
                info = (1, func, name, ret, args, file)
                function_classes[classe].append(info)
            elif name[0:4] == "xslt" and len(args) >= 3 and args[2][1] == type:
                found = 1
                func = nameFixup(name, classe, type, file)
                info = (2, func, name, ret, args, file)
                function_classes[classe].append(info)
        if found == 1:
            continue
        if name[0:8] == "xmlXPath":
            continue
        if name[0:6] == "xmlStr":
            continue
        if name[0:10] == "xmlCharStr":
            continue
        func = nameFixup(name, "None", file, file)
        info = (0, func, name, ret, args, file)
        function_classes['None'].append(info)

    classes = open("libxsltclass.py", "w")
    txt = open("libxsltclass.txt", "w")
    txt.write("          Generated Classes for libxslt-python\n\n")

    txt.write("#\n# Global functions of the module\n#\n\n")
    if "None" in function_classes:
        flist = function_classes["None"]
        flist.sort(key=cmp_to_key(functionCompare))
        oldfile = ""
        for info in flist:
            (index, func, name, ret, args, file) = info
            if file != oldfile:
                classes.write("#\n# Functions from module %s\n#\n\n" % file)
                txt.write("\n# functions from module %s\n" % file)
                oldfile = file
            classes.write("def %s(" % func)
            txt.write("%s()\n" % func)
            n = 0
            for arg in args:
                if n != 0:
                    classes.write(", ")
                classes.write("%s" % arg[0])
                n = n + 1
            classes.write("):\n")
            writeDoc(name, args, '    ', classes)

            for arg in args:
                if arg[1] in classes_type:
                    classes.write("    if %s == None: %s__o = None\n" %
                                  (arg[0], arg[0]))
                    classes.write("    else: %s__o = %s%s\n" %
                                  (arg[0], arg[0], classes_type[arg[1]][0]))
                elif arg[1] in libxml2_classes_type:
                    classes.write("    if %s == None: %s__o = None\n" %
                                  (arg[0], arg[0]))
                    classes.write("    else: %s__o = %s%s\n" %
                                  (arg[0], arg[0], libxml2_classes_type[arg[1]][0]))
            if ret[0] != "void":
                classes.write("    ret = ")
            else:
                classes.write("    ")
            classes.write("libxsltmod.%s(" % name)
            n = 0
            for arg in args:
                if n != 0:
                    classes.write(", ")
                classes.write("%s" % arg[0])
                if arg[1] in classes_type:
                    classes.write("__o")
                if arg[1] in libxml2_classes_type:
                    classes.write("__o")
                n = n + 1
            classes.write(")\n")
            if ret[0] != "void":
                if ret[0] in classes_type:
                    classes.write("    if ret == None: return None\n")
                    classes.write("    return ")
                    classes.write(classes_type[ret[0]][1] % ("ret"))
                    classes.write("\n")
                elif ret[0] in libxml2_classes_type:
                    classes.write("    if ret == None: return None\n")
                    classes.write("    return libxml2.")
                    classes.write(libxml2_classes_type[ret[0]][1] % ("ret"))
                    classes.write("\n")
                else:
                    classes.write("    return ret\n")
            classes.write("\n")

    txt.write("\n\n#\n# Set of classes of the module\n#\n\n")
    for classname in classes_list:
        if classname == "None":
            pass
        else:
            if classname in classes_ancestor:
                txt.write("\n\nClass %s(%s)\n" % (classname,
                          classes_ancestor[classname]))
                classes.write("class %s(%s):\n" % (classname,
                              classes_ancestor[classname]))
                classes.write("    def __init__(self, _obj=None):\n")
                classes.write("        self._o = None\n")
                classes.write("        %s.__init__(self, _obj=_obj)\n\n" % (
                              classes_ancestor[classname]))
                if classes_ancestor[classname] == "xmlCore" or \
                   classes_ancestor[classname] == "xmlNode":
                    classes.write("    def __repr__(self):\n")
                    format = "%s:%%s" % (classname)
                    classes.write("        return \"%s\" %% (self.name)\n\n" % (
                                  format))
            else:
                txt.write("Class %s()\n" % (classname))
                classes.write("class %s:\n" % (classname))
                classes.write("    def __init__(self, _obj=None):\n")
                classes.write("        if _obj != None:self._o = _obj;return\n")
                classes.write("        self._o = None\n\n")
            if classname in classes_destructors:
                classes.write("    def __del__(self):\n")
                if classes_destructors[classname] == "pass":
                    classes.write("        pass\n")
                else:
                    classes.write("        if self._o != None:\n")
                    classes.write("            libxsltmod.%s(self._o)\n" %
                                  classes_destructors[classname])
                    classes.write("        self._o = None\n\n")
            flist = function_classes[classname]
            flist.sort(key=cmp_to_key(functionCompare))
            oldfile = ""
            for info in flist:
                (index, func, name, ret, args, file) = info
                if file != oldfile:
                    if file == "python_accessor":
                        classes.write("    # accessors for %s\n" % (classname))
                        txt.write("    # accessors\n")
                    else:
                        classes.write("    #\n")
                        classes.write("    # %s functions from module %s\n" % (
                                      classname, file))
                        txt.write("\n    # functions from module %s\n" % file)
                        classes.write("    #\n\n")
                oldfile = file
                classes.write("    def %s(self" % func)
                txt.write("    %s()\n" % func)
                n = 0
                for arg in args:
                    if n != index:
                        classes.write(", %s" % arg[0])
                    n = n + 1
                classes.write("):\n")
                writeDoc(name, args, '        ', classes)
                n = 0
                for arg in args:
                    if arg[1] in classes_type:
                        if n != index:
                            classes.write("        if %s == None: %s__o = None\n" %
                                          (arg[0], arg[0]))
                            classes.write("        else: %s__o = %s%s\n" %
                                          (arg[0], arg[0], classes_type[arg[1]][0]))
                    elif arg[1] in libxml2_classes_type:
                        classes.write("        if %s == None: %s__o = None\n" %
                                      (arg[0], arg[0]))
                        classes.write("        else: %s__o = %s%s\n" %
                                      (arg[0], arg[0],
                                       libxml2_classes_type[arg[1]][0]))
                    n = n + 1
                if ret[0] != "void":
                    classes.write("        ret = ")
                else:
                    classes.write("        ")
                classes.write("libxsltmod.%s(" % name)
                n = 0
                for arg in args:
                    if n != 0:
                        classes.write(", ")
                    if n != index:
                        classes.write("%s" % arg[0])
                        if arg[1] in classes_type:
                            classes.write("__o")
                        elif arg[1] in libxml2_classes_type:
                            classes.write("__o")
                    else:
                        classes.write("self")
                        if arg[1] in classes_type:
                            classes.write(classes_type[arg[1]][0])
                        elif arg[1] in libxml2_classes_type:
                            classes.write(libxml2_classes_type[arg[1]][0])
                    n = n + 1
                classes.write(")\n")
                if ret[0] != "void":
                    if ret[0] in classes_type:
                        classes.write("        if ret == None: return None\n")
                        classes.write("        return ")
                        classes.write(classes_type[ret[0]][1] % ("ret"))
                        classes.write("\n")
                    elif ret[0] in libxml2_classes_type:
                        classes.write("        if ret == None: return None\n")
                        classes.write("        return libxml2.")
                        classes.write(libxml2_classes_type[ret[0]][1] % ("ret"))
                        classes.write("\n")
                    elif ret[0] in converter_type:
                        classes.write("        if ret == None: return None\n")
                        classes.write("        return ")
                        classes.write(converter_type[ret[0]] % ("ret"))
                        classes.write("\n")
                    else:
                        classes.write("        return ret\n")
                classes.write("\n")

    #
    # Generate enum constants
    #
    for type,enum in list(enums.items()):
        classes.write("# %s\n" % type)
        items = list(enum.items())
        items.sort(key=lambda x: x[1])
        for name,value in items:
            classes.write("%s = %s\n" % (name,value))
        classes.write("\n");

    txt.close()
    classes.close()

buildStubs()
buildWrappers()
