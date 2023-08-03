<xsl:transform version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="E/text()[ 1 ]">
    <xsl:value-of select="substring-before( . , ' ')"/>
    <xsl:text> * </xsl:text>
    <xsl:value-of select="substring-after( . , ' ')"/>
  </xsl:template>
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:transform>
