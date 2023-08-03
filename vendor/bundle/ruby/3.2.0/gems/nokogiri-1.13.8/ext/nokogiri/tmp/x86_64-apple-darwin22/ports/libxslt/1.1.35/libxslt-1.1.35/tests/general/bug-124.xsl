<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:mml="http://example.org/foobar"
                version="1.0">
  <xsl:strip-space elements="mml:*"/>
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
<xsl:template match="*">
  <xsl:copy>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>
</xsl:stylesheet>
