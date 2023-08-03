<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
version="1.0">
  <xsl:output method="xml" indent="yes"/>

<xsl:template match="character">
  <xsl:apply-templates select="skills"/>
</xsl:template>

<xsl:template match="skills">
  <xsl:for-each select="./*">
    <xsl:value-of select="./@name"/>
    <xsl:text> </xsl:text>
  </xsl:for-each>
</xsl:template>
</xsl:stylesheet>
