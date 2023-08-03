<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<xsl:variable name="foo" select="'SUCCESS'"/>

<!-- Global var shouldn't be changed by call with param -->
<xsl:template match="doc">
<xsl:value-of select="$foo"/>
</xsl:template>

<xsl:template match="/">
<xsl:variable name="foo" select="'FAILURE'"/>
<xsl:apply-templates>
    <xsl:with-param name="foo" select="'FAILURE'"/>
</xsl:apply-templates>
</xsl:template>

</xsl:stylesheet>
