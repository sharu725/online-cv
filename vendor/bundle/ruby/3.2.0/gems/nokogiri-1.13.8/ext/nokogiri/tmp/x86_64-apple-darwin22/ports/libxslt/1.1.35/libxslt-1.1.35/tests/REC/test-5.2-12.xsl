<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:strip-space elements="doc"/>
<xsl:template match="*[position()=1 and self::para]">
Success
</xsl:template>
</xsl:stylesheet>
