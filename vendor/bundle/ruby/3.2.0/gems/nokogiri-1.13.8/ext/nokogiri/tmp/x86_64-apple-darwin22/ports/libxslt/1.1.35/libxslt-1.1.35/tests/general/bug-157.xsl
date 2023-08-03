<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 

<xsl:template match="/"><xsl:apply-templates select="*" /></xsl:template>
<xsl:template match="foo/bar[last()=4]">
 4 <xsl:value-of select="." />
</xsl:template>                     
<xsl:template match="foo/bar[last()=3]">
 <xsl:message>last() was 3</xsl:message>
 3 <xsl:value-of select="." />
</xsl:template>
<xsl:template match="foo/bar[last()=2]">
 2 <xsl:value-of select="." />
</xsl:template>
<xsl:template match="foo/bar[last()=1]">
 1 <xsl:value-of select="." />
</xsl:template>

<xsl:template match="foo/bar" priority="-100">
  <xsl:message>last() was <xsl:value-of select="last()"/></xsl:message>
</xsl:template>
</xsl:stylesheet>
