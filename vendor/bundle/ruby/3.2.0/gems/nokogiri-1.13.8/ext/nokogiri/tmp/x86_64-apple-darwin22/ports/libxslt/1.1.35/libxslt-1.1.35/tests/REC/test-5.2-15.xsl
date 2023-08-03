<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="item[position() mod 2 = 1]">
Success
</xsl:template>
</xsl:stylesheet>
