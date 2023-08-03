<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<xsl:variable name="foo" select="'1'"/>

<xsl:template name="test">
<xsl:param name="foo" select="'2'"/>
<xsl:choose>
    <xsl:when test="$foo = '0'">
        <xsl:text>SUCCESS</xsl:text>
    </xsl:when>
    <xsl:otherwise>
        <xsl:text>FAILURE </xsl:text>
	<xsl:value-of select="$foo"/>
    </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="/">
<xsl:variable name="foo" select="'3'"/>
<xsl:call-template name="test">
    <xsl:with-param name="foo" select="'0'"/>
</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
