#!/usr/bin/python -u
import sys
import libxml2
# Memory debug specific
libxml2.debugMemory(1)
import libxslt


styledoc = libxml2.parseDoc(
"""<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:str="http://exslt.org/strings"
    exclude-result-prefixes="str">

<xsl:template match="/">
<out>;
  str:tokenize('2001-06-03T11:40:23', '-T:')
  <xsl:copy-of select="str:tokenize('2001-06-03T11:40:23', '-T:')"/>;

  str:tokenize('date math str')
  <xsl:copy-of select="str:tokenize('date math str')"/>;
</out>
</xsl:template>

</xsl:stylesheet>
""")
style = libxslt.parseStylesheetDoc(styledoc)
doc = libxml2.parseDoc("<doc/>")
result = style.applyStylesheet(doc, None)
stringval = style.saveResultToString(result)
style.freeStylesheet()
doc.freeDoc()
result.freeDoc()

expect="""<?xml version="1.0"?>
<out>;
  str:tokenize('2001-06-03T11:40:23', '-T:')
  <token>2001</token><token>06</token><token>03</token><token>11</token><token>40</token><token>23</token>;

  str:tokenize('date math str')
  <token>date</token><token>math</token><token>str</token>;
</out>
"""

if stringval != expect:
  print("Exslt processing failed")
  sys.exit(255)

# Memory debug specific
libxslt.cleanup()
if libxml2.debugMemory(1) == 0:
    print("OK")
else:
    print("Memory leak %d bytes" % (libxml2.debugMemory(1)))
    libxml2.dumpMemory()
    sys.exit(255)
