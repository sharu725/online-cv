<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0">

<xsl:template match="/">
  <xsl:value-of select="id('h�llo')"/>
  <xsl:apply-templates/>
</xsl:template>
<xsl:template match="id('h�llo')">
WORKS TOO
</xsl:template>
<xsl:template match="dest">
</xsl:template>

</xsl:stylesheet>
