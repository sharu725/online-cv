<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:bbb="test:7">

  <xsl:template match="aaa">
    <xsl:value-of select="@bbb:ddd"/>
    <xsl:value-of select="@eee"/>
  </xsl:template>

</xsl:stylesheet>
