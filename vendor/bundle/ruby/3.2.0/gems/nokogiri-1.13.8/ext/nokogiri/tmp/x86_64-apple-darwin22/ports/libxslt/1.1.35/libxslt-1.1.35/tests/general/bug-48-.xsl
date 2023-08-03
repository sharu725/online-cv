<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<xsl:template name="empty">
</xsl:template>

<xsl:template name="test">
<xsl:text>SUCCESS</xsl:text>
</xsl:template>

<xsl:template match="/">
<xsl:variable name="foo">
<xsl:call-template name="test"/>
</xsl:variable>
<xsl:if test="1">
<xsl:apply-templates select="doc" name="empty">
<xsl:with-param name="unused" select="$foo"/>
</xsl:apply-templates>
</xsl:if>
<xsl:value-of select="$foo"/>
</xsl:template>

</xsl:stylesheet>
