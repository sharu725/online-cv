<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="bug-62-inc.xsl"/>
  <xsl:variable name="my.var">the-value</xsl:variable>
  <xsl:template match="/">
    <xsl:value-of select="$my.var"/>
  </xsl:template>
</xsl:stylesheet>
