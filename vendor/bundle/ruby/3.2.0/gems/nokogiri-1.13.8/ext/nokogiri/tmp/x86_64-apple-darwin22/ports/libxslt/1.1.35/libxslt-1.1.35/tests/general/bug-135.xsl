<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
<xsl:key name="test" match="node()[self::sect][h1[h2]|h2]" use="'test'" />

<xsl:template match="/">
  <result><xsl:value-of select="count(key('test','test'))" /></result>
</xsl:template>

</xsl:stylesheet>
