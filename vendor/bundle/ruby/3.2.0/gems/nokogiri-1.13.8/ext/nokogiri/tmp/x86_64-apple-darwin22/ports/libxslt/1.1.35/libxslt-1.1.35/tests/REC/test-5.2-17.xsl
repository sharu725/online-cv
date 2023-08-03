<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<xsl:apply-templates select="/doc/para/@*"/>
</xsl:template>
<xsl:template match="@class">
<xsl:text>Success</xsl:text>
</xsl:template>
</xsl:stylesheet>
