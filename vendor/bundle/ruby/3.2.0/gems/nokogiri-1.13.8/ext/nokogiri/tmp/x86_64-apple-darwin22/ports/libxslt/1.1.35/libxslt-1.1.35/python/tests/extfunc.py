#!/usr/bin/python -u
import sys
import string
import libxml2
# Memory debug specific
libxml2.debugMemory(1)
import libxslt

nodeName = None

def f(ctx, str):
    global nodeName

    #
    # Small check to verify the context is correcly accessed
    #
    try:
        pctxt = libxslt.xpathParserContext(_obj=ctx)
        ctxt = pctxt.context()
        tctxt = ctxt.transformContext()
        nodeName = tctxt.insertNode().name
    except:
        pass

    return str.upper()

libxslt.registerExtModuleFunction("foo", "http://example.com/foo", f)

styledoc = libxml2.parseDoc("""
<xsl:stylesheet version='1.0'
  xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
  xmlns:foo='http://example.com/foo'
  exclude-result-prefixes='foo'>

  <xsl:param name='bar'>failure</xsl:param>
  <xsl:template match='/'>
    <article><xsl:value-of select='foo:foo($bar)'/></article>
  </xsl:template>
</xsl:stylesheet>
""")
style = libxslt.parseStylesheetDoc(styledoc)
doc = libxml2.parseDoc("<doc/>")
result = style.applyStylesheet(doc, { "bar": "'success'" })
style.freeStylesheet()
doc.freeDoc()

root = result.children
if root.name != "article":
    print("Unexpected root node name")
    sys.exit(1)
if root.content != "SUCCESS":
    print("Unexpected root node content, extension function failed")
    sys.exit(1)
if nodeName != 'article':
    print("The function callback failed to access its context")
    sys.exit(1)

result.freeDoc()

# Memory debug specific
libxslt.cleanup()
if libxml2.debugMemory(1) == 0:
    print("OK")
else:
    print("Memory leak %d bytes" % (libxml2.debugMemory(1)))
    libxml2.dumpMemory()
    sys.exit(255)
