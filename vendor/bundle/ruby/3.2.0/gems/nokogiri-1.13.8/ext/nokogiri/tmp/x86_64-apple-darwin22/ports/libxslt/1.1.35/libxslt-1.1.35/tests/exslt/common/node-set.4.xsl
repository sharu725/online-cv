<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                version="1.0">

<xsl:key name="tmpls" match="xsl:template" use="@name"/>

<xsl:template match="/">
  <xsl:element name="initial">
    <xsl:text>Mode of FOO is </xsl:text>
    <xsl:value-of select="key('tmpls', 'FOO')/@mode"/>
  </xsl:element>

  <xsl:variable name="fiddle">
    <xsl:apply-templates select="//xsl:template"/>
  </xsl:variable>

  <xsl:apply-templates select="exsl:node-set($fiddle)" mode="faddle"/>
</xsl:template>

<xsl:template match="xsl:template">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:attribute name="mode">fiddled</xsl:attribute>
  </xsl:copy>
</xsl:template>

<xsl:template match="/" mode="faddle">
  <xsl:element name="post-transform">
    <xsl:text>Mode of FOO is </xsl:text>
    <xsl:value-of select="key('tmpls', 'FOO')/@mode"/>
  </xsl:element>
</xsl:template>

<xsl:template name="FOO" mode="input"/>

</xsl:stylesheet>
