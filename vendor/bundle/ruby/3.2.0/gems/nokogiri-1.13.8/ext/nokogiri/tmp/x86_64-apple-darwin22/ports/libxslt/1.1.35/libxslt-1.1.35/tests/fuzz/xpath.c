/*
 * xpath.c: libFuzzer target for XPath expressions
 *
 * See Copyright for the status of this software.
 */

#include "fuzz.h"

int
LLVMFuzzerInitialize(int *argc_p, char ***argv_p) {
    return xsltFuzzXPathInit(argc_p, argv_p, NULL);
}

int
LLVMFuzzerTestOneInput(const char *data, size_t size) {
    xmlXPathObjectPtr xpathObj = xsltFuzzXPath(data, size);
    xsltFuzzXPathFreeObject(xpathObj);

    return 0;
}
