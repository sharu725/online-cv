<xsl:stylesheet version="1.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<xsl:variable name="var" select="string('mark')"/>
<xsl:value-of select="$var"/>
</xsl:template>
</xsl:stylesheet>
