<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:variable name="my.var">old-value</xsl:variable>
  <xsl:variable name="my.var">the-value</xsl:variable>
  <xsl:template match="/">
    <xsl:value-of select="$my.var"/>
  </xsl:template>
</xsl:stylesheet>
