<xsl:stylesheet version="1.0"
	      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	      xmlns:ex="http://example.org/">

<xsl:output method="xml"
	      encoding="UTF-8"
	      doctype-public="-//example.org//Example 1.0//EN"/>
 
<xsl:template match="/tst">
  <ex:document xmlns:ex="http://example.org/">
    <xsl:apply-templates match="doc"/>
  </ex:document>
</xsl:template>

</xsl:stylesheet>
