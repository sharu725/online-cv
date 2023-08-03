<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="doc">
    <xsl:call-template name="docfound"/>
</xsl:template>

<xsl:template name="docfound">
<xsl:text>doc found</xsl:text>
</xsl:template>
</xsl:stylesheet>
