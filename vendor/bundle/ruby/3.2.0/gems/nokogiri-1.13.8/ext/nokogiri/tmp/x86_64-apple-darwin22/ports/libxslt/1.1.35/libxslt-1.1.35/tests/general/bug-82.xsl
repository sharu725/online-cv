<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
version="1.0">
<xsl:preserve-space elements="*"/>
<xsl:strip-space elements="child"/>

<xsl:template match="*">
<xsl:text>(</xsl:text><xsl:apply-templates/><xsl:text>)</xsl:text>
</xsl:template>
</xsl:transform>



