<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="doc">
    <xsl:apply-templates select=".//div"/>
</xsl:template>
<xsl:template match="div">
<xsl:text>div found </xsl:text>
</xsl:template>
</xsl:stylesheet>
