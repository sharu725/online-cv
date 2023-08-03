<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
version="1.0">
        <xsl:template match="/">
                <xsl:value-of select="//a/value"/> - <xsl:value-of
select="//b/value"/> - <xsl:value-of select="//c/value"/> =
<xsl:value-of select="//a/value - //b/value - //c/value"/>
<xsl:text>
</xsl:text>
                <xsl:apply-templates select="//c"/>
        </xsl:template>
        <xsl:template match="c">
                <xsl:value-of select="//a/value"/> - <xsl:value-of
select="//b/value"/> - <xsl:value-of select="value"/> = <xsl:value-of
select="//a/value - //b/value - value"/>
        </xsl:template>
</xsl:stylesheet>


