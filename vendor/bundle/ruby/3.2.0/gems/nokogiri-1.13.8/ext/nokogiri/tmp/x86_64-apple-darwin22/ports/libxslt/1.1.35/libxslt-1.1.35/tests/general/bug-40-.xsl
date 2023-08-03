<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<xsl:variable name="foo" select="'SUCCESS'"/>

<xsl:template name="test">
<xsl:value-of select="$foo"/>
</xsl:template>

<xsl:template match="/">
<xsl:variable name="foo" select="'FAILURE'"/>
<xsl:call-template name="test"/>
</xsl:template>

</xsl:stylesheet>
