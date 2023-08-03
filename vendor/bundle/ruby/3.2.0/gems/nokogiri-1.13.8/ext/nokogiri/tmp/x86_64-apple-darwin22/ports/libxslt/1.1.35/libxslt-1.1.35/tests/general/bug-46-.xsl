<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<xsl:template name="test">
<xsl:text>SUCCESS</xsl:text>
</xsl:template>

<xsl:template match="/">
<xsl:variable name="foo">
<xsl:call-template name="test"/>
</xsl:variable>
<xsl:value-of select="$foo"/>
</xsl:template>

</xsl:stylesheet>
