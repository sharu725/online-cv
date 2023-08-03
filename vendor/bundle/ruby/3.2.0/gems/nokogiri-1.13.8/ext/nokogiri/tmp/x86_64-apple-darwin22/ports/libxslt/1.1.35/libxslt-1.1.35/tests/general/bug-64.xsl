<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="@*|node()" priority="1">
    <xsl:text>It is broken!</xsl:text>
  </xsl:template>
  <xsl:template match="/" priority="2">
    <xsl:text>It works!</xsl:text>
  </xsl:template>
</xsl:stylesheet>
