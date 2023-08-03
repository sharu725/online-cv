<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="bug-137.imp"/>
  <xsl:template match="/">
    <result><xsl:value-of select="key('mykey', 'T')"/></result>
  </xsl:template>
</xsl:stylesheet>
