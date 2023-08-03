<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="text[2]">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="text()"/>
</xsl:transform>
