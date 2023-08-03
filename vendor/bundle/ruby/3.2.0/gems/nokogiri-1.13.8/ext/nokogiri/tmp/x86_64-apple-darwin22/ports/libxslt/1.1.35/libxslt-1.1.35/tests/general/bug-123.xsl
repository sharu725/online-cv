<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="@*">
  <xsl:copy/>
</xsl:template>
<xsl:template match="element">
  <xsl:copy>
    <xsl:attribute name="foo">xsl</xsl:attribute>
    <xsl:apply-templates select="@*"/>
  </xsl:copy>
</xsl:template>
</xsl:stylesheet>

