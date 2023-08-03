<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output encoding="utf-8"/>
<xsl:template match="table">
  <table>
    <xsl:apply-templates select="row">
      <xsl:sort select="firstname"/>
    </xsl:apply-templates>
  </table>
</xsl:template>

<xsl:template match="*">
  <xsl:copy>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
