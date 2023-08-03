#!/usr/bin/python -u
import sys
import string
import libxml2
# Memory debug specific
libxml2.debugMemory(1)
import libxslt

EXT_URL="http://example.com/foo"

insertNodeName = None
transformNodeName = None

def compile_test(style, inst, func):
    pass

def transform_test(ctx, node, inst, comp):
    global insertNodeName

    #
    # Small check to verify the context is correcly accessed
    #
    try:
        #
        # FIXME add some more sanity checks
        #
        tctxt = libxslt.transformCtxt(_obj=ctx)
        insertNodeName = tctxt.insertNode().name

        # FIXME find and confirm the note being replaced is called 'test'
        # transformNodeName = libxml2.xmlNode(inst).name
    except:
        pass

    tctxt.insertNode().addContent('SUCCESS')
    


styledoc = libxml2.parseDoc("""
<xsl:stylesheet version='1.0'
  xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
  xmlns:foo='%s'
  extension-element-prefixes='foo'>

  <xsl:template match='/'>
    <article><foo:test>FAILURE</foo:test></article>
    <deeper><article><foo:test>something<foo:test>nested</foo:test>even</foo:test></article></deeper>
  </xsl:template>
</xsl:stylesheet>
""" % EXT_URL)

style = libxslt.parseStylesheetDoc(styledoc)
libxslt.registerExtModuleElement("test", EXT_URL, compile_test, transform_test)
doc = libxml2.parseDoc("<doc/>")
result = style.applyStylesheet(doc, None)
style.freeStylesheet()
doc.freeDoc()

root = result.children

if root.name != "article":
    print("Unexpected root node name")
    sys.exit(1)
if root.content != "SUCCESS":
    print("Unexpected root node content, extension function failed")
    sys.exit(1)
if insertNodeName != 'article':
    print("The function callback failed to access its context")
    sys.exit(1)

result.dump(sys.stdout)
result.freeDoc()

# Memory debug specific
libxslt.cleanup()
if libxml2.debugMemory(1) == 0:
    print("OK")
else:
    print("Memory leak %d bytes" % (libxml2.debugMemory(1)))
    libxml2.dumpMemory()
    sys.exit(255)
