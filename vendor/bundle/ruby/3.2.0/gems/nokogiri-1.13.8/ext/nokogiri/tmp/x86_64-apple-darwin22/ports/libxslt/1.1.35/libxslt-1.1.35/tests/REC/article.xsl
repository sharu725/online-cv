<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="article">
<h3><xsl:value-of select="title"/></h3>
<xsl:apply-templates select="para"/>
</xsl:template>
<xsl:template match="para">
<p><xsl:apply-templates/>
</p>
</xsl:template>
</xsl:stylesheet>
