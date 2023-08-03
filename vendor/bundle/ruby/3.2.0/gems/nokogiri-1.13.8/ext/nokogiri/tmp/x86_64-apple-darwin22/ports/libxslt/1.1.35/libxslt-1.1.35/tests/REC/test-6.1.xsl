<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- reject this XSLT named templates should have unique template name + nameURI combinations -->

<xsl:template match="doc">
    <xsl:call-template name="duplicateTemplateName"/>
</xsl:template>
<xsl:template name="duplicateTemplateName">
<xsl:text>XSLT should be rejected</xsl:text>
</xsl:template>
<xsl:template name="duplicateTemplateName">
<xsl:text>XSLT should be rejected</xsl:text>
</xsl:template>
</xsl:stylesheet>
