<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output encoding="utf-8"/>

<xsl:attribute-set name="attset1">
  <xsl:attribute name="att1">foo</xsl:attribute>
  <xsl:attribute name="att2">bar</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="attset2">
  <xsl:attribute name="att3">baz</xsl:attribute>
  <xsl:attribute name="att4">quux</xsl:attribute>
</xsl:attribute-set>

<xsl:template match="salesdata|year">
  <xsl:copy use-attribute-sets="attset1">
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="region">
  <xsl:copy use-attribute-sets="attset2">
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="name|sales">
  <xsl:copy use-attribute-sets="attset1 attset2">
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
