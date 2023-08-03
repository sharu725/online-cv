<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:decimal-format name="f" grouping-separator="⠢"/>
  <xsl:template match="/">
    <xsl:value-of select="format-number(10,'#⠢0','f')"/>
  </xsl:template>
</xsl:stylesheet>
