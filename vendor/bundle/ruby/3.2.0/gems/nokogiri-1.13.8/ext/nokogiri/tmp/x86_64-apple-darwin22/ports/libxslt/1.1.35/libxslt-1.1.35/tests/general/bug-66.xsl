<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0" exclude-result-prefixes="xlink">
  <xsl:strip-space elements="*"/>
  <xsl:template match="/">
    <xsl:apply-templates select="test/tr[1]"/>
  </xsl:template>
  <xsl:template match="tr">
    <nb>
      <xsl:value-of select="count(/test/tr[. = current()])"/>
    </nb>
  </xsl:template>
</xsl:stylesheet>
