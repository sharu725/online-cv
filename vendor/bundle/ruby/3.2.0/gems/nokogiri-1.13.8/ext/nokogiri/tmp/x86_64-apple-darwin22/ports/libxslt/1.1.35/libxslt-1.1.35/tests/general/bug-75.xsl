<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<xsl:value-of select="format-number(100000000000,'#,##0.##')"/>|
<xsl:value-of select="format-number(2147483647,'#,##0.##')"/>|
<xsl:value-of select="format-number(2147483648,'#,##0.##')"/>|
<xsl:value-of select="format-number(4294967296,'#,##0.##')"/>|
</xsl:template>
</xsl:stylesheet>
