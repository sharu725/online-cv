<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  exclude-result-prefixes="exsl"
  extension-element-prefixes="exsl"
  version="1.0">

<xsl:template match="/">
  <xsl:variable name="tds">
  <row>
  <cell>a</cell>
  <cell>b</cell>
  <cell>c</cell>
  <cell>d</cell>
  </row>
 </xsl:variable>
 <xsl:for-each select="exsl:node-set($tds)/row/cell">
  <xsl:value-of select="."/>
 </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
