<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">


<xsl:template match="/">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="section">
    <xsl:value-of select="."/>
</xsl:template>

</xsl:stylesheet>
